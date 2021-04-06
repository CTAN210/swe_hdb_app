import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/page/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swe_loan_calculator/page/mainpage.dart' as mainPage;


import 'package:swe_loan_calculator/controller/controller.dart' as controller;
import 'package:swe_loan_calculator/view/view.dart' as view;
import 'package:swe_loan_calculator/model/model.dart' as model;


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
      '/second':(context) => view.FilterView(),
      '/third': (context) => controller.FullDetailsController(),
      '/fourth': (context) => controller.MapPageController(),
    },
  );
}