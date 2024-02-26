import 'package:flutter/material.dart';
import 'package:jaldindi/screens/Donation/support.dart';

class Donation extends StatelessWidget {
  const Donation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(left: 12.0, bottom: 8),
                child: Text(
                  "Clean Rivers, Happy Planet",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
              )
            ]),
            const SizedBox(
              height: 5,
            ),
            const Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                    "Dirty rivers contribute to water pollution, "
                    "harming aquatic life, and impacting the people who depend on them. "
                    "We've taken up the challenge to restore our rivers’ health.",
                    textAlign: TextAlign.justify),
              )
            ]),
            const Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                    "Join us in our quest for clean rivers! Your donation will support the critical "
                    "work of our NGO in restoring and maintaining the cleanliness and ecological balance of rivers.",
                    textAlign: TextAlign.justify),
              )
            ]),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.change_circle,
                          //  color: Colors.blue,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Impact",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.track_changes,
                    //        color: Colors.blue,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Transparency",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.ac_unit_outlined,
                    //        color: Colors.blue,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Unity",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Donate Now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "You can be the change! Empower our mission by donating."
                    "Every rupee counts towards a cleaner future for our rivers and planet.",
                    style: TextStyle(),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Support()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 6,
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Support Us",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
