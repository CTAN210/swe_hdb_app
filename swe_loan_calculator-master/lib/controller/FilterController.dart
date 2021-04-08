
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swe_loan_calculator/view/ListPageView.dart' as view;
import 'package:swe_loan_calculator/src/HDBListings.dart' as locations;

/// Class to instantiate ListPageView and control the logic behind displaying Filtered HDB Listings on a List View
class FilterController extends StatefulWidget {


  /// Flat Type
  int FlatTypeValue;
  /// Location
  int LocationValue;
  /// Range Values for Property Values
  RangeValues PV;
  /// Range Values for Floor Area
  RangeValues FlArea;
  /// Range Values for Remaining Lease ( in Years )
  RangeValues RemainLease;
  /// Value for determining if the 'View All Listings' button is pressed or not.
  int ViewAllListings;
  /// Boolean list for allowing us to identify which filter functions has been selected.
  List<bool> SelectedList;
  /// Username
  final String user = FirebaseAuth.instance.currentUser.displayName;
  var pulledList;




  FilterController(
      {Key key,
        this.title,
        this.FlatTypeValue,
        this.LocationValue,
        this.pulledList,
        this.PV,
        this.FlArea,
        this.RemainLease,
        this.ViewAllListings,
        this.SelectedList,
        //this.checkList
      })
      : super(key: key);
  final String title;



  /// Function to filter HDB Listings
  Future<List<locations.HDBListing>> HDBFilterFunction(RangeValues PV, RangeValues FlArea, RangeValues RemainLease, int FlatTypeValue, int LocationValue, int ViewAllListings, List<bool> SelectedList) async {
    final HDBData = await locations.getHDBListing();
    final List<locations.HDBListing> finalList = [];
    var LocationDictionary = {0:'ALL', 1:'ANG MO KIO' , 2:'BEDOK', 3:'BISHAN', 4:'BUKIT BATOK', 5: 'BUKIT MERAH', 6: 'BUKIT PANJANG',
      7: 'BUKIT TIMAH', 8: 'CENTRAL AREA', 9: 'CHOA CHU KANG', 10: 'CLEMENTI', 11: 'GEYLANG',
      12: 'HOUGANG', 13: 'JURONG EAST', 14: 'JURONG WEST', 15: 'KALLANG/WHAMPOA', 16: 'MARINE PARADE', 17: 'PASIR RIS',
      18: 'PUNGGOL', 19: 'QUEENSTOWN', 20: 'SEMBAWANG', 21: 'SENGKANG', 22: 'SERANGOON', 23: 'TAMPINES',
      24: 'TOA PAYOH', 25: 'WOODLANDS', 26: 'YISHUN'};
    var FlatTypeDictionary = {0:'ALL', 1: '1 ROOM', 2: '2 ROOM', 3: '3 ROOM', 4: '4 ROOM', 5: '5 ROOM',
      6: 'EXECUTIVE', 7: 'MULTI-GENERATION'};

    if (ViewAllListings == 0){

      if (SelectedList.contains(true)) {
        print ('=========Commencing Filtering=========');
        finalList.addAll(HDBData.items);
        if (SelectedList[0] == true){
          print ('Flat Type is selected. Values: ' + FlatTypeDictionary[FlatTypeValue]);
        }
        if (SelectedList[1] == true){
          print ('Location is selected. Values: ' + LocationDictionary[LocationValue]);
        }
        if (SelectedList[2] == true){
          print ('Property value is selected. Values: ' + PV.toString());
        }
        if (SelectedList[3] == true){
          print ('Floor Area is selected. Values: ' + FlArea.toString());
        }
        if (SelectedList[4] == true){
          print('Remaining Lease is selected. Values: ' + RemainLease.toString());
        }
        for (final listing in HDBData.items){
        if (SelectedList[0] == true) {
          if (FlatTypeValue != 0 && listing.flat_type != FlatTypeDictionary[FlatTypeValue])
              finalList.remove(listing);
        }
        if (SelectedList[1] == true) {
          if (LocationValue != 0 && listing.town != LocationDictionary[LocationValue])
            finalList.remove(listing);
        }
        if (SelectedList[2] == true) {
          if (PV.start > listing.resale_price || PV.end < listing.resale_price)
            finalList.remove(listing);
        }
        if (SelectedList[3] == true) {
          if (FlArea.start > listing.floor_area_sqm || FlArea.end < listing.floor_area_sqm)
            finalList.remove(listing);
        }
        if (SelectedList[4] == true) {
          if (RemainLease.start > int.parse('${listing.remaining_lease[0]}${listing.remaining_lease[1]}') || RemainLease.end < int.parse('${listing.remaining_lease[0]}${listing.remaining_lease[1]}'))
            finalList.remove(listing);
        }
        }
      }
    }
    else if (ViewAllListings == 1) {
      print('View All Listings button has been selected. Displaying all listings.');
      finalList.addAll(HDBData.items);
    }

    return finalList;
  }



  @override
  view.ListPageView createState() => view.ListPageView(ViewAllListings: ViewAllListings, SelectedList: SelectedList);

}