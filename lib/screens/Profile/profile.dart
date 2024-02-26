import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jaldindi/Auth/auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jaldindi/screens/Profile/send_suggestion.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Admin/admin.dart';
import '../Admin/show_suggestions.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final currentUser = FirebaseAuth.instance.currentUser;
  final url = Uri.parse('https://www.facebook.com/groups/jaldindi/');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () {
              AuthService().signOut(context);
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.logout,size: 35),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (currentUser != null &&
                    currentUser!.photoURL != null &&
                    currentUser!.photoURL != "")
                  CircleAvatar(
                    backgroundImage: NetworkImage(currentUser!.photoURL!),
                    radius: MediaQuery.of(context).size.width * 0.1,
                  )
                else
                  const Icon(Icons.person),
              ],
            ),
            headingShow("Name-"),
            textFieldShow(currentUser!.displayName.toString(),context),
            headingShow("Email-"),
            textFieldShow(currentUser!.email.toString(),context),
            headingShow("POC-"),
            textFieldShow("Not Assigned yet",context),
            headingShow("Team Number-"),
            textFieldShow("Not Assigned yet",context),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Connect With Us-",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconShow(url, FontAwesomeIcons.facebook, Colors.blue,context),
                          iconShow(Uri.parse("https://instagram.com"),
                              FontAwesomeIcons.instagram, Colors.red,context),
                          iconShow(Uri.parse("https://twitter.com"),
                              FontAwesomeIcons.twitter, Colors.blue,context),
                          iconShow(Uri.parse("https://linkedin.com"),
                              FontAwesomeIcons.linkedin, Colors.blue,context),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SendSuggestion(),
                                ),
                              );
                            },
                            child:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.phone,
                               size: MediaQuery.of(context).size.width * 0.12,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: isAdmin,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Admin",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ShowSuggestions()));
                          },
                        child:Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Suggestions",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget iconShow(Uri data, IconData? icon, Color color,BuildContext context) {
    return GestureDetector(
      onTap: () => launchUrl(
        data,
        mode: LaunchMode.externalApplication,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          size: MediaQuery.of(context).size.width * 0.12,
          color: color,
        ),
      ),
    );
  }

  Widget textFieldShow(String data,BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget headingShow(String data) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12),
          child: Row(
            children: [
              Text(
                data,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
