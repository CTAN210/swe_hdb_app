import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swe_loan_calculator/controller/LoanCalController.dart' as loancalcontroller;
import 'package:swe_loan_calculator/controller/LoanCalSliderController.dart' as loancalslidercontroller;

/// Boundary class that contains the structure of the Loan Calculator View page.
class LoanCalView extends State<loancalcontroller.LoanCalController> {
  ///attribute to determine which widgets to be included in the screenshot
  ScreenshotController screenshotController = ScreenshotController();
  ///Method that builds widget. This includes the widgets included in the appbar such as homepage button and screenshot button.
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
          title: Text('Loan Calculator'),

          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/first',(_) => false
                );
              },
            ),

            IconButton(
              icon: const Icon(Icons.ios_share),
              onPressed: () {
                _takeScreenshotandShare();
              },),
          ],
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(10),

                child: Screenshot(
                    controller: screenshotController,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        loancalslidercontroller.LoanCalSliderController(presetPrincipal: widget.presetPrincipal,),],
                    ))
            )),
      ),
    );
  }
  ///method to take screenshot and share to external apps.
  void _takeScreenshotandShare() async {
    final imageFile = await screenshotController.capture();
    Share.shareFiles([imageFile.path], text: "Shared from HDB App");
  }
}