import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe_loan_calculator/src/HDBListings.dart' as HDBListings;
import 'package:swe_loan_calculator/controller/MapPageController.dart' as mappagecontroller;
import 'package:swe_loan_calculator/model/MapModel.dart' as mapmodel;

/// Class to organise the display of Filtered HDB Listings on a GoogleMap
class MapPageView extends State<mappagecontroller.MapPageController> {
  /// List of HDB Listings that fit within Filter Conditions
  List<HDBListings.HDBListing> filtered_hdb;
  /// List of markers to highlight the exact location of Filtered HDB Listings on a Map
  final Map<String, Marker> _markers = {};
  /// Controller to control logic of displaying Google Map using Google Maps API
  GoogleMapController controller;
  /// Function to set markers on Google Map
  Future<void> _onMapCreated(GoogleMapController controller) async {

    filtered_hdb = await ModalRoute.of(context).settings.arguments;
    //print('FILTERED HDB MAP VIEW WORKING');
    //print(filtered_hdb[3].longitude);
    // final googleOffices = await locations.getHDBListing();
    setState(() {
      _markers.clear();
      for (final office in filtered_hdb) {
        final marker = Marker(
          markerId: MarkerId(office.address),
          position: LatLng(office.latitude, office.longitude),
          infoWindow: InfoWindow(
            title: office.address,
            snippet: '\$' + office.resale_price.toString(),
          ),
        );
        _markers[office.address] = marker;
      }
    });
  }


  /// Function to organise display of entire Map Page
  @override
  Widget build(BuildContext context) {


    return MaterialApp(home:Scaffold(
      appBar: AppBar(
        title: Text('Map View'),
        backgroundColor: Colors.blue[700],
      ),
      body: GestureDetector(
        child: mapmodel.MapModel(
          center: const LatLng(1.32787,103.84421),
          mapController: controller,
          onMapCreated: _onMapCreated,
          markers: _markers,
        ),
      ),
    ),
    );
  }
  /// Function to organise the display of Google Map and markers of filtered HDB Listings
  Widget _detailsBody() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
      children: [
        mapmodel.MapModel(
          center: const LatLng(1.326124169,103.8437095),
          mapController: controller,
          onMapCreated: _onMapCreated,
          markers: _markers,
        ),      ],
    );
  }


}