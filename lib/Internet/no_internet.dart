import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height:MediaQuery.of(context).size.height*0.3,
                    width: MediaQuery.of(context).size.width*0.5,
                    child: const Image(
                      image: AssetImage("assets/Images/noInternet.png"),
                    ),
                  ),
                  const Text(
                    "Whoops!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const Text(
                    "No Internet Connection Found.",
                  ),
                  const Text(
                    "Check Your Internet Connection or Try Again.",
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
