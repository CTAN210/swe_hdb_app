import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swe_loan_calculator/controller/BookMarkController.dart' as bookmarkcontroller;
import 'package:swe_loan_calculator/controller/FilterController.dart' as filtercontroller;
import 'package:swe_loan_calculator/controller/FilterSliderController.dart' as filterslidercontroller;
import 'package:swe_loan_calculator/main.dart';

///Boundary class for the Filter slider page that allows users to input values for the filtering
class FilterSliderView extends State<filterslidercontroller.FilterSliderController> {
  FilterSliderView({this.SelectedList});
  /// List passed in from the constructor for Filter Slider. This boolean list allows us to identify which filter functions to display.
  List<bool> SelectedList;


  /// The default range value for the Property Value of the listing
  static RangeValues _PVCurrentRangeValues = const RangeValues (200000,1000000);
  /// The default range value for the Floor Area of the listing
  static RangeValues _FlAreaCurrentRangeValues = const RangeValues (31,249);
  /// The default range value for the Remaining Lease (in Years) of the listing
  static  RangeValues _RemainLeaseCurrentRangeValues = const RangeValues (1,100);
  /// The default value for the Flat Type of the listing.
  static int _FlatTypeValue = 0;
  /// The default value for the Location of the listing.
  static int _LocationValue = 0;

  var pulledList;


  var myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var BookmarkController = bookmarkcontroller.BookMarkController();
    var user = BookmarkController.user;
    return Column(
      children: <Widget>[
        SizedBox(height:15),
        if (SelectedList[0] == true)
          Container(
            decoration: BoxDecoration(border: Border.all()),
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Flat Type", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                Container(
                  padding: EdgeInsets.all(15),
                  child: DropdownButton(
                    /// This dropdownbutton is used for _value1, the flat type of the listing, where value:1 = "1 Room", etc.
                      value: _FlatTypeValue,
                      items: [
                        DropdownMenuItem(
                          child: Text("ALL"),
                          value: 0,
                        ),
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
              ],
            ),
          ), //Flat Type Filtering
        if (SelectedList[1] == true)
          Container(
            decoration: BoxDecoration(border: Border.all()),
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Location" ,style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                Container(
                  padding: EdgeInsets.all(15),
                  child: DropdownButton(
                    /// This dropdownbutton is used for _value2, the location type of the listing, where value:1 = "Ang Mo Kio", etc.
                      value: _LocationValue,
                      items: [
                        DropdownMenuItem(
                          child: Text("ALL"),
                          value: 0,
                        ),
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
              ],

            ),
          ), //Location Filtering
        if (SelectedList[2] == true)
          Container(
            decoration: BoxDecoration(border: Border.all()),
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Property Value " + "(\$)",  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                RangeSlider(
                  values: _PVCurrentRangeValues,
                  min: 200000,
                  max: 1000000,
                  divisions: 1000,
                  labels:  RangeLabels(_PVCurrentRangeValues.start.round().toString(), _PVCurrentRangeValues.end.round().toString()),
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                  onChanged:(RangeValues values){
                    setState((){
                      _PVCurrentRangeValues = values;
                    });
                  },
                ),
              ],
            ),
          ), //PV Filtering
        if (SelectedList[3] == true)
          Container(
            decoration: BoxDecoration(border: Border.all()),
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Floor Area (sqm)",  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                RangeSlider(
                  values: _FlAreaCurrentRangeValues,
                  min: 31,
                  max: 249,
                  divisions: 218,
                  labels:  RangeLabels(_FlAreaCurrentRangeValues.start.round().toString(), _FlAreaCurrentRangeValues.end.round().toString()),
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                  onChanged:(RangeValues values){
                    setState((){
                      _FlAreaCurrentRangeValues = values;
                    });
                  },
                ),
              ],
            ),
          ), //Floor Area Filtering
        if (SelectedList[4] == true)
          Container(
            decoration: BoxDecoration(border: Border.all()),
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Remaining Lease (Years)",  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                RangeSlider(
                  values: _RemainLeaseCurrentRangeValues,
                  min: 1,
                  max: 100,
                  divisions: 100,
                  labels:  RangeLabels(_RemainLeaseCurrentRangeValues.start.round().toString(), _RemainLeaseCurrentRangeValues.end.round().toString()),
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                  onChanged:(RangeValues newvalues){
                    setState((){
                      _RemainLeaseCurrentRangeValues = newvalues;
                    });
                  },
                ),
              ],
            ),
          ), //Remain Lease Filtering

        SizedBox(height: 15),
        if (SelectedList.contains(true))
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
                            _PVCurrentRangeValues = RangeValues(200000,1000000);
                            _FlAreaCurrentRangeValues = RangeValues(31,249);
                            _RemainLeaseCurrentRangeValues = RangeValues(1,100);
                            _FlatTypeValue = 1;
                            _LocationValue = 1;
                        myController.clear();
                      },
                    );
                  }), //Reset Button
              ElevatedButton(
                /// This is the button used to confirm and pass the variables that will be used to filter the listings, into the next class ListViewPage.
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(), primary: Colors.green),
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
                    MyApp.setCount(0);
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => filtercontroller.FilterController(ViewAllListings: MyApp.getCount(),SelectedList: SelectedList,)
                        )
                    );
                  }), //To Next Page Button (Filter the listings)
            ])
        else
            Column(
              children: <Widget>[
                SizedBox(height: 200),
                Text('  Please select at least' + '\n' +
                  'one Filtering Conditions', style: TextStyle(fontSize: 20)),
                ]
            )
      ],
    );
  }


  /// Function to obtain Flat Type Value
   int getFlatTypeValue(){
    return _FlatTypeValue;
  }
  /// Function to obtain Location Value
   int getLocationValue(){
    return _LocationValue;
  }

  /// Function to obtain Range of PV Value
  RangeValues getPVRangeValues(){
    return _PVCurrentRangeValues;
  }

  /// Function to obtain Range of Floor Area
  RangeValues getFlAreaRangeValues(){
    return _FlAreaCurrentRangeValues;
  }

  /// Function to obtain Range of Remain Lease (in Years)
  RangeValues getRemainLeaseRangeValues(){
    return _RemainLeaseCurrentRangeValues;
  }


}