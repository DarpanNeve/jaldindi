import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Widgets/widget.dart';

class SendSuggestion extends StatefulWidget {
  const SendSuggestion({super.key});
  @override
  State<SendSuggestion> createState() => _SendSuggestionState();
}

class _SendSuggestionState extends State<SendSuggestion> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? mobile;
  String? email;
  String? suggestion;
  void sendSuggestion() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final db = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;

      db.collection("Suggestion").doc(DateTime.timestamp().toString()).set(
        {
          "Uid":auth.currentUser!.uid,
          "email": email,
          "name": name,
          "Mobile": mobile,
          "Suggestion": suggestion,
          "Date And Time":DateTime.timestamp().toString(),

        },
      );
      showSnackBar("Sent", context, Icons.done, Colors.green);
      Navigator.pop(context);
    }
    else {
      showSnackBar("Please Fill All The Details Correctly", context,
          Icons.error, Colors.red);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Us',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Enter Your Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              name = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Enter Your Email',
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty||!RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$').hasMatch(value)) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              email = value!;
                            },
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Your Mobile Number',
                        prefixIcon: Icon(Icons.call),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty||!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Please enter your mobile number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        mobile = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Your Suggestion',
                        prefixIcon: Icon(Icons.message),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Suggestion';
                        }
                        return null;
                      },
                      onSaved: (value) {
                       suggestion = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        sendSuggestion();
                      },
                      child: const Text('Send'),
                    ),
                  ),
                  ]
            ),
          ),
          ),
        ),
      )
    );
  }
}
