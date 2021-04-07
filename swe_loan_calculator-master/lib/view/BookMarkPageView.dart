import 'package:firebase_database/firebase_database.dart';
import 'package:swe_loan_calculator/src/HDBListings.dart' as locations;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swe_loan_calculator/controller/BookMarkController.dart' as bookmarkcontroller;
import 'package:swe_loan_calculator/controller/BookMarkPageController.dart' as bookmarkpagecontroller;
import 'package:swe_loan_calculator/model/BookMarkInfoModel.dart' as bookmarkinfomodel;
import 'package:swe_loan_calculator/controller/FullDetailsController.dart' as fulldetailscontroller;

class BookmarkPageView extends State<bookmarkpagecontroller.BookmarkPageController>{

  var BookmarkController = bookmarkcontroller.BookMarkController();
  var checkList =[];
  var pulledList =[];
  void fetchBookmarkData(){
    var user = BookmarkController.user;
    BookmarkController.databaseReference.child('bookmark/'+user+'/bookMarkList/').once().then(
            (DataSnapshot data){
          setState((){
            checkList=[];
            pulledList = data.value;
            int j;
            try{
              j = pulledList.length;
            }
            catch(e){
              j=0;
            }
            for(var i=0;i< j;i++){
              if(!checkList.contains(pulledList[i]))
              {checkList.add(pulledList[i]);}
            }
          });
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    var BookmarkList =  widget.update(widget.bookmarkList);
    var BookMarkItem = bookmarkinfomodel.BookMarkInfoModel(checkList, BookmarkController.user);
    fetchBookmarkData();
    return Container(
        child: FutureBuilder<List<locations.HDBListing>>(
          future: BookmarkList,
          builder: (context, snapshot){
            var max=0;
            try{
              max = snapshot.data.length;
            }
            catch(e){
              max=0;
            }
            var BookmarkList1 = snapshot.data;
            //max = snapshot.data.length;
            return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(16),
                  //physics: BouncingScrollPhysics(),
                  itemCount: max,
                  itemBuilder: (context, index) {

                    final listing = BookmarkList1[index];

                    return Card(
                        child:ListTile(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => fulldetailscontroller.FullDetailsController(hdb: listing)));
                          },
                          title: Text(listing.address , style: TextStyle(fontWeight: FontWeight.w900)),
                          subtitle: Text('Resale Price : ' + '\$' + listing.resale_price.toString(), style: TextStyle(fontWeight: FontWeight.w900)),
                          trailing: IconButton(
                            icon: Icon(
                                Icons.close
                            ),
                            onPressed: () {
                              setState(() {
                                checkList.remove(listing.ID);
                              });
                              BookMarkItem.bookMarkedList=checkList;
                              BookmarkController.saveBookmark(BookMarkItem);
                              Navigator.pushNamedAndRemoveUntil(context, '/first',(_) => false
                              );
                            },
                          ),
                        )
                    );
                  },
                )
            );
          },
        )
    );



  }
}