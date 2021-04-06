import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe_loan_calculator/src/HDBListings.dart' as HDBListings;
import 'package:swe_loan_calculator/src/shoppingmalls.dart' as ShoppingMalls;
import 'package:swe_loan_calculator/controller/FullDetailsController.dart' as fulldetailscontroller;
import 'package:swe_loan_calculator/model/MapModel.dart' as mapmodel;


/// Class to organise the display of Full Details of a HDB Listing
class FullDetailsView extends State<fulldetailscontroller.FullDetailsController> {
  /// Marker to display exact location of a HDB Listing on the Proximity Map
  final Marker HDBMarker = Marker();
  /// Specific HDB Listing to be displayed
  HDBListings.HDBListing hdb;

  /// Markers to display exact locations of Shopping Malls in Singapore
  final Map<String, Marker> _markers = {};

  /// Controller to control logic of displaying Proximity Map using Google Maps API
  GoogleMapController controller;

  /// Function to set markers on Proximity Map
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final shoppingMalls = await ShoppingMalls.getShoppingMalls();
    setState(() {
      _markers.clear();
      final HDBMarker = Marker(
        markerId: MarkerId(hdb.address),
        position: LatLng(hdb.latitude,hdb.longitude),
        infoWindow: InfoWindow(title: hdb.address, snippet: "HDB Listing"),

      );
      _markers[hdb.address] = HDBMarker;
    });
  }
  /// Function to organise display of entire Full Details Page
  @override
  Widget build(BuildContext context) {

    hdb = ModalRoute.of(context).settings.arguments;
    print(hdb.latitude.toString() + ',' + hdb.longitude.toString());


    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title: Text('Property View'),
          backgroundColor: Colors.green[700],
        ),
        body: GestureDetector(
          child: _detailsBody(hdb),
        ),
      ),
    );
  }

  /// Function to organise the display of details extracted from specific HDB Listing
  Widget _detailsBody(hdb) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
      children: [Text('Resale price: ' + hdb.resale_price.toString(),
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25, color: Colors.black87),
        textAlign: TextAlign.left,
      ),
        Text('Address: ' + hdb.address,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black87),
          textAlign: TextAlign.left,
        ),
        Text('Type: ' + hdb.flat_type,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Colors.black45),
          textAlign: TextAlign.left,
        ),
        Text('Area: ' + hdb.town,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Colors.black45),
          textAlign: TextAlign.left,
        ),
        Text('Property Details',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Colors.black87),
          textAlign: TextAlign.left,
        ),

        RichText(
          text: TextSpan(
            text: 'Size: ',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15, color: Colors.black87),
            children: <TextSpan>[
              TextSpan(text: '${hdb.floor_area_sqm} sqm', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.black54))
            ],
          ),
          textAlign : TextAlign.center,
        ),
        RichText(
          text: TextSpan(
            text: 'Remaining Lease: ',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15, color: Colors.black87),
            children: <TextSpan>[
              TextSpan(text: '${hdb.remaining_lease}', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.black54))
            ],
          ),
          textAlign : TextAlign.center,
        ),

        mapmodel.MapModel(
          center: LatLng(hdb.latitude, hdb.longitude),
          mapController: controller,
          onMapCreated: _onMapCreated,
          markers: _markers,
        ),
      ],
    );
  }


}
