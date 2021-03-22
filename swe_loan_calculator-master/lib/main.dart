import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'src/HDBListings.dart' as locations;
import 'package:swe_loan_calculator/page/main_fullListings.dart' as full_details;
import 'package:swe_loan_calculator/page/listviewpage.dart' as listviewpage;
import 'package:swe_loan_calculator/page/main_map.dart' as map_view;
import 'package:swe_loan_calculator/src/shoppingmalls.dart' as ShoppingMalls;
import 'package:swe_loan_calculator/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

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
      '/': (context) => HomePage(),
      '/third': (context) => full_details.FullDetailsView(),
      '/fourth': (context) => map_view.MapPageView(),
    },
  );
}