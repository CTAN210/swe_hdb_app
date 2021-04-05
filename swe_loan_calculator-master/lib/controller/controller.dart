import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swe_loan_calculator/src/HDBListings.dart' as locations;

import 'package:swe_loan_calculator/view/view.dart' as view;
import 'package:swe_loan_calculator/model/model.dart' as model;

///Controller class that builds the HelpPageView state
class HelpPageController extends StatefulWidget {
  @override
  view.HelpPageView createState() => view.HelpPageView();
}

///controller class that builds the LoanCalculatorView page.
class LoanCalController extends StatefulWidget {
  ///constructor for LoanCalController
  LoanCalController({Key key, this.presetPrincipal}) : super(key: key);
  /// value of the presetPrincipal
  final double presetPrincipal;

  @override
  view.LoanCalView createState() => view.LoanCalView();
}

///controller class that builds the LoanSliderView page.
class LoanCalSliderController extends StatefulWidget {
  ///constructor for LoanCalSliderController
  LoanCalSliderController({Key key, this.presetPrincipal}) : super(key: key);
  /// value for presetPrincipal
  double presetPrincipal;
  @override
  view.LoanCalSliderView createState() => view.LoanCalSliderView(presetPrincipal: presetPrincipal);
}

/// controller class that makes all the loan calculation
class LoanController{
  ///method used to calculate total loan amount
  static double calculateTotalLoanAmount(double principalValue, int loanValue){
    return (loanValue/100)*principalValue;
  }
  ///method used to calculate down payment amount
  static double calculateDownPayment(double principalValue, int loanValue ){
    return ((100-loanValue)/100)*principalValue;
  }
  ///method used to calculate monthly payment amount.
  static double calculateMonthlyPayment(double principalValue,double interestRate,int loanTenure,
      int loanValue){
    double totalLoanAmount = calculateTotalLoanAmount(principalValue, loanValue);
    return (totalLoanAmount*(interestRate))/(1-1/pow(1+interestRate,loanTenure))/12;
  }
  ///method used to calculate monthly interest amount
  static double calculateMonthlyInterest(double principalValue, double interestRate, int loanValue){
    double totalLoanAmount = calculateTotalLoanAmount(principalValue, loanValue);
    return (totalLoanAmount*interestRate)/12;
  }
  ///method used to calculate monthly loan amount
  static double calculateMonthlyLoanAmount(double principalValue, double interestRate,
      int loanTenure, int loanValue){
    return calculateMonthlyPayment(principalValue, interestRate, loanTenure,loanValue)-
        calculateMonthlyInterest(principalValue, interestRate,loanValue);
  }
}

///controller class for Monthly visualisation. Creates state for the monthly visualisation view.
class MonthlyVisualisationController extends StatefulWidget {
  ///interest amount
  final double intValue;
  ///loan tenure duration
  final int loanTenureValue;
  /// Percentage of payment to be paid with loan.
  final int loanValue;
  ///principal value of the listing
  final double principalValue;
  ///constructor for the MonthlyVisualisationController
  MonthlyVisualisationController({Key key, this.intValue,this.loanTenureValue,
    this.principalValue, this.loanValue}) : super(key: key);
  @override
  view.MonthlyVisualisationView createState() => view.MonthlyVisualisationView();

}

///controller class for the total visualisation to build its view state.
class TotalVisualisationController extends StatefulWidget {
  @override
  view.TotalVisualisationView createState() => view.TotalVisualisationView();
}


class FilterSliderController extends StatefulWidget {



  @override
  view.FilterSliderView createState() => view.FilterSliderView();

}

///controller class to interact with the database.
class BookMarkController{
  ///reference of the path in the database
  final databaseReference = FirebaseDatabase.instance.reference();
  ///user id key of the current user
  final user = FirebaseAuth.instance.currentUser.uid;

  ///method to update the BookMarkInfo in the database.
  void saveBookmark(model.BookMarkInfoModel bookMarkInfo) {
    databaseReference.child('bookmark/'+user).remove();
    databaseReference.child('bookmark/'+user).set(bookMarkInfo.toJson());
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
        //this.checkList
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