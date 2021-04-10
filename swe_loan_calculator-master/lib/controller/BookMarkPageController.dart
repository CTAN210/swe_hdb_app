
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/src/HDBListings.dart' as locations;
import 'package:swe_loan_calculator/view/BookMarkPageView.dart' as view;

/// Controller class to create the BookmarkPageView state, and create a function that adds listing to the Bookmarked Listing widget in BookmarkPageView.
class BookmarkPageController extends StatefulWidget{
  var bookmarkList;
  BookmarkPageController(this.bookmarkList);
  Future<List<locations.HDBListing>> update(checkList) async {
    final HDBData = await locations.getHDBListing();
    final List<locations.HDBListing> finalList = [];
    for(final listing in HDBData.items){
      for(final i in checkList){
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