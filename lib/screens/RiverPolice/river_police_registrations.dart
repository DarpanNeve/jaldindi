import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Widgets/widget.dart';

class RiverPoliceRegistration extends StatefulWidget {
  const RiverPoliceRegistration({super.key});

  @override
  State<RiverPoliceRegistration> createState() =>
      _RiverPoliceRegistrationState();
}

class _RiverPoliceRegistrationState extends State<RiverPoliceRegistration> {
  final _formKey = GlobalKey<FormState>();
  String? selectedOccupation;
  String? selectedOrg;
  List<String> collegeNames = [];
  List<String> orgNames = [];
  String? name;
  String? mobile;
  String? email;

  @override
  void initState() {
    super.initState();
    fetchCollegeNames();
    fetchOrgNames();
  }

  Future<void> fetchCollegeNames() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("River Police Organization Or College")
        .doc("College")
        .get();
    if (snapshot.exists || mounted) {
      setState(() {
        final collegeData = snapshot.data();
        if (collegeData != null) {
          final collegeValues = collegeData.values.toList();
          collegeNames =
              collegeValues.map((college) => college.toString()).toList();
        }
      });
    }
  }

  Future<void> fetchOrgNames() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("River Police Organization Or College")
        .doc("Organization")
        .get();
    if (snapshot.exists || mounted) {
      setState(() {
        final orgData = snapshot.data();
        if (orgData != null) {
          orgNames = orgData.keys.toList();
          final orgValues = orgData.values.toList();
          orgNames = orgValues.map((college) => college.toString()).toList();
        }
      });
    }
  }

  void upload() async {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('River Police Registration');
    final DocumentReference docRef = collectionRef.doc();
    Map<String, dynamic> data = {
      "Name": name,
      "Mobile Number": mobile,
      "Email": email,
      "Occupation": selectedOccupation,
      "college Or Organization": selectedOrg,
    };
    await docRef.set(data);
    show();
  }

  void show() {
    showSnackBar("Registered Successfully", context, Icons.done, Colors.green);
    Navigator.pop(context);
  }

  void _register() {
    final data=_formKey.currentState!.validate();
    if(!data){
      return;
    }
    _formKey.currentState!.save();
    upload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('River Police Registration'),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
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
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty || !RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      mobile = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty || !RegExp(
                          r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$').hasMatch(value)) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Occupation',
                    ),
                    value: selectedOccupation,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOccupation = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your occupation';
                      }
                      return null;
                    },
                    dropdownColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    items: <String>['Student', 'Employee', 'Self Employed']
                        .map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(height: 16),
                  if (selectedOccupation == 'Employee')
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Organization',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your organization';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        selectedOrg = value!;
                      },
                    ),
                  if (selectedOccupation == 'Student')
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'College',
                      ),
                      value: selectedOrg,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedOrg = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your college';
                        }
                        return null;
                      },
                      items: collegeNames.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, overflow: TextOverflow.ellipsis),
                          );
                        },
                      ).toList(),
                    ),
                  if (selectedOccupation == 'Self Employed')
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Organization',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your organization';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        selectedOrg = value!;
                      },
                    ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _register,
                    child: const Text('Register'),
                  ),
                  const Text(
                      'Note:If your college or organization name is not in the list, kindly contact us.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.justify),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
