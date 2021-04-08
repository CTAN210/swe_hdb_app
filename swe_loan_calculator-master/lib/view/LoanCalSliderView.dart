import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swe_loan_calculator/controller/LoanCalSliderController.dart'
    as loancalslidercontroller;
import 'package:swe_loan_calculator/view/LoanVisualView.dart' as loanvisualview;

/// Boundary class for the Loan calculator slider page that allow users to input values for the calculation.
class LoanCalSliderView
    extends State<loancalslidercontroller.LoanCalSliderController> {
  LoanCalSliderView({this.presetPrincipal});

  /// value passed in from the constructor for fixed Principal value calculations.
  /// If it is null, a general loan calculator is used.
  /// If there is a preset princiapl, the fixed loan calculator is used.
  double presetPrincipal;

  /// the default interest value
  static double _intValue = 0.1;

  /// the default loan tenure duration
  static int _loanTenureValue = 1;

  /// the default loan percentage
  static int _loanValue = 10;

  /// string to store the principal value user inputs.
  static String _principalValue;

  /// attribute used to determine the text entered by the user.
  var myController = TextEditingController();
  bool valid = true;

  /// method to determine the principal value to be used based on whether its a
  /// fixed loan calculator or general loan calculator.
  String obtainPrincipal(double presetPrincipal) {
    if (presetPrincipal != null) {
      return presetPrincipal.toString();
    } else {
      return '500000';
    }
  }

  @override
  void initState() {
    myController = TextEditingController();
    super.initState();
  }

  @override

  ///build method to construct the slider widgets for the user to enter the values for the calculation.
  Widget build(BuildContext context) {
    if (presetPrincipal != null) {
      myController.text = obtainPrincipal(presetPrincipal);
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
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: myController,
                      maxLength: 8,
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
                        _intValue.toStringAsFixed(1),
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                    ],
                  ),
                  Slider(
                    value: _intValue.toDouble(),
                    min: 0.1,
                    max: 4.0,
                    divisions: 39,
                    label: _intValue.toStringAsFixed(1),
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
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
        SizedBox(height: 8),
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
                                builder: (context) =>
                                    loanvisualview.LoanVisualView(
                                        intValue: _intValue,
                                        loanTenureValue: _loanTenureValue,
                                        loanValue: _loanValue,
                                        principalValue:
                                            checkNull(_principalValue))));
                      },
                    );
                  }),
            ]),
      ],
    );
  }

  ///method to check if principalValue entered by user is null. If null, returns default value of 600000.
  static double checkNull(String principalValue) {
    try {
      return (double.parse(_principalValue));
    } catch (e) {
      return 600000;
    }
  }

  ///get method to obtain interest value
  static double getIntValue() {
    return _intValue;
  }

  /// get method to obtain principal value
  static double getPrincipalValue() {
    return checkNull(_principalValue);
  }

  ///get method to obtain Loan Tenure duration
  static int getLoanTenure() {
    return _loanTenureValue;
  }

  ///get method to obtain Loan percentage.
  static int getLoan() {
    return _loanValue;
  }
}
