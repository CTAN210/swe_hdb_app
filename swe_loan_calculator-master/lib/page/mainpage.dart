import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/provider/google_sign_in.dart';
import 'package:provider/provider.dart';


import 'package:swe_loan_calculator/controller/controller.dart' as controller;
import 'package:swe_loan_calculator/view/view.dart' as view;
import 'package:swe_loan_calculator/model/model.dart' as model;




class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("HDB App")),
        body: Center(
            child: Column(
                children: <Widget>[
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

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => controller.LoanCalController(),
                        ),
                      );
                    },
                    child: Text("Loan Calculator",
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30)),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), primary: Colors.black),
                      child: Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child:Icon(Icons.info_outline),
                      ),

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => controller.HelpPageController(),
                          ),
                        );
                      }),
                  GestureDetector(
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => view.FilterView(),
                        ),
                      );
                    },
                    child: Text("Search/Filter", style: TextStyle(fontWeight: FontWeight.w900, fontSize:30)), //Text
                  ),
                  GestureDetector(
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:(context) => controller.MapPageScreen(),
                        ),
                      );
                    },
                    child: Text("Map View", style: TextStyle(fontWeight: FontWeight.w900, fontSize:30)), //Text
                  ),
                ]
            )
        ));
  }
}














