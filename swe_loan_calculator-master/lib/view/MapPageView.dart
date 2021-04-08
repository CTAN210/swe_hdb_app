import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe_loan_calculator/src/HDBListings.dart' as HDBListings;
import 'package:swe_loan_calculator/controller/MapPageController.dart'
    as mappagecontroller;
import 'package:swe_loan_calculator/model/MapModel.dart' as mapmodel;
import 'package:swe_loan_calculator/controller/FilterController.dart'
    as filtercontroller;
import 'package:swe_loan_calculator/view/FilterView.dart' as filterview;
import 'package:swe_loan_calculator/main.dart';

/// Class to organise the display of Filtered HDB Listings on a GoogleMap
class MapPageView extends State<mappagecontroller.MapPageController> {
  /// List of HDB Listings that fit within Filter Conditions
  List<HDBListings.HDBListing> filtered_hdb;
/*  BitmapDescriptor pinLocationIcon;
  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }
  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/house.png');
  }*/
  /// List of markers to highlight the exact location of Filtered HDB Listings on a Map
  final Map<String, Marker> _markers = {};

  /// Controller to control logic of displaying Google Map using Google Maps API
  GoogleMapController controller;

  /// Function to set markers on Google Map
  Future<void> _onMapCreated(GoogleMapController controller) async {
    filtered_hdb = await ModalRoute.of(context).settings.arguments;
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
          // icon: pinLocationIcon,
        );
        _markers[office.address] = marker;
      }
    });
  }

  /// Function to organise display of entire Map Page
  @override
  Widget build(BuildContext context) {
    filterview.FilterView FilterViewInstance = filterview.FilterView();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Map View'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/first', (_) => false);
              },
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              filtercontroller.FilterController(
                                  ViewAllListings: MyApp.getCount())));
                },
              );
            },
          ),
          backgroundColor: Colors.blue[700],
        ),
        body: GestureDetector(
          child: mapmodel.MapModel(
            center: const LatLng(1.32787, 103.84421),
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
          center: const LatLng(1.326124169, 103.8437095),
          mapController: controller,
          onMapCreated: _onMapCreated,
          markers: _markers,
        ),
      ],
    );
  }
}
