import 'package:firebase_database/firebase_database.dart';
import 'package:swe_loan_calculator/src/HDBListings.dart' as locations;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swe_loan_calculator/controller/FilterController.dart'
    as filtercontroller;
import 'package:swe_loan_calculator/controller/BookMarkController.dart'
    as bookmarkcontroller;
import 'package:swe_loan_calculator/model/BookMarkInfoModel.dart'
    as bookmarkinfomodel;
import 'package:swe_loan_calculator/controller/LoanCalController.dart'
    as loancalcontroller;
import 'package:swe_loan_calculator/view/FilterSliderView.dart'
    as filtersliderview;
import 'package:swe_loan_calculator/controller/FullDetailsController.dart'
    as fulldetailscontroller;

/// Class to organise the display of Filtered HDB Listings on a List View
class ListPageView extends State<filtercontroller.FilterController> {
  /// List of Bookmarked HDB Listings
  final List bookmarkList = [];
  var checkList = [];

  /// Controller that handles the logic behind Bookmarking a HDBListings
  var BookmarkController = bookmarkcontroller.BookMarkController();

  /// List of Filtered HDB
  Future<List<locations.HDBListing>> filtered_hdb;

  /// ViewAllListings value passed from FilterController class
  int ViewAllListings;

  /// List passed in from the constructor for FilterController. This boolean list allows us to identify which filter functions has been selected.
  List<bool> SelectedList;

  /// Instance of the FilterController Class
  filtercontroller.FilterController FilterControllerInstance =
      filtercontroller.FilterController();

  /// Instance of the FilterSliderView Class
  filtersliderview.FilterSliderView FilterSliderViewInstance =
      filtersliderview.FilterSliderView();

  ListPageView({this.ViewAllListings, this.SelectedList});

  void fetchBookmarkData() {
    var user = BookmarkController.user;
    BookmarkController.databaseReference
        .child('bookmark/' + user + '/bookMarkList/')
        .once()
        .then((DataSnapshot data) {
      setState(() {
        checkList = [];
        widget.pulledList = data.value;
        int j;
        try {
          j = widget.pulledList.length;
        } catch (e) {
          j = 0;
        }
        for (var i = 0; i < j; i++) {
          if (!checkList.contains(widget.pulledList[i])) {
            checkList.add(widget.pulledList[i]);
          }
        }
      });
    });
  }

  @override
  void initState() {
    fetchBookmarkData();
    super.initState();
  }

  /// Function to organise display of entire List View Page
  @override
  Widget build(BuildContext context) {
    var count = 0;
    FilterControllerInstance.PV = FilterSliderViewInstance.getPVRangeValues();

    FilterControllerInstance.FlArea =
        FilterSliderViewInstance.getFlAreaRangeValues();

    FilterControllerInstance.RemainLease =
        FilterSliderViewInstance.getRemainLeaseRangeValues();

    FilterControllerInstance.FlatTypeValue =
        FilterSliderViewInstance.getFlatTypeValue();

    FilterControllerInstance.LocationValue =
        FilterSliderViewInstance.getLocationValue();

    filtered_hdb = FilterControllerInstance.HDBFilterFunction(
        FilterControllerInstance.PV,
        FilterControllerInstance.FlArea,
        FilterControllerInstance.RemainLease,
        FilterControllerInstance.FlatTypeValue,
        FilterControllerInstance.LocationValue,
        ViewAllListings,
        SelectedList);

    var BookMarkItem =
        bookmarkinfomodel.BookMarkInfoModel(bookmarkList, widget.user);

    if (widget.pulledList == null) {
      widget.pulledList = [];
      count++;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Filtered HDB Listings '),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/second', (_) => false);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/first', (_) => false);
            },
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<List>(
              //future: Future.wait([filtered_hdb,FirebaseDatabase.instance.reference().child('bookmark/'+user).once()]),
              //builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              future: filtered_hdb,
              builder: (context, snapshot) {
                if (snapshot.data.isNotEmpty) {
                  print('========Number of listings displayed======== ' +
                      '\n' +
                      snapshot.data.length.toString());
                  List<locations.HDBListing> filtered_hdb1 = snapshot.data;

                  return ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var isBookmarked =
                            //BookMarkItem.bookMarkedList.contains(filtered_hdb1[index]);
                            checkList.contains(filtered_hdb1[index].ID);
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // if you need this
                            side: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          //decoration:  BoxDecoration(border: new Border.all(color: Colors.grey[500], width: 2.0), borderRadius: BorderRadius.circular(10.0),),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          fulldetailscontroller
                                              .FullDetailsController(
                                                  hdb: filtered_hdb1[index])));
                            },
                            title: Text(filtered_hdb1[index].address + '\n'),
                            subtitle: Text('\$' +
                                filtered_hdb1[index].resale_price.toString() +
                                '\n'
                                    'Floor Area: ' +
                                filtered_hdb1[index].floor_area_sqm.toString() +
                                ' sqm' +
                                '\n' +
                                'Remaining Lease: ' +
                                filtered_hdb1[index].remaining_lease +
                                '\n' +
                                'Flat Type: ' +
                                filtered_hdb1[index].flat_type),
                            trailing: Wrap(

                              spacing: -15,
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.calculate_outlined),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                loancalcontroller
                                                    .LoanCalController(
                                              presetPrincipal:
                                                  filtered_hdb1[index]
                                                      .resale_price,
                                            ),
                                          ),
                                        );
                                      }),
                                  IconButton(
                                    icon: Icon(
                                      isBookmarked
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                      color: isBookmarked ? Colors.black : null,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (isBookmarked) {
                                          //BookMarkItem.bookMarkedList.remove(filtered_hdb1[index]);
                                          checkList
                                              .remove(filtered_hdb1[index].ID);
                                        } else {
                                          //BookMarkItem.bookMarkedList.add(filtered_hdb1[index]);
                                          checkList
                                              .add(filtered_hdb1[index].ID);
                                        }
                                      });
                                      BookMarkItem.bookMarkedList = checkList;
                                      BookmarkController.saveBookmark(
                                          BookMarkItem);
                                    },
                                  ),
                                ]),
                          ),
                        );
                      });
                }
                else{
                  print('Empty list! Displaying error message to User');
                  return Center(
                      child: Text('No Listings Found!',
                          style: TextStyle(color: Colors.black, fontSize: 25)));
                }
              })),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/fourth',
              arguments: FilterControllerInstance.HDBFilterFunction(
                  FilterControllerInstance.PV,
                  FilterControllerInstance.FlArea,
                  FilterControllerInstance.RemainLease,
                  FilterControllerInstance.FlatTypeValue,
                  FilterControllerInstance.LocationValue,
                  ViewAllListings,
                  SelectedList));
        },
        child: const Icon(Icons.map),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
