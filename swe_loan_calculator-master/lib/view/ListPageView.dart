import 'package:firebase_database/firebase_database.dart';
import 'package:swe_loan_calculator/src/HDBListings.dart' as locations;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swe_loan_calculator/controller/FilterController.dart' as listpagecontroller;
import 'package:swe_loan_calculator/controller/BookMarkController.dart' as bookmarkcontroller;
import 'package:swe_loan_calculator/model/BookMarkInfoModel.dart' as bookmarkinfomodel;
import 'package:swe_loan_calculator/controller/LoanCalController.dart' as loancalcontroller;

/// Class to organise the display of Filtered HDB Listings on a List View
class ListPageView extends State<listpagecontroller.FilterController> {
  /// List of Bookmarked HDB Listings
  final List bookmarkList = [];
  var checkList=[];
  /// Controller that handles the logic behind Bookmarking a HDBListings
  var BookmarkController = bookmarkcontroller.BookMarkController();
  /// List of Filtered HDB
  Future<List<locations.HDBListing>> filtered_hdb;
  void fetchBookmarkData(){
    var user = BookmarkController.user;
    BookmarkController.databaseReference.child('bookmark/'+user+'/bookMarkList/').once().then(
            (DataSnapshot data){
          setState((){
            checkList=[];
            widget.pulledList = data.value;
            int j;
            try{
              j = widget.pulledList.length;
            }
            catch(e){
              j=0;
            }
            for(var i=0;i< j;i++){
              if(!checkList.contains(widget.pulledList[i]))
              {checkList.add(widget.pulledList[i]);}
            }
          });
        }
    );
  }
  @override
  void initState(){
    fetchBookmarkData();
    super.initState();
  }

  /// Function to set markers on Google Map
  Future<List<locations.HDBListing>> _HDBFilterFunction() async {
    final HDBData = await locations.getHDBListing();
    final List<locations.HDBListing> finalList = [];
    //print(HDBData);
    var LocationDictionary = { 1:'ANG MO KIO' , 2:'BEDOK', 3:'BISHAN', 4:'BUKIT BATOK', 5: 'BUKIT MERAH', 6: 'BUKIT PANJANG',
      7: 'BUKIT TIMAH', 8: 'CENTRAL AREA', 9: 'CHOA CHU KANG', 10: 'CLEMENTI', 11: 'GEYLANG',
      12: 'HOUGANG', 13: 'JURONG EAST', 14: 'JURONG WEST', 15: 'KALLANG/WHAMPOA', 16: 'MARINE PARADE', 17: 'PASIR RIS',
      18: 'PUNGGOL', 19: 'QUEENSTOWN', 20: 'SEMBAWANG', 21: 'SENGKANG', 22: 'SERANGOON', 23: 'TAMPINES',
      24: 'TOA PAYOH', 25: 'WOODLANDS', 26: 'YISHUN'};
    var FlatTypeDictionary = { 1 : '1 ROOM', 2: '2 ROOM', 3: '3 ROOM', 4: '4 ROOM', 5: '5 ROOM',
      6: 'EXECUTIVE', 7: 'MULTI-GENERATION'};
    for (final listing in HDBData.items) {
      if (widget.lowerPV != 200000 ||
          widget.upperPV != 200000 ||
          widget.lowerFlArea != 31 ||
          widget.upperFlArea != 31 ||
          widget.FlatTypeValue != 1 ||
          widget.LocationValue != 1) {
        //print (LocationDictionary[widget.LocationValue]);
        // FIGURE OUT REMAINING_LEASE (FROM STRING TO INT)
        if (widget.lowerPV < listing.resale_price &&
            listing.resale_price < widget.upperPV &&
            widget.lowerFlArea < listing.floor_area_sqm &&
            listing.floor_area_sqm < widget.upperFlArea &&
            listing.town == LocationDictionary[widget.LocationValue] &&
            listing.flat_type == FlatTypeDictionary[widget.FlatTypeValue]) {
          finalList.add(listing);

        }
      }
    }
    return finalList;
  }

  /// Function to organise display of entire List View Page
  @override
  Widget build(BuildContext context)  {
    var count =0;
    filtered_hdb = _HDBFilterFunction();
    //checkList=widget.pulledList;

    var BookMarkItem = bookmarkinfomodel.BookMarkInfoModel(bookmarkList, widget.user);


    if(widget.pulledList == null ){
      widget.pulledList=[];
      count++;
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('HDB Lists (Filtered)'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/first',(_) => false
              );
            },
          ),
        ],
      ),
      body: Container(
          child: FutureBuilder<List>(
            //future: Future.wait([filtered_hdb,FirebaseDatabase.instance.reference().child('bookmark/'+user).once()]),
            //builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              future: filtered_hdb,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('Not Empty Set');
                  List<locations.HDBListing> filtered_hdb1 = snapshot.data;


                  return ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var isBookmarked =
                        //BookMarkItem.bookMarkedList.contains(filtered_hdb1[index]);
                        checkList.contains(filtered_hdb1[index].ID);
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, '/third',
                                  arguments: filtered_hdb1[index]);
                            },
                            title: Text('price: ' + '\$' +
                                filtered_hdb1[index].resale_price.toString() +
                                '\n' +
                                'Address: ' +
                                filtered_hdb1[index].address +
                                '\n' +
                                'Floor Area: ' +
                                filtered_hdb1[index].floor_area_sqm.toString() + ' sqm' +
                                '\n' +
                                'Remaining Lease: ' +
                                filtered_hdb1[index].remaining_lease +
                                '\n' + 'Flat Type: ' +
                                filtered_hdb1[index].flat_type),
                            trailing: Wrap(
                              spacing: -20,
                              children: <Widget>[
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
                                        checkList.remove(filtered_hdb1[index].ID);
                                      } else {
                                        //BookMarkItem.bookMarkedList.add(filtered_hdb1[index]);
                                        checkList.add(filtered_hdb1[index].ID);
                                      }
                                    });
                                    BookMarkItem.bookMarkedList=checkList;
                                    BookmarkController.saveBookmark(BookMarkItem);
                                  },
                                ),
                                IconButton(
                                    icon: Icon(Icons.calculate_outlined),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => loancalcontroller.LoanCalController(presetPrincipal: filtered_hdb1[index].resale_price,),
                                        ),
                                      );
                                    }
                                ),
                              ],
                            ),

                          ),
                        );
                      });
                } else {
                  print('Empty Set');
                  return Card(child: Text ('EMPTY'));
                }
              })
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/fourth',
              //arguments: );
              arguments: _HDBFilterFunction());
        },
        child: const Icon(Icons.map),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}