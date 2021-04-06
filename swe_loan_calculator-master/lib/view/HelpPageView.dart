import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swe_loan_calculator/controller/HelpPageController.dart' as helppagecontroller;

///Boundary class that builds Widget for Help page view
class HelpPageView extends State<helppagecontroller.HelpPageController>{
  String helpText = " ";

  void fetchFileData() async{
    String responseText;
    responseText = await rootBundle.loadString('assets/helpPage.txt');

    setState(() {
      helpText = responseText;
    });
  }
  @override
  void initState(){
    fetchFileData();
    super.initState();
  }
  /// method to build widgets to display info on the help page
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text("Help"),
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/HDB Image.png'),
                    SizedBox(height: 10,),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(left: 15.0),
                      child: Text("About the application:",
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),

                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(10.0),
                      height: 120.0,
                      decoration: BoxDecoration(
                        color: CupertinoColors.lightBackgroundGray,
                        border: null,
                      ),
                      child: Text("HDB App is a dual purpose mobile application which enables users to firstly, source for potential HDB listings based on your preferred filter criteria and secondly, calculate potential total and monthly loan / interest payments.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(left: 15.0),
                      child: Text("Frequently Asked Questions:",
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(10.0),
                      height: 270.0,
                      decoration: BoxDecoration(
                        color: CupertinoColors.lightBackgroundGray,
                        border: null,
                      ),
                      child:Column(
                        children:<Widget>[
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(helpText,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )],
                ))));
  }



}