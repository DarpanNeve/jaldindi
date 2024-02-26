import 'package:flutter/material.dart';

import '../models/report_model.dart';

Widget inputShow(String labelText,Report report,String type){
  return TextFormField(
    keyboardType: TextInputType.number,
    decoration:InputDecoration(labelText: labelText),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $type';
      }
      return null;
    },
    onSaved: (value) {
      if(type=="temperature"){
        report.temperature = double.parse(value!);
      }
      else if(type=="pH"){
        report.pH = double.parse(value!);
      }
      else if(type=="dissolvedSolids"){
        report.dissolvedSolids = double.parse(value!);
      }
      else if(type=="hardness"){
        report.hardness = double.parse(value!);
      }
      else if(type=="alkalinity"){
        report.alkalinity = double.parse(value!);
      }
      else if(type=="chloride"){
        report.chloride = double.parse(value!);
      }
      else if(type=="dissolvedOxygen"){
        report.dissolvedOxygen = double.parse(value!);
      }
      else if(type=="bod"){
        report.bod = double.parse(value!);
      }
      else if(type=="cod"){
        report.cod = double.parse(value!);
      }
      else if(type=="mpn"){
        report.mpn = double.parse(value!);
      }
    },
  );
}