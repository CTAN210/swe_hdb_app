
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swe_loan_calculator/view/ListPageView.dart' as view;


/// Class to instantiate ListPageView and control the logic behind displaying Filtered HDB Listings on a List View
class FilterController extends StatefulWidget {
  /// Upper Price Limit
  final int upperPV;
  /// Lower Price Limit
  final int lowerPV;
  /// Upper Floor Area Limit
  final int upperFlArea;
  /// Lower Floor Area Limit
  final int lowerFlArea;
  /// Flat Type
  final int FlatTypeValue;
  /// Location
  final int LocationValue;
  /// Remaining Lease Limit
  final int remainLease;
  /// Username
  final String user = FirebaseAuth.instance.currentUser.displayName;
  var pulledList;


  FilterController(
      {Key key,
        this.title,
        this.upperPV,
        this.lowerPV,
        this.upperFlArea,
        this.lowerFlArea,
        this.FlatTypeValue,
        this.LocationValue,
        this.remainLease,
        this.pulledList,
        //this.checkList
      })
      : super(key: key);
  final String title;

  @override
  view.ListPageView createState() => view.ListPageView();

}