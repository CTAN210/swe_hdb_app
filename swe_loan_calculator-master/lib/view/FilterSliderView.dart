import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swe_loan_calculator/controller/BookMarkController.dart' as bookmarkcontroller;
import 'package:swe_loan_calculator/controller/FilterController.dart' as listpagecontroller;
import 'package:swe_loan_calculator/controller/FilterSliderController.dart' as filterslidercontroller;

///Boundary class for the Filter slider page that allows users to input values for the filtering
class FilterSliderView extends State<filterslidercontroller.FilterSliderController> {


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
  static int _FlatTypeValue = 1;
  /// The default value for the Location of the listing.
  static int _LocationValue = 1;
  var pulledList;


/*  void fetchBookmarkData(){
    var BookmarkController = controller.BookMarkController();
    var user = BookmarkController.user;
    BookmarkController.databaseReference.child('bookmark/'+user+'/bookMarkList/').once().then(
            (DataSnapshot data){
          setState((){
            pulledList = data.value;
          });
        }
    );
  }
  @override
  void initState(){
    fetchBookmarkData();
    super.initState();
  }*/

  var myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var BookmarkController = bookmarkcontroller.BookMarkController();
    var user = BookmarkController.user;
/*    List update(){
      BookmarkController.databaseReference.child('bookmark/'+user+'/bookMarkList/').once().then(
              (DataSnapshot data){
            setState((){
              pulledList = data.value;
            });
          }
      );
      return pulledList;
    }*/


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
                        value: _FlatTypeValue,
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
                            _FlatTypeValue = value;
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
                        value: _LocationValue,
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
                          ),
                          DropdownMenuItem(
                            child: Text("Central Area"),
                            value: 8,
                          ),
                          DropdownMenuItem(
                            child: Text("Choa Chu Kang"),
                            value: 9,
                          ),
                          DropdownMenuItem(
                            child: Text("Clementi"),
                            value: 10,
                          ),
                          DropdownMenuItem(
                            child: Text("Geylang"),
                            value: 11,
                          ),
                          DropdownMenuItem(
                            child: Text("Hougang"),
                            value: 12,
                          ),
                          DropdownMenuItem(
                            child: Text("Jurong East"),
                            value: 13,
                          ),
                          DropdownMenuItem(
                            child: Text("Jurong West"),
                            value: 14,
                          ),
                          DropdownMenuItem(
                            child: Text("Kallang / Whampoa"),
                            value: 15,
                          ),
                          DropdownMenuItem(
                            child: Text("Marina Parade"),
                            value: 16,
                          ),
                          DropdownMenuItem(
                            child: Text("Pasir Ris"),
                            value: 17,
                          ),
                          DropdownMenuItem(
                            child: Text("Punggol"),
                            value: 18,
                          ),
                          DropdownMenuItem(
                            child: Text("Queenstown"),
                            value: 19,
                          ),
                          DropdownMenuItem(
                            child: Text("Sembawang"),
                            value: 20,
                          ),
                          DropdownMenuItem(
                            child: Text("Sengkang"),
                            value: 21,
                          ),
                          DropdownMenuItem(
                            child: Text("Serangoon"),
                            value: 22,
                          ),
                          DropdownMenuItem(
                            child: Text("Tampines"),
                            value: 23,
                          ),
                          DropdownMenuItem(
                            child: Text("Toa Payoh"),
                            value: 24,
                          ),
                          DropdownMenuItem(
                            child: Text("Woodlands"),
                            value: 25,
                          ),
                          DropdownMenuItem(
                            child: Text("Yishun"),
                            value: 26,
                          ),
                        ],
                        onChanged: (value){
                          setState((){
                            _LocationValue = value;
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
                        _FlatTypeValue = 1;
                        _LocationValue = 1;
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
                            builder: (context) => listpagecontroller.FilterController(
                              upperPV: _upperPV,
                              lowerPV: _lowerPV,
                              upperFlArea: _upperFlArea,
                              lowerFlArea: _lowerFlArea,
                              FlatTypeValue: _FlatTypeValue,
                              LocationValue: _LocationValue,
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