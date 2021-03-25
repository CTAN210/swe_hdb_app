import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:swe_loan_calculator/controller/controller.dart' as controller;
import 'package:swe_loan_calculator/view/view.dart' as view;

class MapModel extends StatelessWidget {
  final LatLng center;

  final GoogleMapController mapController;
  final ArgumentCallback<GoogleMapController> onMapCreated;
  final Map<String, Marker> markers;
  const MapModel({
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

class BookMarkInfoModel {
  String author;
  var bookMarkedList = [];
  DatabaseReference _id;

  // ignore: sort_constructors_first
  BookMarkInfoModel(this.bookMarkedList, this.author);


  void setId(DatabaseReference id) {
    _id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'bookMarkList': bookMarkedList.toList(),
    };
  }
}