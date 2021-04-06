
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/view/FilterView.dart' as view;

class FIlterPageController extends StatefulWidget{
  FIlterPageController({Key key, this.title}) : super(key: key);

  final String title;

  @override
  view.FilterView createState() => view.FilterView();
}