import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'About/about.dart';
import 'Donation/donation.dart';
import 'Event/events.dart';
import 'Gallery/gallery.dart';
import 'Profile/profile.dart';
import 'RiverPolice/river_police.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final currentUser = FirebaseAuth.instance.currentUser;
  final List<Widget> _screens = [
    const About(),
    const RiverPolice(),
    const Gallery(),
    const Events(),
    const Donation(),
  ];
  final List<String> names = [
    "About Us",
    "River Police",
    "Gallery",
    "Events",
    "Support Us"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          names[_currentIndex],
        ),
        actions: [
          if (currentUser != null && currentUser!.photoURL != null)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    currentUser!.photoURL!,
                  ),
                ),
              ),
            )
          else
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
            ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedIndex: _currentIndex,
          destinations: <Widget>[
            const NavigationDestination(
              icon: Icon(Icons.info),
              selectedIcon: Icon(Icons.info),
              label: 'About Us',
            ),
            NavigationDestination(
              icon: SvgPicture.asset("assets/Images/officer.svg",
                  height: MediaQuery.of(context).size.height * 0.03,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.secondary,
                      BlendMode.srcATop)),
              label: 'River Police',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                  "assets/Images/gallery.svg",
                  height: MediaQuery.of(context).size.height * 0.03,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.secondary,
                      BlendMode.srcATop)),
              label: 'Gallery',
            ),
            const NavigationDestination(
              icon: Icon(Icons.event),
              label: 'Events',
            ),
            const NavigationDestination(
              icon: Icon(FontAwesomeIcons.circleDollarToSlot),
              label: 'Support Us',
            ),
          ]),
    );
  }
}
