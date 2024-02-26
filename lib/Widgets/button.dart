import 'package:flutter/material.dart';

import '../screens/Reports/show_report.dart';

Widget button(String message,String action,BuildContext context,String selectedRiver){
  return ElevatedButton(
      onPressed: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>ShowReport(selectedOption: action,selectedRiver: selectedRiver,)));
      },
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(message),
          const Icon(Icons.arrow_forward_ios_sharp)
        ],
      )
  );
}