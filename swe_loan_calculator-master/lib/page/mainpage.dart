import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:swe_loan_calculator/model/Bookmark.dart';
import 'package:swe_loan_calculator/provider/google_sign_in.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:swe_loan_calculator/page/listviewpage.dart' as listviewpage;
import 'main_map.dart' as map_view;
import 'package:provider/provider.dart';
import 'package:swe_loan_calculator/Bookmark.dart';
import 'package:firebase_database/firebase_database.dart';




class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("HDB App")),
        body: Center(
            child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                      provider.logout();
                    },
                    child: Container(
                        alignment: Alignment.topRight,
                        child: Text('Logout')
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoanCalPage(),
                        ),
                      );
                    },
                    child: Text("Loan Calculator",
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30)),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), primary: Colors.black),
                      child: Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child:Icon(Icons.info_outline),
                      ),

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HelpPageView(),
                          ),
                        );
                      }),
                  GestureDetector(
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterPage(),
                        ),
                      );
                    },
                    child: Text("Search/Filter", style: TextStyle(fontWeight: FontWeight.w900, fontSize:30)), //Text
                  ),
                  GestureDetector(
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:(context) => map_view.MapPage(),
                        ),
                      );
                    },
                    child: Text("Map View", style: TextStyle(fontWeight: FontWeight.w900, fontSize:30)), //Text
                  ),
                ]
            )
        ));
  }
}

class HelpPageView extends StatefulWidget {
  @override
  HelpPageState createState() => HelpPageState();
}
class HelpPageState extends State<HelpPageView>{


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



class LoanCalPage extends StatefulWidget {

  LoanCalPage({Key key, this.presetPrincipal}) : super(key: key);
  final double presetPrincipal;

  @override
  _LoanCalPageState createState() => _LoanCalPageState();
}

class _LoanCalPageState extends State<LoanCalPage> {
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
          title: Text("Loan Calculator"),

          actions: <Widget>[
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
                        _Slider(presetPrincipal: widget.presetPrincipal,),],
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

class _Slider extends StatefulWidget {
  _Slider({Key key, this.presetPrincipal}) : super(key: key);
   double presetPrincipal;
  @override
  _SliderState createState() => _SliderState(presetPrincipal: presetPrincipal);
}

class _SliderState extends State<_Slider> {
  _SliderState({this.presetPrincipal});
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
                                builder: (context) => LoanVisualPage(
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

class LoanVisualPage extends StatelessWidget{
  final  double intValue;
  final int loanTenureValue;
  final int loanValue;
  final double principalValue;


  LoanVisualPage({Key key, this.title, this.loanTenureValue,
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
                            _MonthlyVisualisation(),
                            SizedBox(height: 20,),//intValue:intValue,
                            _TotalVisualisation(),
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

class LoanController{

  static double calculateTotalLoanAmount(double principalValue, int loanValue){
    return (loanValue/100)*principalValue;
  }

  static double calculateDownPayment(double principalValue, int loanValue ){
    return ((100-loanValue)/100)*principalValue;
  }

  static double calculateMonthlyPayment(double principalValue,double interestRate,int loanTenure,
      int loanValue){
    double totalLoanAmount = calculateTotalLoanAmount(principalValue, loanValue);
    return (totalLoanAmount*(interestRate))/(1-1/pow(1+interestRate,loanTenure))/12;
  }

  static double calculateMonthlyInterest(double principalValue, double interestRate, int loanValue){
    double totalLoanAmount = calculateTotalLoanAmount(principalValue, loanValue);
    return (totalLoanAmount*interestRate)/12;
  }

  static double calculateMonthlyLoanAmount(double principalValue, double interestRate,
      int loanTenure, int loanValue){
    return calculateMonthlyPayment(principalValue, interestRate, loanTenure,loanValue)-
        calculateMonthlyInterest(principalValue, interestRate,loanValue);
  }
}


class _MonthlyVisualisation extends StatefulWidget {
  final double intValue;
  final int loanTenureValue;
  final int loanValue;
  final double principalValue;

  _MonthlyVisualisation({Key key, this.intValue,this.loanTenureValue,
    this.principalValue, this.loanValue}) : super(key: key);
  @override
  _MonthlyVisualisationState createState() => _MonthlyVisualisationState();

}

class _MonthlyVisualisationState extends State<_MonthlyVisualisation> {

  //double interest=double.parse(intValue);
  Map<String, double> dataMap = {
    "Loan Amount ": LoanController.calculateMonthlyLoanAmount(
        _SliderState.getPrincipalValue(), _SliderState.getIntValue()/100,
        _SliderState.getLoanTenure(),_SliderState.getLoan()),
    "Interest ": LoanController.calculateMonthlyInterest(_SliderState.getPrincipalValue(), _SliderState.getIntValue()/100,_SliderState.getLoan())};

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
                    centerText:'\$' + LoanController.calculateMonthlyPayment(_SliderState.getPrincipalValue(), _SliderState.getIntValue()/100,
                        _SliderState.getLoanTenure(), _SliderState.getLoan()).toStringAsFixed(2) + "\n/month"
                )
            ),

          ),
        ]
    );
  }
}


class _TotalVisualisation extends StatefulWidget {
  @override
  _TotalVisualisationState createState() => _TotalVisualisationState();
}

class _TotalVisualisationState extends State<_TotalVisualisation> {
  Map<String, double> dataMap = {
    "Loan Amount ": LoanController.calculateTotalLoanAmount(_SliderState.getPrincipalValue(), _SliderState.getLoan()),
    "Down Payment ": LoanController.calculateDownPayment(_SliderState.getPrincipalValue(), _SliderState.getLoan()),};

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
                    centerText:'\$' +_SliderState.getPrincipalValue().toStringAsFixed(2)
                )
            )
        ),
      ],
    );

  }
}

/*class HDBListModel {

  final String apiUrl = "https://data.gov.sg/api/action/datastore_search?resource_id=42ff9cfe-abe5-4b54-beda-c88f9bb438ee&limit=92270";

  Future<List<dynamic>> fetchListings() async {
    var result = await http.get(apiUrl);
    //print('abc');
    //print(json.decode(result.body)['result']['records']);
    return json.decode(result.body)['result']['records'];
  }

  Future<HDBListingModel> getHDBListing() async {
    final response = await rootBundle.loadString('assets/HDBListings.json');
    return HDBListingModel.fromJson(json.decode(response));
  }

  static getPropertyValue(dynamic listing) {
    return listing['resale_price'];
  }

  static getFlatType(dynamic listing){
    return listing['flat_type'];
  }

  static getListingLocation(dynamic listing){
    return listing['town'];
  }

  static getRemainLease(dynamic listing){
    return listing['remaining_lease'];
  }

  static getFloorArea(dynamic listing){
    return listing['floor_area_sqm'];
  }


}*/

class HDBListModel {


}



class FilterPage extends StatelessWidget {
  FilterPage({Key key, this.title}) : super(key: key);
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
                        _Slider2(),
                      ],
                    )))));
  }
}

class _Slider2 extends StatefulWidget {



@override
  _SliderState2 createState() => _SliderState2();

}

class _SliderState2 extends State<_Slider2> {
  static String _principalValue = "500000";

  static int _upperPV = 200000;
  static int _lowerPV = 200000;

  static int _upperFlArea = 31;
  static int _lowerFlArea = 31;

  static int _remainLease = 0;

  static int _value1 = 1;

  static int _value2 = 1;
  var pulledList;


  var myController = TextEditingController();

  listviewpage.ListViewPage abc;

  Widget build(BuildContext context) {
    var BookmarkController = BookMarkController();
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
                            builder: (context) => listviewpage.ListViewPage(
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