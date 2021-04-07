
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/view/FullDetailsView.dart' as view;
import 'package:swe_loan_calculator/src/HDBListings.dart' as HDBListings;

/// Class to instantiate FullDetailsController and control the logic behind displaying Full Details of a HDB Listing
class FullDetailsController extends StatefulWidget {


  HDBListings.HDBListing hdb;

  FullDetailsController({
    this.hdb
});


  @override
  view.FullDetailsView createState() => view.FullDetailsView();
}