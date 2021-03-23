import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/src/HDBListings.dart' as locations;
import 'package:swe_loan_calculator/page/BookmarkView.dart';
import 'package:swe_loan_calculator/model/Bookmark.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:swe_loan_calculator/page/mainpage.dart';



class ListViewPage extends StatefulWidget {
  final int upperPV;
  final int lowerPV;
  final int upperFlArea;
  final int lowerFlArea;
  final int value1;
  final int value2;
  final int remainLease;
  final String user = FirebaseAuth.instance.currentUser.displayName;

  ListViewPage(
      {Key key,
      this.title,
      this.upperPV,
      this.lowerPV,
      this.upperFlArea,
      this.lowerFlArea,
      this.value1,
      this.value2,
      this.remainLease,
      })
      : super(key: key);
  final String title;

  @override
  ListViewPageState createState() => ListViewPageState();
}

class ListViewPageState extends State<ListViewPage> {

  final List bookmarkList = [];
  final List checkList = [];
  final databaseReference = FirebaseDatabase.instance.reference();

  Future<List<locations.HDBListing>> filtered_hdb;



  Future<List<locations.HDBListing>> _onMapView() async {
    final HDBData = await locations.getHDBListing();
    final List<locations.HDBListing> finalList = [];
    //print(HDBData);
    if (true) {
      for (final listing in HDBData.items) {
        if (widget.lowerPV != 200000 ||
            widget.upperPV != 200000 ||
            widget.lowerFlArea != 31 ||
            widget.upperFlArea != 31) {
          if (widget.lowerPV < listing.resale_price &&
              listing.resale_price < widget.upperPV &&
              widget.lowerFlArea < listing.floor_area_sqm &&
              listing.floor_area_sqm < widget.upperFlArea) {
            finalList.add(listing);
          }
        }
      }
      return finalList;
    }
  }


  DatabaseReference saveBookmark(BookMarkInfo bookMarkInfo) {
    databaseReference.child('bookmark/').remove();
    var id = databaseReference.child('bookmark/').push();
    id.set(bookMarkInfo.toJson());
    return id;
  }
/*  BookMarkInfo createBookMarkInfo(record) {
    var attributes = <String, dynamic>{
      'author': '',
      'bookMarkList': [],
    };
    record.forEach((key, value) => {attributes[key] = value});

    var bookMarkInfo = BookMarkInfo(attributes['bookMarkList'], attributes['author']);
    bookMarkInfo.bookMarkedList = List.from(attributes['bookMarkList']);
    return bookMarkInfo;

  }

  Future<List<BookMarkInfo>> getAllBookMarks() async {
    var dataSnapshot = await databaseReference.child('bookmark/').once();
    var bookMarkInfos = <BookMarkInfo>[];
    if (dataSnapshot.value != null) {
      dataSnapshot.value.forEach((key, value){
        var bookMarkInfo = createBookMarkInfo(value);
        //BookMarkInfo.setId(databaseReference.child('bookmarks/'+ key));
        bookMarkInfos.add(bookMarkInfo);

      });
    }
    return bookMarkInfos;
  }
  */



  @override
  Widget build(BuildContext context) {
    filtered_hdb = _onMapView();
    var BookMarkItem = BookMarkInfo(bookmarkList, widget.user);

    return Scaffold(
      appBar: AppBar(
        title: Text('HDB Lists (Filtered)'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookMarkPage(BookMarkItem,checkList)),
                  );
                });
              })
        ],
      ),
      body: Container(
          child: FutureBuilder<List<locations.HDBListing>>(
              future: filtered_hdb,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<locations.HDBListing> filtered_hdb1 = snapshot.data;
                  return ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {

                        final isBookmarked =
                        //BookMarkItem.bookMarkedList.contains(filtered_hdb1[index]);
                        checkList.contains(filtered_hdb1[index].ID);



                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, '/third',
                                  arguments: filtered_hdb1[index]);
                            },
                            title: Text("price: " +
                                filtered_hdb1[index].resale_price.toString() +
                                '\n' +
                                'address: ' +
                                filtered_hdb1[index].address +
                                '\n' +
                                'floor_area: ' +
                                filtered_hdb1[index].floor_area_sqm.toString() +
                                '\n' +
                                'remaining_lease: ' +
                                filtered_hdb1[index].remaining_lease),
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

                                    saveBookmark(BookMarkItem);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.calculate_outlined),
                                  onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoanCalPage(presetPrincipal: filtered_hdb1[index].resale_price,),
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
                  return Center(child: CircularProgressIndicator());
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
              //arguments: );
              arguments: _onMapView());
        },
        child: const Icon(Icons.map),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
