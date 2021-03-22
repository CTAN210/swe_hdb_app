import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe_loan_calculator/src/shoppingmalls.dart' as ShoppingMalls;
import 'package:swe_loan_calculator/src/HDBListings.dart' as HDBListings;


void main() {
  runApp(FullDetailsView());
}
class FullDetailsView extends StatefulWidget {
  @override
  FullDetailsState createState() => FullDetailsState();
}

class FullDetailsState extends State<FullDetailsView> {

  final Marker HDBmarker = Marker();

  HDBListings.HDBListing hdb;


  final Map<String, Marker> _markers = {};


  GoogleMapController controller;


  Future<void> _onMapCreated(GoogleMapController controller) async {
    final shoppingMalls = await ShoppingMalls.getShoppingMalls();
    setState(() {
      _markers.clear();
      /*for (final mall in shoppingMalls.malls) {
        final marker = Marker(
          markerId: MarkerId(mall.name),
          position: LatLng(mall.lat, mall.lng),
          infoWindow: InfoWindow(
            title: mall.name,
            snippet: 'Shopping Mall',
          ),
        );
        _markers[mall.name] = marker;
      }*/
      final HDBMarker = Marker(
          markerId: MarkerId(hdb.address),
          position: LatLng(hdb.latitude,hdb.longitude),
          infoWindow: InfoWindow(title: hdb.address, snippet: "HDB Listing"),

      );
      _markers[hdb.address] = HDBMarker;
    });
  }
  @override
  Widget build(BuildContext context) {

    hdb = ModalRoute.of(context).settings.arguments;
    //print(hdb.town);


    return MaterialApp(home:Scaffold(
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

  Widget _detailsBody(hdb) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
      children: [Text('Resale price: ${hdb.resale_price}',
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25, color: Colors.black87),
        textAlign: TextAlign.left,
      ),
        Text('Address: ${hdb.address}',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black87),
          textAlign: TextAlign.left,
        ),
        Text('Type: ${hdb.flat_model}',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Colors.black45),
          textAlign: TextAlign.left,
        ),
        Text('Area: ${hdb.town}',
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
        _Map(
          center: LatLng(hdb.latitude, hdb.longitude), // replace this
          mapController: controller,
          onMapCreated: _onMapCreated,
          markers: _markers,
        ),
      ],
    );
  }


}
class _Map extends StatelessWidget {
  final LatLng center;

  final GoogleMapController mapController;
  final ArgumentCallback<GoogleMapController> onMapCreated;
  final Map<String, Marker> markers;
  const _Map({
    @required this.center,
    @required this.mapController,
    @required this.onMapCreated,
    @required this.markers,
    Key key,
  })  : assert(center != null),
        assert(onMapCreated != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      elevation: 4,
      child: SizedBox(
        width: 340,
        height: 240,
        child: GoogleMap(
          onMapCreated: onMapCreated,
          initialCameraPosition: CameraPosition(
            target: center,
            zoom: 16,
          ),
          markers: markers.values.toSet(),
        ),
      ),
    );
  }
}