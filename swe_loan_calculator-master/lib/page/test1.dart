import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe_loan_calculator/src/shoppingmalls.dart' as ShoppingMalls;
import 'package:swe_loan_calculator/src/HDBListings.dart' as HDBListings;
//test

void main() {
  runApp(FullDetailsView());
}
class FullDetailsView extends StatefulWidget {
  @override
  HelpPageState createState() => HelpPageState();
}

class HelpPageState extends State<FullDetailsView> {
  final hdbListings = HDBListings.getHDBListing();
  final String street="TAMPINES AVE 4";
  final String block='946';
  final String town="TAMPINES";
  final String storey_range="01 TO 03";
  final double floor_area_sqm=104.0;
  final String flat_model="Model A";
  final double lease_commence_date=1988;
  final String remaining_lease="69 years 03 months";
  final double resale_price=435000.0;
  final double longitude=103.9401;
  final double latitude=1.35168;
  final Map<String, Marker> _markers = {};
  GoogleMapController controller;


  Future<void> _onMapCreated(GoogleMapController controller) async {
    final shoppingMalls = await ShoppingMalls.getShoppingMalls();
    setState(() {
      _markers.clear();
      for (final mall in shoppingMalls.malls) {
        final marker = Marker(
          markerId: MarkerId(mall.name),
          position: LatLng(mall.lat, mall.lng),
          infoWindow: InfoWindow(
            title: mall.name,
            snippet: 'Shopping Mall',
          ),
        );
        _markers[mall.name] = marker;
      }
     });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:Scaffold(
      appBar: AppBar(
        title: Text('Property View'),
        backgroundColor: Colors.blue[700],
      ),
      body: GestureDetector(
        child: _detailsBody(),
      ),
    ),
    );
  }

  Widget _detailsBody() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
      children: [Text('Resale price: $resale_price',
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25, color: Colors.black87),
        textAlign: TextAlign.left,
      ),
        Text('Address: $street $block',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black87),
          textAlign: TextAlign.left,
        ),
        Text('Type: $flat_model',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Colors.black45),
          textAlign: TextAlign.left,
        ),
        Text('Area: $town',
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
              TextSpan(text: '$floor_area_sqm sqm', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.black54))
            ],
          ),
            textAlign : TextAlign.center,
        ),
        RichText(
          text: TextSpan(
            text: 'Remaining Lease: ',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15, color: Colors.black87),
            children: <TextSpan>[
              TextSpan(text: '$remaining_lease', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.black54))
            ],
          ),
          textAlign : TextAlign.center,
        ),
        _Map(
          center: const LatLng(1.36192,103.95513),
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
          zoomGesturesEnabled: false,
          rotateGesturesEnabled: false,
          tiltGesturesEnabled: false,
          scrollGesturesEnabled: false,
        ),
      ),
    );
  }
}
