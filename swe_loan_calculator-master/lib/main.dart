import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/page/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swe_loan_calculator/page/mainpage.dart' as mainPage;
import 'package:swe_loan_calculator/controller/FilterPageController.dart' as filterpagecontroller;
import 'package:swe_loan_calculator/controller/FullDetailsController.dart' as fulldetailscontroller;
import 'package:swe_loan_calculator/controller/MapPageController.dart' as mappagecontroller;


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Google SignIn';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.blue),
    initialRoute: '/',
    routes: {
      '/': (context) => LoginPage(),
      '/first': (context) => mainPage.HomePageStateful(),
      '/second':(context) => filterpagecontroller.FIlterPageController(),
      '/third': (context) => fulldetailscontroller.FullDetailsController(),
      '/fourth': (context) => mappagecontroller.MapPageController(),
    },
  );
}