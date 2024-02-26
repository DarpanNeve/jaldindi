import 'package:flutter/material.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("COMING SOON...",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
              ])
        ],
      ),

    );
  }
}
