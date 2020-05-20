import 'package:carousel_slider/carousel_slider.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_state/common.dart';
import 'package:url_launcher/url_launcher.dart';

import 'hex_color.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  ValueChanged _onChanged = (val) => print(val);
  var genderOptions = ['Riyadh', 'Jeddah', 'Damma', 'madina', 'makka',];



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          //     title: SvgPicture.asset(
          //   "assets/images/teras-logo.svg",
          //   fit: BoxFit.contain,
          // )
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SvgPicture.asset(
                "assets/images/teras-logo.svg",
                fit: BoxFit.cover,
                height: 35.0,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(30),
          
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                 FormBuilder(
                // context,
                key: _fbKey,
                readOnly: false,
                  child: Column(
                    children: <Widget>[
                      FormBuilderDropdown(
                        onChanged: (value) {
                          print(value);
                        },
                        attribute: "City",
                        decoration: InputDecoration(
                          labelText: "City",
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 20,
                            ),
                          ),
                        ),
                        // initialValue: 'Male',
                        hint: Text('Select City'),
                        //validators: [FormBuilderValidators.required()],
                        items: genderOptions
                            .map((gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text('$gender'),
                                ))
                            .toList(),
                      ),
                      
                      FormBuilderChoiceChip(
                        attribute: 'Unit_Type',
                        decoration: InputDecoration(
                          labelText: 'Select Unit Type',
                        ),
                        options: [
                          FormBuilderFieldOption(
                              value: 'flat', child: Text('Flat')),
                          FormBuilderFieldOption(
                              value: 'villa', child: Text('Villa')),
                          FormBuilderFieldOption(
                              value: 'Buldinng', child: Text('Buldinng')),
                        ],
                      ),

                      FormBuilderTouchSpin(
                        decoration: InputDecoration(labelText: "Flat",border: InputBorder.none),
                        attribute: "Flat",
                        initialValue: 0,
                        step: 1,
                        iconSize: 22.0,
                        addIcon: Icon(Icons.arrow_right),
                        subtractIcon: Icon(Icons.arrow_left),

                      ),
                        
                      FormBuilderTouchSpin(
                        decoration: InputDecoration(labelText: "Halls",border: InputBorder.none),
                        attribute: "Halls",
                        initialValue: 0,
                        step: 1,
                        iconSize: 22.0,
                        addIcon: Icon(Icons.arrow_right),
                        subtractIcon: Icon(Icons.arrow_left),
                        
                      ),




                      FormBuilderTouchSpin(
                        decoration: InputDecoration(labelText: "Bathroom"),
                        attribute: "Bathroom",
                        initialValue: 0,
                        step: 1,
                        iconSize: 22.0,
                        addIcon: Icon(Icons.arrow_right),
                        subtractIcon: Icon(Icons.arrow_left),
                        
                      ),
                      
                    FormBuilderFilterChip(
                        onChanged: (value) {
                          print(value);
                        },
                        attribute: 'extra_criteria',
                        decoration: InputDecoration(
                          labelText: 'Extra criteria',
                        ),
                        options: [
                          FormBuilderFieldOption(
                              value: 'elevator', child: Text('elevator')),
                          FormBuilderFieldOption(
                              value: 'Park', child: Text('Park')),
                          FormBuilderFieldOption(
                              value: 'furnished', child: Text('furnished')),
                          FormBuilderFieldOption(
                              value: 'Driver Room', child: Text('Driver room')),
                          FormBuilderFieldOption(
                              value: 'housemaid room', child: Text('housemaid room')),
                        ],
                      ),

                      FormBuilderFilterChip(
                        onChanged: (value) {
                          print(value);
                        },
                        attribute: 'Interface',
                        decoration: InputDecoration(
                          labelText: 'Interface',
                        ),
                        options: [
                          FormBuilderFieldOption(
                              value: 'North', child: Text('North')),
                          FormBuilderFieldOption(
                              value: 'South', child: Text('South')),
                          FormBuilderFieldOption(
                              value: 'Width', child: Text('Width')),
                          FormBuilderFieldOption(
                              value: 'East', child: Text('East')),
                       
                        ],
                      ),

                      
                      FormBuilderRangeSlider(
                        attribute: "Price",
                        validators: [FormBuilderValidators.min(6)],
                        
                        onChanged: _onChanged,
                        min: 0.0,
                        max: 50000000.0,
                        initialValue: RangeValues(0, 50000000),
                        divisions: 20,
                        activeColor: Colors.red,
                        inactiveColor: Colors.pink[100],
                        decoration: InputDecoration(
                          labelText: "Price",
                          
                        ),
                      ),
                     
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        color: Colors.black,
                        child: Text(
                          "Search",
                          style: TextStyle(color: Colors.white),
                        ),
                       onPressed: () {
                        _fbKey.currentState.save();
                          print(_fbKey.currentState.value);
                        
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: MaterialButton(
                        color: Colors.red,
                        child: Text(
                          "Reset",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
