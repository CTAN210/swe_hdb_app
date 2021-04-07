import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/page/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swe_loan_calculator/page/mainpage.dart' as mainPage;
import 'package:swe_loan_calculator/controller/FilterPageController.dart' as filterpagecontroller;
import 'package:swe_loan_calculator/controller/FullDetailsController.dart' as fulldetailscontroller;
import 'package:swe_loan_calculator/controller/MapPageController.dart' as mappagecontroller;
import 'package:swe_loan_calculator/controller/FilterController.dart' as filtercontroller;
import 'package:swe_loan_calculator/view/FilterView.dart' as filterview;


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Google SignIn';

  static int count;

  static int getCount(){
    return count;
  }

  static int setCount(int count123){
    count = count123;
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.blue),
    initialRoute: '/',
    routes: {
      /// Route: To Login Page
      '/': (context) => LoginPage(),
      /// Route: To Home Page
      '/first': (context) => mainPage.HomePageStateful(),
      /// Route: To Filter Page
      '/second':(context) => filterpagecontroller.FIlterPageController(),
      /// Route: To Full Details Page
      '/third': (context) => fulldetailscontroller.FullDetailsController(),
      /// Route: To Map Page
      '/fourth': (context) => mappagecontroller.MapPageController(),
      /// Route: To List View Page
      '/fifth': (context) => filtercontroller.FilterController(ViewAllListings: 0),
    },
  );
}