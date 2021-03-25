import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:swe_loan_calculator/src/HDBListings.dart' as locations;
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe_loan_calculator/src/HDBListings.dart' as HDBListings;
import 'package:swe_loan_calculator/page/mainpage.dart';
import 'package:swe_loan_calculator/src/shoppingmalls.dart' as ShoppingMalls;

import 'package:swe_loan_calculator/controller/controller.dart' as controller;
import 'package:swe_loan_calculator/model/model.dart' as model;


class HelpPageView extends State<controller.HelpPageController>{


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
                              child: Text(""" 
1. Question: How is the total and monthly loan payment breakdown derived?

Answer: It is derived based on the HDB Loan Interest Rates. 

2. Question: I have no preferred criteria, is it possible to just view all available listings? 

Answer: Yes! Simply press the 'Search' button without adjusting any of the filters! 

3. Question: Can I see the nearby facilities of listing choice? 

Answer: Yes, you can do so in the Detailed Property View! Scroll down and you'll see a map  and scroll bar with colour coded nearby facilities.  Alternatively, you can click the View on Map icon and view the property on the actual Google Map. 

4. Question: How can I view a save a listing for easy viewing later on? 

Answer: You can bookmark the listing through the listing view, map view or the individual property view! These bookmarked listings will appear on your home screen. If you change your mind, simply click the bookmark button again to un-bookmark it

5.Question: I see a listing that I like, can I share it?

Answer: Yes of course! You can share the listing on Whatsapp, Messenger and Telegram through the share button located at the top right hand corner of the Property View!
              """,
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


class LoanCalView extends State<controller.LoanCalController> {
  ScreenshotController screenshotController = ScreenshotController();

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
                Navigator.pushNamed(
                  context, '/',);
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
                        controller.LoanCalSliderController(presetPrincipal: widget.presetPrincipal,),],
                    ))
            )),
      ),
    );
  }
  void _takeScreenshotandShare() async {
    final imageFile = await screenshotController.capture();
    Share.shareFiles([imageFile.path], text: "Shared from HDP App");
  }
}


class LoanCalSliderView extends State<controller.LoanCalSliderController> {
  LoanCalSliderView({this.presetPrincipal});
  double presetPrincipal;
  static double _intValue = 0.0;
  static int _loanTenureValue = 1;
  static int _loanValue = 10;

  static String _principalValue;
  var myController = TextEditingController();

  String obtainPrincipal(double presetPrincipal) {
    if(presetPrincipal!=null) {
      return presetPrincipal.toString();
    } else {
      return '500000';
    }
  }

  Widget build(BuildContext context) {
    if(presetPrincipal!=null) {
      myController.text =  obtainPrincipal(presetPrincipal);
    }
    _principalValue = myController.text;
    return Column(
      children: <Widget>[
        Container(

            decoration: BoxDecoration(border: Border.all()),
            padding: EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text("Property Value",
                      style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: myController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 10.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 2.0),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => myController.clear(),
                          icon: Icon(Icons.clear),
                        ),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Interest Rate (%)",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                      SizedBox(width: 150),
                      Text(
                        _intValue.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                    ],
                  ),
                  Slider(
                    value: _intValue.toDouble(),
                    min: 0.0,
                    max: 4.0,
                    divisions: 40,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    label: _intValue.toString(),
                    onChanged: (double newValue) {
                      setState(() {
                        _intValue = newValue;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Loan Tenure (Years)",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                      SizedBox(width: 120),
                      Text(
                        _loanTenureValue.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                    ],
                  ),
                  Slider(
                    value: _loanTenureValue.toDouble(),
                    min: 1,
                    max: 30,
                    divisions: 29,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    label: _loanTenureValue.toString(),
                    onChanged: (double newValue) {
                      setState(() {
                        _loanTenureValue = newValue.round();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Loan (%)",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                      SizedBox(width: 223),
                      Text(
                        _loanValue.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                    ],
                  ),
                  Slider(
                    value: _loanValue.toDouble(),
                    min: 10,
                    max: 90,
                    divisions: 80,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    label: _loanValue.toString(),
                    onChanged: (double newValue) {
                      setState(() {
                        _loanValue = newValue.round();
                      });
                    },
                  ),
                ])),
        SizedBox(height: 10),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), primary: Colors.blue),
                  child: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Icon(Icons.update),
                  ),
                  onPressed: () {
                    setState(
                          () {
                        _intValue = 0;
                        _loanTenureValue = 1;
                        _loanValue = 10;
                        myController.clear();
                      },
                    );
                  }),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), primary: Colors.blue),
                  child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Text(
                        "GO",
                        style: TextStyle(fontSize: 16.0),
                      )),
                  onPressed: () {
                    setState(
                          () {
                        //enter change page here

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoanVisualView(
                                    intValue:_intValue,
                                    loanTenureValue:_loanTenureValue,
                                    loanValue:_loanValue,
                                    principalValue:checkNull(_principalValue)
                                )
                            )
                        );
                      },
                    );
                  }),
            ]),
      ],
    );

  }
  static double checkNull(String principalValue){
    try{return(double.parse(_principalValue));}
    catch(e){
      return 600000;}
  }
  static double getIntValue(){
    return _intValue;
  }
  static double getPrincipalValue(){
    return checkNull(_principalValue);
  }
  static int getLoanTenure(){
    return _loanTenureValue;
  }
  static int getLoan(){
    return _loanValue;
  }
}


class LoanVisualView extends StatelessWidget{
  final  double intValue;
  final int loanTenureValue;
  final int loanValue;
  final double principalValue;


  LoanVisualView({Key key, this.title, this.loanTenureValue,
    this.principalValue, this.loanValue, this.intValue}) : super(key: key);
  final String title;
  final ScreenshotController screenshotController = ScreenshotController();


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
              title: Text("Loan Visualisation Page"),actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage()));
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
                            controller.MonthlyVisualisationController(),
                            SizedBox(height: 20,),//intValue:intValue,
                            controller.TotalVisualisationController(),
                          ],
                        )
                    )
                )
            )
        )
    );
  }
  void _takeScreenshotandShare() async {
    final imageFile = await screenshotController.capture();
    Share.shareFiles([imageFile.path], text: "Shared from HDP App");
  }
}


class MonthlyVisualisationView extends State<controller.MonthlyVisualisationController> {

  //double interest=double.parse(intValue);
  Map<String, double> dataMap = {
    "Loan Amount ": controller.LoanController.calculateMonthlyLoanAmount(
        LoanCalSliderView.getPrincipalValue(), LoanCalSliderView.getIntValue()/100,
        LoanCalSliderView.getLoanTenure(),LoanCalSliderView.getLoan()),
    "Interest ": controller.LoanController.calculateMonthlyInterest(LoanCalSliderView.getPrincipalValue(), LoanCalSliderView.getIntValue()/100,LoanCalSliderView.getLoan())};

  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Text('Monthly Payment Breakdown',style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),),
          Container(
            decoration: BoxDecoration(border: Border.all()),
            padding: EdgeInsets.all(20),
            child:
            Container(
                child: PieChart(
                    dataMap: dataMap,
                    chartType: ChartType.ring,
                    chartRadius: 130,
                    animationDuration: Duration(milliseconds: 500),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValuesOutside: true,
                    ),
                    legendOptions: LegendOptions(
                      legendTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
                    ),
                    centerText:'\$' + controller.LoanController.calculateMonthlyPayment(LoanCalSliderView.getPrincipalValue(), LoanCalSliderView.getIntValue()/100,
                        LoanCalSliderView.getLoanTenure(), LoanCalSliderView.getLoan()).toStringAsFixed(2) + "\n/month"
                )
            ),

          ),
        ]
    );
  }
}


class TotalVisualisationView extends State<controller.TotalVisualisationController> {
  Map<String, double> dataMap = {
    "Loan Amount ": controller.LoanController.calculateTotalLoanAmount(LoanCalSliderView.getPrincipalValue(), LoanCalSliderView.getLoan()),
    "Down Payment ": controller.LoanController.calculateDownPayment(LoanCalSliderView.getPrincipalValue(), LoanCalSliderView.getLoan()),};

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Total Payment Breakdown',style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),),
        Container(
            decoration: BoxDecoration(border: Border.all()),
            padding: EdgeInsets.all(20),
            child:
            Container(
                child: PieChart(
                    dataMap: dataMap,
                    chartType: ChartType.ring,
                    chartRadius: 130,
                    animationDuration: Duration(milliseconds: 500),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValuesOutside: true,
                    ),
                    legendOptions: LegendOptions(
                      legendTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
                    ),
                    centerText:'\$' +LoanCalSliderView.getPrincipalValue().toStringAsFixed(2)
                )
            )
        ),
      ],
    );

  }
}


class FilterView extends StatelessWidget {
  FilterView({Key key, this.title}) : super(key: key);
  final String title;
  var pulledList;


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
              title: Text("Search/Filter"),
            ),
            body: Center(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        controller.FilterSliderController(),
                      ],
                    )
                )
            )
        )
    );
  }
}


class FilterSliderView extends State<controller.FilterSliderController> {


  static String _principalValue = "500000";
  /// The default value of the upper limit for Principal Value of the listing.
  static int _upperPV = 200000;
  /// The default value of the lower limit for Principal Value of the listing.
  static int _lowerPV = 200000;
  /// The default value of the upper limit for Floor Area of the listing.
  static int _upperFlArea = 31;
  /// The default value of the lower limit for Floor Area of the listing.
  static int _lowerFlArea = 31;
  /// The default value for the remaining number of years left on the lease of the listing.
  static int _remainLease = 0;
  /// The default value for the Flat Type of the listing.
  static int _value1 = 1;
  /// The default value for the Location of the listing.
  static int _value2 = 1;
  var pulledList;


  var myController = TextEditingController();

  Widget build(BuildContext context) {
    var BookmarkController = controller.BookMarkController();
    var user = BookmarkController.user;
    List update(){
      BookmarkController.databaseReference.child('bookmark/'+user+'/bookMarkList/').once().then(
              (DataSnapshot data){
            setState((){
              pulledList = data.value;
            });
          }
      );
      return pulledList;
    }


    return Column(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(border: Border.all()),
            padding: EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text("Flat Type",
                      style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: DropdownButton(
                      /// This dropdownbutton is used for _value1, the flat type of the listing, where value:1 = "1 Room", etc.
                        value: _value1,
                        items: [
                          DropdownMenuItem(
                            child: Text("1 Room"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                              child: Text("2 Room"),
                              value: 2
                          ),
                          DropdownMenuItem(
                              child: Text("3 Room"),
                              value: 3
                          ),
                          DropdownMenuItem(
                              child: Text("4 Room"),
                              value: 4
                          ),
                          DropdownMenuItem(
                              child: Text("5 Room"),
                              value: 5
                          ),
                          DropdownMenuItem(
                              child: Text("Executive"),
                              value: 6
                          ),
                          DropdownMenuItem(
                              child: Text("Multi-Generation"),
                              value: 7
                          )
                        ],
                        onChanged: (value){
                          setState((){
                            _value1 = value;
                          });
                        }

                    ),
                  ),
                  Text("Location",
                      style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: DropdownButton(
                      /// This dropdownbutton is used for _value2, the location type of the listing, where value:1 = "Ang Mo Kio", etc.
                        value: _value2,
                        items: [
                          DropdownMenuItem(
                            child: Text("Ang Mo Kio"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Bedok"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text("Bishan"),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text("Bukit Batok"),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: Text("Bukit Merah"),
                            value: 5,
                          ),
                          DropdownMenuItem(
                            child: Text("Bukit Panjang"),
                            value: 6,
                          ),
                          DropdownMenuItem(
                            child: Text("Bukit Timah"),
                            value: 7,
                          )
                        ],
                        onChanged: (value){
                          setState((){
                            _value2 = value;
                          });
                        }

                    ),
                  ),
                  SizedBox(height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Upper Property Value",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                      SizedBox(width: 50),
                      Text(
                        _upperPV.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                    ],
                  ),
                  Slider(
                    /// This slider is used to set the upper principal value of the listing.
                    value: _upperPV.toDouble(),
                    min: 200000,
                    max: 1000000,
                    divisions: 1000,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    label: _upperPV.toString(),
                    onChanged: (double newValue) {
                      setState(() {
                        _upperPV = newValue.round();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Lower Property Value",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                      SizedBox(width: 50),
                      Text(
                        _lowerPV.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                    ],
                  ),
                  Slider(
                    /// This slider is used to set the lower principal value of the listing.
                    value: _lowerPV.toDouble(),
                    min: 200000,
                    max: 1000000,
                    divisions: 29,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    label: _lowerPV.toString(),
                    onChanged: (double newValue) {
                      setState(() {
                        _lowerPV = newValue.round();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Upper Floor Area",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                      SizedBox(width: 100),
                      Text(
                        _upperFlArea.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                    ],
                  ),
                  Slider(
                    /// This slider is used to set the upper floor area of the listing.
                    value: _upperFlArea.toDouble(),
                    min: 31,
                    max: 249,
                    divisions: 218,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    label: _upperFlArea.toString(),
                    onChanged: (double newValue) {
                      setState(() {
                        _upperFlArea = newValue.round();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Lower Floor Area",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                      SizedBox(width: 100),
                      Text(
                        _lowerFlArea.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                    ],
                  ),
                  Slider(
                    /// This slider is used to set the lower floor area of the listing.
                    value: _lowerFlArea.toDouble(),
                    min: 31,
                    max: 249,
                    divisions: 218,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    label: _lowerFlArea.toString(),
                    onChanged: (double newValue) {
                      setState(() {
                        _lowerFlArea = newValue.round();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Remaining Lease",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                      SizedBox(width: 100),
                      Text(
                        _remainLease.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                    ],
                  ),
                  Slider(
                    /// This slider is used to set the remaining number of years left on the lease of the listing.
                    value: _remainLease.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    label: _remainLease.toString(),
                    onChanged: (double newValue) {
                      setState(() {
                        _remainLease = newValue.round();
                      });
                    },
                  ),

                ])),
        SizedBox(height: 1),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton(
                /// This is the reset button, used to set all the variables back to their default value.
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), primary: Colors.blue),
                  child: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Icon(Icons.update),
                  ),
                  onPressed: () {
                    setState(
                          () {
                        _lowerPV = 200000;
                        _upperPV = 200000;
                        _lowerFlArea = 31;
                        _upperFlArea = 31;
                        _remainLease = 0;
                        _value1 = 1;
                        _value2 = 1;
                        myController.clear();
                      },
                    );
                  }),
              ElevatedButton(
                /// This is the button used to confirm and pass the variables that will be used to filter the listings, into the next class ListViewPage.
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), primary: Colors.blue),
                  child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Text(
                        "GO",
                        style: TextStyle(fontSize: 16.0),
                      )),
                  onPressed: () async{
                    pulledList=update();
                    var checkList =[];
                    int j;
                    try{
                      j = pulledList.length;
                    }
                    catch(e){
                      j=0;
                    }
                    for(var i=0;i< j;i++){
                      if(!checkList.contains(pulledList[i]))
                      {checkList.add(pulledList[i]);}
                    }
                    final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => controller.ListPageController(
                              upperPV: _upperPV,
                              lowerPV: _lowerPV,
                              upperFlArea: _upperFlArea,
                              lowerFlArea: _lowerFlArea,
                              value1: _value1,
                              value2: _value2,
                              remainLease: _remainLease,
                              pulledList: pulledList,
                              checkList: checkList,

                            )
                        )
                    );




                  }),
            ]),

      ],
    );


  }

  static double checkNull(String principalValue){
    try{return(double.parse(_principalValue));}
    catch(e){
      return 500000;}
  }
  static int getupperPV(){
    return _upperPV;
  }
  static int getlowerPV(){
    return _lowerPV;
  }
  static int getupperFlArea(){
    return _upperFlArea;
  }
  static int getlowerFlArea(){
    return _lowerFlArea;
  }
  static int getremainLease(){
    return _remainLease;
  }
}


class ListPageView extends State<controller.ListPageController> {

  final List bookmarkList = [];
  var BookmarkController = controller.BookMarkController();

  Future<List<locations.HDBListing>> filtered_hdb;



  Future<List<locations.HDBListing>> _onMapView() async {
    final HDBData = await locations.getHDBListing();
    final List<locations.HDBListing> finalList = [];
    //print(HDBData);
    if (true) {
      for (final listing in HDBData.items) {
        if (widget.lowerPV != 200000 ||
            widget.upperPV != 200000 ||
            widget.lowerFlArea != 31 ||
            widget.upperFlArea != 31) {
          if (widget.lowerPV < listing.resale_price &&
              listing.resale_price < widget.upperPV &&
              widget.lowerFlArea < listing.floor_area_sqm &&
              listing.floor_area_sqm < widget.upperFlArea) {
            finalList.add(listing);
          }
        }
      }
      return finalList;
    }
  }

  @override
  Widget build(BuildContext context)  {
    var count =0;
    filtered_hdb = _onMapView();
    //checkList=widget.pulledList;

    var BookMarkItem = model.BookMarkInfoModel(bookmarkList, widget.user);


    if(widget.pulledList == null ){
      widget.pulledList=[];
      count++;
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('HDB Lists (Filtered)'+widget.checkList.length.toString()),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => controller.BookmarkPageController(BookMarkItem,widget.checkList)),
                  );
                });
              })
        ],
      ),
      body: Container(
          child: FutureBuilder<List>(
            //future: Future.wait([filtered_hdb,FirebaseDatabase.instance.reference().child('bookmark/'+user).once()]),
            //builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              future:filtered_hdb,
              builder: (context, snapshot) {
                if (snapshot.hasData) {

                  List<locations.HDBListing> filtered_hdb1 = snapshot.data;

                  // List<locations.HDBListing> filtered_hdb1 = snapshot.data[0];
                  //List pulledList1 = snapshot.data[1];
                  //for(var i in pulledList1){
                  // checkList.add(i);
                  //}


                  return ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {

                        var isBookmarked =
                        //BookMarkItem.bookMarkedList.contains(filtered_hdb1[index]);
                        widget.checkList.contains(filtered_hdb1[index].ID);



                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, '/third',
                                  arguments: filtered_hdb1[index]);
                            },
                            title: Text('price: ' +
                                filtered_hdb1[index].resale_price.toString() +
                                '\n' +
                                'address: ' +
                                filtered_hdb1[index].address +
                                '\n' +
                                'floor_area: ' +
                                filtered_hdb1[index].floor_area_sqm.toString() +
                                '\n' +
                                'remaining_lease: ' +
                                filtered_hdb1[index].remaining_lease),
                            trailing: Wrap(
                              spacing: -20,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    isBookmarked
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: isBookmarked ? Colors.black : null,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (isBookmarked) {
                                        //BookMarkItem.bookMarkedList.remove(filtered_hdb1[index]);
                                        widget.checkList.remove(filtered_hdb1[index].ID);
                                      } else {
                                        //BookMarkItem.bookMarkedList.add(filtered_hdb1[index]);
                                        widget.checkList.add(filtered_hdb1[index].ID);
                                      }
                                    });
                                    BookMarkItem.bookMarkedList=widget.checkList;
                                    BookmarkController.saveBookmark(BookMarkItem);
                                  },
                                ),
                                IconButton(
                                    icon: Icon(Icons.calculate_outlined),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => controller.LoanCalController(presetPrincipal: filtered_hdb1[index].resale_price,),
                                        ),
                                      );
                                    }
                                ),
                              ],
                            ),

                          ),
                        );
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/fourth',
              //arguments: );
              arguments: _onMapView());
        },
        child: const Icon(Icons.map),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


class FullDetailsView extends State<controller.FullDetailsController> {

  final Marker HDBmarker = Marker();

  HDBListings.HDBListing hdb;


  final Map<String, Marker> _markers = {};


  GoogleMapController controller;


  Future<void> _onMapCreated(GoogleMapController controller) async {
    final shoppingMalls = await ShoppingMalls.getShoppingMalls();
    setState(() {
      _markers.clear();
      final HDBMarker = Marker(
        markerId: MarkerId(hdb.address),
        position: LatLng(hdb.latitude,hdb.longitude),
        infoWindow: InfoWindow(title: hdb.address, snippet: "HDB Listing"),

      );
      _markers[hdb.address] = HDBMarker;
    });
  }
  @override
  Widget build(BuildContext context) {

    hdb = ModalRoute.of(context).settings.arguments;
    //print(hdb.town);


    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title: Text('Property View'),
          backgroundColor: Colors.green[700],
        ),
        body: GestureDetector(
          child: _detailsBody(hdb),
        ),
      ),
    );
  }

  Widget _detailsBody(hdb) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
      children: [Text('Resale price: ${hdb.resale_price}',
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25, color: Colors.black87),
        textAlign: TextAlign.left,
      ),
        Text('Address: ${hdb.address}',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black87),
          textAlign: TextAlign.left,
        ),
        Text('Type: ${hdb.flat_model}',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Colors.black45),
          textAlign: TextAlign.left,
        ),
        Text('Area: ${hdb.town}',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Colors.black45),
          textAlign: TextAlign.left,
        ),
        Text('Property Details',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Colors.black87),
          textAlign: TextAlign.left,
        ),

        RichText(
          text: TextSpan(
            text: 'Size: ',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15, color: Colors.black87),
            children: <TextSpan>[
              TextSpan(text: '${hdb.floor_area_sqm} sqm', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.black54))
            ],
          ),
          textAlign : TextAlign.center,
        ),
        RichText(
          text: TextSpan(
            text: 'Remaining Lease: ',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15, color: Colors.black87),
            children: <TextSpan>[
              TextSpan(text: '${hdb.remaining_lease}', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.black54))
            ],
          ),
          textAlign : TextAlign.center,
        ),
        model.MapModel(
          center: LatLng(hdb.latitude, hdb.longitude), // replace this
          mapController: controller,
          onMapCreated: _onMapCreated,
          markers: _markers,
        ),
      ],
    );
  }


}


class MapPageView extends State<controller.MapPageController> {

  List<HDBListings.HDBListing> filtered_hdb;

  final Map<String, Marker> _markers = {};
  GoogleMapController controller;

  Future<void> _onMapCreated(GoogleMapController controller) async {

    filtered_hdb = await ModalRoute.of(context).settings.arguments;
    print('abc');
    print(filtered_hdb[3].longitude);
    // final googleOffices = await locations.getHDBListing();
    setState(() {
      _markers.clear();
      for (final office in filtered_hdb) {
        final marker = Marker(
          markerId: MarkerId(office.address),
          position: LatLng(office.latitude, office.longitude),
          infoWindow: InfoWindow(
            title: office.address,
            snippet: r'$''{$office.resale_price.toString()}',
          ),
        );
        _markers[office.address] = marker;
      }
    });
  }



  @override
  Widget build(BuildContext context) {


    return MaterialApp(home:Scaffold(
      appBar: AppBar(
        title: Text('Map View'),
        backgroundColor: Colors.blue[700],
      ),
      body: GestureDetector(
        child: model.MapModel(
          center: const LatLng(1.32787,103.84421),
          mapController: controller,
          onMapCreated: _onMapCreated,
          markers: _markers,
        ),
      ),
    ),
    );
  }

  Widget _detailsBody() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
      children: [
        model.MapModel(
          center: const LatLng(1.326124169,103.8437095),
          mapController: controller,
          onMapCreated: _onMapCreated,
          markers: _markers,
        ),      ],
    );
  }


}


class BookmarkPageView extends State<controller.BookmarkPageController>{
  Widget build(BuildContext context) {
    var BookmarkList =  widget.update(widget.checkList);

    return Scaffold(
        appBar: AppBar(
          title: Text('Bookmarks'),
        ),
        body: Container(
            child: FutureBuilder<List<locations.HDBListing>>(
              future: BookmarkList,
              builder: (context, snapshot){
                var BookmarkList1 = snapshot.data;
                var max = snapshot.data.length;
                return ListView.builder(


                  padding: EdgeInsets.all(16),

                  physics: BouncingScrollPhysics(),
                  itemCount: max,
                  itemBuilder: (context, index) {

                    final user = BookmarkList1[index];

                    return ListTile(

                      onTap: () { Navigator.pushNamed(context, '/third', arguments: user) ;},
                      title: Text(user.address + ", ID: " + user.ID.toString()),
                      subtitle: Text(user.resale_price.toString()),

                    );
                  },
                );
              },
            )
        )
    );
  }
}