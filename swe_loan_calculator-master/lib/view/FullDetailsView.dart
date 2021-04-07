import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe_loan_calculator/src/HDBListings.dart' as HDBListings;
import 'package:swe_loan_calculator/src/shoppingmalls.dart' as ShoppingMalls;
import 'package:swe_loan_calculator/controller/FullDetailsController.dart' as fulldetailscontroller;
import 'package:swe_loan_calculator/model/MapModel.dart' as mapmodel;
import 'package:swe_loan_calculator/view/FilterView.dart' as filterview;
import 'package:swe_loan_calculator/controller/LoanCalController.dart' as loancalcontroller;





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

    filterview.FilterView FilterViewInstance = filterview.FilterView();


    hdb = widget.hdb;
    print('========Selected HDB Details======== ' + '\n' +
        'Resale Price: ' + '\$' + hdb.resale_price.toString() + '\n' +
        'Address: ' + hdb.address + '\n' +
        'Remaining Lease: ' + hdb.remaining_lease.toString() + '\n' +
        'Floor Area: ' + hdb.floor_area_sqm.toString() + '\n' +
        'Flat Type: ' + hdb.flat_type);


    return Scaffold(
        appBar: AppBar(
          title: Text('Property View'),
          backgroundColor: Colors.blue[700],
        ),
        body: GestureDetector(
          child: _detailsBody(hdb),
        ),
      );
  }

  /// Function to organise the display of details extracted from specific HDB Listing
  Widget _detailsBody(hdb) {

    return
      Container(
        decoration: BoxDecoration(border: Border.all()),
        padding: EdgeInsets.all(15),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.tealAccent,
                  border: null,
                ),
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      title: Text('Resale Price: ' + '\$' +
                          hdb.resale_price.toString() +
                          '\n' +
                          hdb.address,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                          textAlign: TextAlign.left),
                      trailing: Wrap(
                        spacing:0,
                        children: <Widget>[SizedBox(
                          height: 100,
                          width: 100,
                          child:
                          IconButton(
                              icon: Image.asset('assets/images/calculator.png'),
                              iconSize: 500,
                              alignment: Alignment.topRight,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => loancalcontroller.LoanCalController(presetPrincipal: hdb.resale_price,),
                                  ),

                                );
                              }
                          ),
                        ),
                        ],
                      ),

                    ),
                  ],
                )),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.green,
                border: null,
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Type: ' + hdb.flat_type,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  Text('Area: ' + hdb.town,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),],),),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent,
                border: null,
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Property Details:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black87),
                    textAlign: TextAlign.left,
                  ),

                  RichText(
                    text: TextSpan(
                      text: 'Size: ',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.black87),
                      children: <TextSpan>[
                        TextSpan(text: '${hdb.floor_area_sqm} sqm', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18, color: Colors.black54))
                      ],
                    ),
                    textAlign : TextAlign.center,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Remaining Lease: ',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.black87),
                      children: <TextSpan>[
                        TextSpan(text: '${hdb.remaining_lease}', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18, color: Colors.black54))
                      ],
                    ),
                    textAlign : TextAlign.center,
                  ),
                ],),),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              elevation: 4,
              child: SizedBox(
                width: 340,
                height: 240,
                child:
                mapmodel.MapModel(
                  center: LatLng(hdb.latitude, hdb.longitude),
                  mapController: controller,
                  onMapCreated: _onMapCreated,
                  markers: _markers,
                ),
              ),
            ),
          ],
        ),
      );


  }


}
