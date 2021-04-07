
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swe_loan_calculator/controller/MonthlyVisualisationController.dart' as monthlyvisualisationcontroller;
import 'package:swe_loan_calculator/controller/TotalVisualisationController.dart' as totalvisualisationcontroller;
import 'package:swe_loan_calculator/page/mainpage.dart' as mainpage;

///Boundary class that displays the visualisations of the calculation by the oan calculator.
class LoanVisualView extends StatelessWidget{
  ///interest amount selected
  final  double intValue;
  ///loan tenure duration user selected
  final int loanTenureValue;
  /// loan value percentage user selected
  final int loanValue;
  /// principal amount used for calculation
  final double principalValue;
  ///attribute to determine which widgets to be included in the screenshot
  final ScreenshotController screenshotController = ScreenshotController();

  /// constructor for LoanVisualView
  LoanVisualView({Key key, this.title, this.loanTenureValue,
    this.principalValue, this.loanValue, this.intValue}) : super(key: key);
  final String title;



  ///method to build the structure of the loan visualisation page
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text("Loan Visualisation Page"),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => mainpage.HomePageStateful()));
                  },
                ),

                IconButton(
                  icon: const Icon(Icons.ios_share),
                  onPressed: () {
                    _takeScreenshotandShare();
                  },),],
            ),
            body: Screenshot(
                controller: screenshotController,
                child: Center(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            monthlyvisualisationcontroller.MonthlyVisualisationController(),
                            SizedBox(height: 20,),//intValue:intValue,
                            totalvisualisationcontroller.TotalVisualisationController(),
                          ],
                        )
                    )
                )
            )
        )
    );
  }
  ///method to take screen shot of widgets selected by the screenshot controller and share it to an external app.
  void _takeScreenshotandShare() async {
    final imageFile = await screenshotController.capture();
    Share.shareFiles([imageFile.path], text: "Shared from HDP App");
  }
}