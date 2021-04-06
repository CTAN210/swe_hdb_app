
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/view/LoanCalSliderView.dart' as view;

///controller class that builds the LoanSliderView page.
class LoanCalSliderController extends StatefulWidget {
  ///constructor for LoanCalSliderController
  LoanCalSliderController({Key key, this.presetPrincipal}) : super(key: key);
  /// value for presetPrincipal
  double presetPrincipal;
  @override
  view.LoanCalSliderView createState() => view.LoanCalSliderView(presetPrincipal: presetPrincipal);
}