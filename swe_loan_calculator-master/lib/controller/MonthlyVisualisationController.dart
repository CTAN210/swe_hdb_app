
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/view/MonthlyVisualisationView.dart' as view;

///controller class for Monthly visualisation. Creates state for the monthly visualisation view.
class MonthlyVisualisationController extends StatefulWidget {
  ///interest amount
  final double intValue;
  ///loan tenure duration
  final int loanTenureValue;
  /// Percentage of payment to be paid with loan.
  final int loanValue;
  ///principal value of the listing
  final double principalValue;
  ///constructor for the MonthlyVisualisationController
  MonthlyVisualisationController({Key key, this.intValue,this.loanTenureValue,
    this.principalValue, this.loanValue}) : super(key: key);
  @override
  view.MonthlyVisualisationView createState() => view.MonthlyVisualisationView();

}