import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swe_loan_calculator/controller/FilterPageController.dart' as filtercontroller;
import 'package:swe_loan_calculator/controller/FilterSliderController.dart' as filterslidercontroller;

///Boundary class that contains the structure of the Filter page
class FilterView extends State<filtercontroller.FIlterPageController> {
  var pulledList;
  List<bool> _isSelected = [false,false,false,false,false];


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
            body: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  height: 80,
                  child:ToggleButtons(
                    children: <Widget>[
                      Text(' Flat' '\n' 'Type', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900 )),
                      Text(' Location ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                      Text(' Property ' '\n' '   Value', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                      Text('Floor' '\n' 'Area', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                      Text('Remaining' '\n' '   Lease', style: TextStyle(fontSize:20, fontWeight: FontWeight.w900)),
                    ],
                    isSelected: _isSelected,
                    borderColor: Colors.black,
                    selectedBorderColor: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderWidth: 1.0,

                    onPressed: (int index){
                      setState((){
                        _isSelected[index] = !_isSelected[index];
                      });
                      if (_isSelected[index] == true) {
                        // ignore: curly_braces_in_flow_control_structures
                        if (index == 0) {
                          print('Flat Type is clicked');
                        }
                        if (index == 1) {
                          print('Location is clicked');
                        }
                        if (index == 2) {
                          print('Property Value is clicked');
                        }
                        if (index == 3) {
                          print('Floor Area is clicked');
                        }
                        if (index == 4) {
                          print('Remaining Lease is clicked');
                        }
                      };
                    },
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        filterslidercontroller.FilterSliderController(),
                      ],
                    )
                )
              ],
            )
        )
    );
  }
}