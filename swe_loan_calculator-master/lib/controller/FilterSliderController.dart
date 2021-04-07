
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swe_loan_calculator/view/FilterSliderView.dart' as view;

///controller class that builds the FilterSliderView page.
class FilterSliderController extends StatefulWidget {

  ///constructor for FilterSliderController
  FilterSliderController({Key key, this.SelectedList}) : super(key: key);
  /// value for SelectedList (boolean)
  List<bool> SelectedList;

  @override
  view.FilterSliderView createState() => view.FilterSliderView(SelectedList: SelectedList);

}