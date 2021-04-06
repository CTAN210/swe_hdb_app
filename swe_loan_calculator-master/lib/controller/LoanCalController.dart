
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/view/LoanCalView.dart' as view;

///controller class that builds the LoanCalculatorView page.
class LoanCalController extends StatefulWidget {
  ///constructor for LoanCalController
  LoanCalController({Key key, this.presetPrincipal}) : super(key: key);
  /// value of the presetPrincipal
  final double presetPrincipal;

  @override
  view.LoanCalView createState() => view.LoanCalView();
}
