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
import 'package:flutter/services.dart' show rootBundle;

///Boundary class that builds Widget for Help page view
class HelpPageView extends State<controller.HelpPageController>{
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

/// Boundary class that contains the structure of the Loan Calculator View page.
class LoanCalView extends State<controller.LoanCalController> {
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
  ///method to take screenshot and share to external apps.
  void _takeScreenshotandShare() async {
    final imageFile = await screenshotController.capture();
    Share.shareFiles([imageFile.path], text: "Shared from HDP App");
  }
}

/// Boundary class for the Loan calculator slider page that allow users to input values for the calculation.
class LoanCalSliderView extends State<controller.LoanCalSliderController> {
  LoanCalSliderView({this.presetPrincipal});
  /// value passed in from the constructor for fixed Principal value calculations.
  /// If it is null, a general loan calculator is used.
  /// If there is a preset princiapl, the fixed loan calculator is used.
  double presetPrincipal;
  /// the default interest value
  static double _intValue = 0.0;
  /// the default loan tenure duration
  static int _loanTenureValue = 1;
  /// the default loan percentage
  static int _loanValue = 10;
  /// string to store the principal value user inputs.
  static String _principalValue;
  /// attribute used to determine the text entered by the user.
  var myController = TextEditingController();

  /// method to determine the principal value to be used based on whether its a
  /// fixed loan calculator or general loan calculator.
  String obtainPrincipal(double presetPrincipal) {
    if(presetPrincipal!=null) {
      return presetPrincipal.toString();
    } else {
      return '500000';
    }
  }
  ///build method to construct the slider widgets for the user to enter the values for the calculation.
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
  ///method to check if principalValue entered by user is null. If null, returns default value of 600000.
  static double checkNull(String principalValue){
    try{return(double.parse(_principalValue));}
    catch(e){
      return 600000;}
  }
  ///get method to obtain interest value
  static double getIntValue(){
    return _intValue;
  }
  /// get method to obtain principal value
  static double getPrincipalValue(){
    return checkNull(_principalValue);
  }
  ///get method to obtain Loan Tenure duration
  static int getLoanTenure(){
    return _loanTenureValue;
  }
  ///get method to obtain Loan percentage.
  static int getLoan(){
    return _loanValue;
  }
}

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
              title: Text("Loan Visualisation Page"),actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePageStateful()));
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
  ///method to take screen shot of widgets selected by the screenshot controller and share it to an external app.
  void _takeScreenshotandShare() async {
    final imageFile = await screenshotController.capture();
    Share.shareFiles([imageFile.path], text: "Shared from HDP App");
  }
}

///boundary class that shows the monthly component of the loan visualisation
class MonthlyVisualisationView extends State<controller.MonthlyVisualisationController> {
  ///datamap used to store the values to be displayed by the piechart.
  Map<String, double> dataMap = {
    "Loan Amount ": controller.LoanController.calculateMonthlyLoanAmount(
        LoanCalSliderView.getPrincipalValue(), LoanCalSliderView.getIntValue()/100,
        LoanCalSliderView.getLoanTenure(),LoanCalSliderView.getLoan()),
    "Interest ": controller.LoanController.calculateMonthlyInterest(LoanCalSliderView.getPrincipalValue(), LoanCalSliderView.getIntValue()/100,LoanCalSliderView.getLoan())};

  ///method used to build the widget to visualise the monthly payment component of the loan visualisation.
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

///boundary class that shows the total component of the loan visualisation
class TotalVisualisationView extends State<controller.TotalVisualisationController> {
  ///datamap used to store the values to be displayed by the piechart.
  Map<String, double> dataMap = {
    "Loan Amount ": controller.LoanController.calculateTotalLoanAmount(LoanCalSliderView.getPrincipalValue(), LoanCalSliderView.getLoan()),
    "Down Payment ": controller.LoanController.calculateDownPayment(LoanCalSliderView.getPrincipalValue(), LoanCalSliderView.getLoan()),};
  ///method used to build the widget to visualise the monthly payment component of the loan visualisation.
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

///Boundary class that contains the structure of the Filter page
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
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/first',(_) => false
                  );
                },
              ),
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

///Boundary class for the Filter slider page that allows users to input values for the filtering
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
  @override
  Widget build(BuildContext context) {
    var BookmarkController = controller.BookMarkController();
    var user = BookmarkController.user;

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

/// Class to organise the display of Filtered HDB Listings on a List View
class ListPageView extends State<controller.ListPageController> {
  /// List of Bookmarked HDB Listings
  final List bookmarkList = [];
  var checkList=[];
  /// Controller that handles the logic behind Bookmarking a HDBListings
  var BookmarkController = controller.BookMarkController();
  /// List of Filtered HDB
  Future<List<locations.HDBListing>> filtered_hdb;
  /// update the checkList with list from the database.
  void fetchBookmarkData(){
    var user = BookmarkController.user;
    BookmarkController.databaseReference.child('bookmark/'+user+'/bookMarkList/').once().then(
            (DataSnapshot data){
          setState((){
            checkList=[];
            widget.pulledList = data.value;
            int j;
            try{
              j = widget.pulledList.length;
            }
            catch(e){
              j=0;
            }
            for(var i=0;i< j;i++){
              if(!checkList.contains(widget.pulledList[i]))
              {checkList.add(widget.pulledList[i]);}
            }
          });
        }
    );
  }

  @override
  ///constantly update the checklist.
  void initState(){
    fetchBookmarkData();
    super.initState();
  }



  /// Function to set markers on Google Map
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

  /// Function to organise display of entire List View Page
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
        title: Text('HDB Lists (Filtered)'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/first',(_) => false
                  );



            },
          ),
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



                  return ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {

                        var isBookmarked =
                        //BookMarkItem.bookMarkedList.contains(filtered_hdb1[index]);
                        checkList.contains(filtered_hdb1[index].ID);



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
                                filtered_hdb1[index].remaining_lease +
                                '\n' +
                                filtered_hdb1[index].flat_type),
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
                                        checkList.remove(filtered_hdb1[index].ID);
                                      } else {
                                        //BookMarkItem.bookMarkedList.add(filtered_hdb1[index]);
                                        checkList.add(filtered_hdb1[index].ID);
                                      }
                                    });
                                    BookMarkItem.bookMarkedList=checkList;
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

/// Class to organise the display of Full Details of a HDB Listing
class FullDetailsView extends State<controller.FullDetailsController> {
  /// Marker to display exact location of a HDB Listing on the Proximity Map
  final Marker HDBMarker = Marker();
  /// Specific HDB Listing to be displayed
  HDBListings.HDBListing hdb;

  /// Markers to display exact locations of Shopping Malls in Singapore
  final Map<String, Marker> _markers = {};

  /// Controller to control logic of displaying Proximity Map using Google Maps API
  GoogleMapController controller;

  /// Function to set markers on Proximity Map
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
  /// Function to organise display of entire Full Details Page
  @override
  Widget build(BuildContext context) {

    hdb = ModalRoute.of(context).settings.arguments;
    print(hdb.latitude.toString() + ',' + hdb.longitude.toString());


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

  /// Function to organise the display of details extracted from specific HDB Listing
  Widget _detailsBody(hdb) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
      children: [Text('Resale price: ' + hdb.resale_price.toString(),
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25, color: Colors.black87),
        textAlign: TextAlign.left,
      ),
        Text('Address: ' + hdb.address,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black87),
          textAlign: TextAlign.left,
        ),
        Text('Type: ' + hdb.flat_type,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: Colors.black45),
          textAlign: TextAlign.left,
        ),
        Text('Area: ' + hdb.town,
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
          center: LatLng(hdb.latitude, hdb.longitude),
          mapController: controller,
          onMapCreated: _onMapCreated,
          markers: _markers,
        ),
      ],
    );
  }


}

/// Class to organise the display of Filtered HDB Listings on a GoogleMap
class MapPageView extends State<controller.MapPageController> {
  /// List of HDB Listings that fit within Filter Conditions
  List<HDBListings.HDBListing> filtered_hdb;
  /// List of markers to highlight the exact location of Filtered HDB Listings on a Map
  final Map<String, Marker> _markers = {};
  /// Controller to control logic of displaying Google Map using Google Maps API
  GoogleMapController controller;
  /// Function to set markers on Google Map
  Future<void> _onMapCreated(GoogleMapController controller) async {

    filtered_hdb = await ModalRoute.of(context).settings.arguments;
    print('FILTERED HDB MAP VIEW WORKING');
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


  /// Function to organise display of entire Map Page
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
  /// Function to organise the display of Google Map and markers of filtered HDB Listings
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
/*  var  updatedList =[];
  void updateList(){
    var BookmarkController = controller.BookMarkController();
    var user = BookmarkController.user;
    BookmarkController.databaseReference.child('bookmark/'+user+'/bookMarkList/').once().then(
            (DataSnapshot data){
          setState((){
            //bookmarkList=[];
            updatedList = data.value;
          });
        }
    );
  }

  @override
  void initState(){
    build(context);
    super.initState();
  }*/
  @override
  Widget build(BuildContext context) {

    var BookmarkList =  widget.update(widget.bookmarkList);



          return Container(
            child: FutureBuilder<List<locations.HDBListing>>(
              future: BookmarkList,
              builder: (context, snapshot){
                var max=0;
                try{
                  max = snapshot.data.length;
                }
                catch(e){
                  max=0;
                }
                var BookmarkList1 = snapshot.data;
                //max = snapshot.data.length;
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(16),
                    //physics: BouncingScrollPhysics(),
                    itemCount: max,
                    itemBuilder: (context, index) {

                      final user = BookmarkList1[index];

                      return Card(
                          child:ListTile(
                        onTap: () { Navigator.pushNamed(context, '/third', arguments: user) ;},
                        title: Text(user.address + ", ID: " + user.ID.toString()),
                        subtitle: Text(user.resale_price.toString()),

                      )
                      );
                    },
                  )
                );
              },
            )
          );



  }
}