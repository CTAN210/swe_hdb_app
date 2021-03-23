import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe_loan_calculator/src/HDBListings.dart' as HDBListings;


class MapPage extends StatelessWidget{
  MapPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MapPageView(),
      ),
    );
  }
}
class MapPageView extends StatefulWidget {

  @override
  MapState createState() => MapState();
}
class MapState extends State<MapPageView> {

  List<HDBListings.HDBListing> filtered_hdb;

  final Map<String, Marker> _markers = {};
  GoogleMapController controller;

  Future<void> _onMapCreated(GoogleMapController controller) async {

    filtered_hdb = await ModalRoute.of(context).settings.arguments;
    print('abc');
    print(filtered_hdb[3].longitude);
    // final googleOffices = await locations.getHDBListing();
    setState(() {
      _markers.clear();
      for (final office in filtered_hdb) {
        final marker = Marker(
          markerId: MarkerId(office.address),
          position: LatLng(office.latitude, office.longitude),
          infoWindow: InfoWindow(
            title: office.address,
            snippet: r'$''{$office.resale_price.toString()}',
          ),
        );
        _markers[office.address] = marker;
      }
    });
  }



  @override
  Widget build(BuildContext context) {




    return MaterialApp(home:Scaffold(
      appBar: AppBar(
        title: Text('Map View'),
        backgroundColor: Colors.blue[700],
      ),
      body: GestureDetector(
        child:         _Map(
          center: const LatLng(1.32787,103.84421),
          mapController: controller,
          onMapCreated: _onMapCreated,
          markers: _markers,
        ),
      ),
    ),
    );
  }

  Widget _detailsBody() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
      children: [
        _Map(
          center: const LatLng(1.326124169,103.8437095),
          mapController: controller,
          onMapCreated: _onMapCreated,
          markers: _markers,
        ),      ],
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
    return MaterialApp(
      home:Scaffold(

        body: GoogleMap(
          onMapCreated: onMapCreated,
          initialCameraPosition: CameraPosition(
            target: center,
            zoom: 20,
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