
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/provider/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:swe_loan_calculator/controller/BookMarkController.dart' as bookmarkcontroller;
import 'package:swe_loan_calculator/controller/LoanCalController.dart' as loancalcontroller;
import 'package:swe_loan_calculator/controller/HelpPageController.dart' as helppagecontroller;
import 'package:swe_loan_calculator/controller/BookMarkPageController.dart' as bookmarkpagecontroller;


class HomePageStateful extends StatefulWidget {
  @override
  MyHomePage createState() => MyHomePage();
}

/// Class to organise the display of main page view
class MyHomePage extends State<HomePageStateful> {
  var bookmarkList=[];
  void updateList(){
    var BookmarkController = bookmarkcontroller.BookMarkController();
    var user = BookmarkController.user;
    BookmarkController.databaseReference.child('bookmark/'+user+'/bookMarkList/').once().then(
            (DataSnapshot data){
          setState((){
            bookmarkList = data.value;
          });
        }
    );
  }

  @override
  void initState(){
    updateList();
    super.initState();
  }


  /// Function to organise the entire display of main page view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HDB App"),
          actions: [
            /// Button to logout
            FlatButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Text('Logout',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Colors.white))),
            ),
            OutlineButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => helppagecontroller.HelpPageController(),
                    ),
                  );
                },
                child: Stack(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.info)),
                  ],
                ),
                highlightedBorderColor: Colors.white,
                color: Colors.white,
                borderSide: new BorderSide(color: Colors.white),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0))),
          ],
        ),
        body: Center(
            child: Column(children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(children: <Widget>[
                /// Button to search/filter for listings
                IconButton(
                  icon: Image.asset('assets/images/search.png'),
                  iconSize: 150,
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/second',(_) => false
                    );
                  },
                ),

                /// Button to go to loan calculator
                IconButton(
                  icon: Image.asset('assets/images/calculator.png'),
                  iconSize: 150,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => loancalcontroller.LoanCalController(),
                      ),
                    );
                  },
                ),
              ]),


            ],
          ),
          Text("Bookmark List",style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,)),
          Container(
            height: 300.0,
            width: 350,
            child: Column(children: <Widget>[
                bookmarkpagecontroller.BookmarkPageController(bookmarkList),
            ]),
          ),

          /// Button to go to help page
          ///Display bookmarked listings
        ])));

  }
}
