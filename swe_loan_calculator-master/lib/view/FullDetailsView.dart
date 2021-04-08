import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe_loan_calculator/src/HDBListings.dart' as HDBListings;
import 'package:swe_loan_calculator/controller/FullDetailsController.dart'
    as fulldetailscontroller;
import 'package:swe_loan_calculator/model/MapModel.dart' as mapmodel;
import 'package:swe_loan_calculator/view/FilterView.dart' as filterview;
import 'package:swe_loan_calculator/controller/LoanCalController.dart'
    as loancalcontroller;
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

/// Class to organise the display of Full Details of a HDB Listing
class FullDetailsView
    extends State<fulldetailscontroller.FullDetailsController> {
  /// Marker to display exact location of a HDB Listing on the Proximity Map
  final Marker HDBMarker = Marker();
  /*BitmapDescriptor pinLocationIcon;
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
  /// Specific HDB Listing to be displayed
  HDBListings.HDBListing hdb;

  /// Markers to display exact locations of Shopping Malls in Singapore
  final Map<String, Marker> _markers = {};

  /// Controller to control logic of displaying Proximity Map using Google Maps API
  GoogleMapController controller;

  ///attribute to determine which widgets to be included in the screenshot
  ScreenshotController screenshotController = ScreenshotController();

  /// Function to set markers on Proximity Map
  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.clear();
      final HDBMarker = Marker(
        markerId: MarkerId(hdb.address),
        position: LatLng(hdb.latitude, hdb.longitude),
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
    print('========Selected HDB Details======== ' +
        '\n' +
        'Resale Price: ' +
        '\$' +
        hdb.resale_price.toString() +
        '\n' +
        'Address: ' +
        hdb.address +
        '\n' +
        'Remaining Lease: ' +
        hdb.remaining_lease.toString() +
        '\n' +
        'Floor Area: ' +
        hdb.floor_area_sqm.toString() +
        '\n' +
        'Flat Type: ' +
        hdb.flat_type);

    return Scaffold(
      appBar: AppBar(title: Text('Property View'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/first', (_) => false);
          },
        ),
        IconButton(
          icon: const Icon(Icons.ios_share),
          onPressed: () {
            _takeScreenshotandShare();
          },
        ),
      ]),
      body: GestureDetector(
          child: Screenshot(
        controller: screenshotController,
        child: _detailsBody(hdb),
      )),
    );
  }

  /// Function to organise the display of details extracted from specific HDB Listing
  Widget _detailsBody(hdb) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(border: Border.all()),
      padding: EdgeInsets.all(20),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: CupertinoColors.systemGrey5,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('\$' + hdb.resale_price.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.black)),
                          SizedBox(height: 10),
                          Text(hdb.address,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black)),
                          SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              text: 'Town:          ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black87),
                              children: <TextSpan>[
                                TextSpan(
                                    text: hdb.town,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black54))
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              text: 'Flat Type:   ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black87),
                              children: <TextSpan>[
                                TextSpan(
                                    text: hdb.flat_type,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black54))
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      IconButton(
                          icon: Image.asset('assets/images/calculator.png'),
                          iconSize: 80,
                          alignment: Alignment.topRight,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    loancalcontroller.LoanCalController(
                                  presetPrincipal: hdb.resale_price,
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Property Details:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black87),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      text: 'Size:                         ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87),
                      children: <TextSpan>[
                        TextSpan(
                            text: '${hdb.floor_area_sqm} sqm',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black54))
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      text: 'Remaining Lease:  ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87),
                      children: <TextSpan>[
                        TextSpan(
                            text: '${hdb.remaining_lease}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black54))
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      text: 'Storey Range:         ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87),
                      children: <TextSpan>[
                        TextSpan(
                            text: hdb.storey_range,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black54))
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 5),
                  RichText(
                    text: TextSpan(
                      text: 'Year Listed:             ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87),
                      children: <TextSpan>[
                        TextSpan(
                            text: hdb.lease_commence_date.round().toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black54))
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ]),
          ),
          SizedBox(height: 20),
          Text('Location & Nearby Places',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black)),

          Card(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            elevation: 4,
            child: SizedBox(
              width: 340,
              height: 240,
              child: mapmodel.MapModel(
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

  ///method to take screenshot and share to external apps.
  void _takeScreenshotandShare() async {
    final imageFile = await screenshotController.capture();
    Share.shareFiles([imageFile.path], text: "Shared from HDB App");
  }
}
