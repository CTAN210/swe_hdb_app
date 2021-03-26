import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swe_loan_calculator/src/HDBListings.dart' as locations;

import 'package:swe_loan_calculator/view/view.dart' as view;
import 'package:swe_loan_calculator/model/model.dart' as model;


class HelpPageController extends StatefulWidget {
  @override
  view.HelpPageView createState() => view.HelpPageView();
}


class LoanCalController extends StatefulWidget {

  LoanCalController({Key key, this.presetPrincipal}) : super(key: key);
  final double presetPrincipal;

  @override
  view.LoanCalView createState() => view.LoanCalView();
}


class LoanCalSliderController extends StatefulWidget {
  LoanCalSliderController({Key key, this.presetPrincipal}) : super(key: key);
  double presetPrincipal;
  @override
  view.LoanCalSliderView createState() => view.LoanCalSliderView(presetPrincipal: presetPrincipal);
}


class LoanController{

  static double calculateTotalLoanAmount(double principalValue, int loanValue){
    return (loanValue/100)*principalValue;
  }

  static double calculateDownPayment(double principalValue, int loanValue ){
    return ((100-loanValue)/100)*principalValue;
  }

  static double calculateMonthlyPayment(double principalValue,double interestRate,int loanTenure,
      int loanValue){
    double totalLoanAmount = calculateTotalLoanAmount(principalValue, loanValue);
    return (totalLoanAmount*(interestRate))/(1-1/pow(1+interestRate,loanTenure))/12;
  }

  static double calculateMonthlyInterest(double principalValue, double interestRate, int loanValue){
    double totalLoanAmount = calculateTotalLoanAmount(principalValue, loanValue);
    return (totalLoanAmount*interestRate)/12;
  }

  static double calculateMonthlyLoanAmount(double principalValue, double interestRate,
      int loanTenure, int loanValue){
    return calculateMonthlyPayment(principalValue, interestRate, loanTenure,loanValue)-
        calculateMonthlyInterest(principalValue, interestRate,loanValue);
  }
}


class MonthlyVisualisationController extends StatefulWidget {
  final double intValue;
  final int loanTenureValue;
  final int loanValue;
  final double principalValue;

  MonthlyVisualisationController({Key key, this.intValue,this.loanTenureValue,
    this.principalValue, this.loanValue}) : super(key: key);
  @override
  view.MonthlyVisualisationView createState() => view.MonthlyVisualisationView();

}


class TotalVisualisationController extends StatefulWidget {
  @override
  view.TotalVisualisationView createState() => view.TotalVisualisationView();
}


class FilterSliderController extends StatefulWidget {



  @override
  view.FilterSliderView createState() => view.FilterSliderView();

}


class BookMarkController{
  final databaseReference = FirebaseDatabase.instance.reference();
  final user = FirebaseAuth.instance.currentUser.uid;
  final id = FirebaseAuth.instance.currentUser.metadata;

  void saveBookmark(model.BookMarkInfoModel bookMarkInfo) {
    databaseReference.child('bookmark/'+user).remove();
    var id = databaseReference.child('bookmark/'+user).set(bookMarkInfo.toJson());


  }
/*  updateBookmarkList(){

    var listToUpdate = databaseReference.child('bookmark/'+user).get();
    return listToUpdate;
  }*/





/*getAllBookMarks() async {
    var dataSnapshot = await databaseReference.child('bookmark/author').equalTo(user);
    var list = [];
    for(var i in dataSnapshot.ke)

    }
    return list;
  }*/


}

/// Class to instantiate ListPageView and control the logic behind displaying Filtered HDB Listings on a List View
class ListPageController extends StatefulWidget {
  /// Upper Price Limit
  final int upperPV;
  /// Lower Price Limit
  final int lowerPV;
  /// Upper Floor Area Limit
  final int upperFlArea;
  /// Lower Floor Area Limit
  final int lowerFlArea;
  /// Flat Type
  final int value1;
  /// Location
  final int value2;
  /// Remaining Lease Limit
  final int remainLease;
  /// Username
  final String user = FirebaseAuth.instance.currentUser.displayName;
  var pulledList;
  List<dynamic> checkList;

  ListPageController(
      {Key key,
        this.title,
        this.upperPV,
        this.lowerPV,
        this.upperFlArea,
        this.lowerFlArea,
        this.value1,
        this.value2,
        this.remainLease,
        this.pulledList,
        this.checkList
      })
      : super(key: key);
  final String title;

  @override
  view.ListPageView createState() => view.ListPageView();

/*static List<locations.HDBListing> _filterListings(double upperPV, double lowerPV, double upperFlArea, double lowerFlArea, List<locations.HDBListing> List){

    final List<locations.HDBListing> finalList = [];
    for (final listing in List){
      if (lowerPV < listing.resale_price &&
          listing.resale_price < upperPV &&
          lowerFlArea < listing.floor_area_sqm &&
          listing.floor_area_sqm < upperFlArea){finalList.add(listing);}
    }
    return finalList;
  }*/

}

/// Class to instantiate FullDetailsController and control the logic behind displaying Full Details of a HDB Listing
class FullDetailsController extends StatefulWidget {
  @override
  view.FullDetailsView createState() => view.FullDetailsView();
}

/// Class to instantiate MapPageController and control the logic behind displaying Filtered HDB Listings on a GoogleMap
class MapPageController extends StatefulWidget {

  @override
  view.MapPageView createState() => view.MapPageView();
}

/// Class to organise display of entire Map View Page
class MapPageScreen extends StatelessWidget{
  MapPageScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MapPageController(),
      ),
    );
  }
}


class BookmarkPageController extends StatefulWidget{

  model.BookMarkInfoModel hdbListings;
  final List checkList;

  // ignore: sort_constructors_first
  BookmarkPageController(this.hdbListings,this.checkList);


  Future<List<locations.HDBListing>> update(checkList) async {
    final HDBData = await locations.getHDBListing();
    final List<locations.HDBListing> finalList = [];
    for(final listing in HDBData.items){
      for(final i in this.checkList){
        if(listing.ID  == i ) {
          finalList.add(listing);
        }
      }
    }
    return finalList;
  }


  @override
  view.BookmarkPageView createState() => view.BookmarkPageView();
}