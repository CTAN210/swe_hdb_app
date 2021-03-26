import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/provider/google_sign_in.dart';
import 'package:provider/provider.dart';


import 'package:swe_loan_calculator/controller/controller.dart' as controller;
import 'package:swe_loan_calculator/view/view.dart' as view;
import 'package:swe_loan_calculator/model/model.dart' as model;



/// Class to organise the display of main page view
class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  /// Function to organise the entire display of main page view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("HDB App")),
        body: Center(
            child: Column(
                children: <Widget>[
                  /// Button to logout
                  FlatButton(
                    onPressed: () {
                      final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                      provider.logout();
                    },
                    child: Container(
                        alignment: Alignment.topRight,
                        child: Text('Logout')
                    ),
                  ),

                  /// Button to search/filter for listings
                  IconButton(
                    icon: Image.asset('assets/images/search.png'),
                    iconSize: 150,
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => view.FilterView(),
                      ),
                    );},
                  ),
                  /// Button to go to loan calculator
                  IconButton(
                    icon: Image.asset('assets/images/calculator.png'),
                    iconSize: 150,
                    onPressed: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => controller.LoanCalController(),
                      ),
                    );},
                  ),
                  /// Button to go to help page
                  OutlineButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => controller.HelpPageController(),
                          ),
                        );
                      },
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.info)
                          ),
                        ],
                      ),
                      highlightedBorderColor: Colors.white,
                      color: Colors.white,
                      borderSide: new BorderSide(color: Colors.white),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0)
                      )
                  ),
                  ///Display bookmarked listings

                ]
            )
        ));
  }
}