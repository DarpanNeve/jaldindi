import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jaldindi/Widgets/loading.dart';
import 'package:jaldindi/Widgets/widget.dart';
import 'package:jaldindi/screens/Analysis/river_analysis.dart';
import 'package:jaldindi/screens/RiverPolice/river_map.dart';
import 'package:jaldindi/screens/RiverPolice/river_police_registrations.dart';
import 'package:jaldindi/screens/coming_soon.dart';

import '../Admin/admin.dart';
import '../Reports/report_upload.dart';
String? selectedValue;
String? whatIsRiverPolice;

class RiverPolice extends StatefulWidget{
  const RiverPolice({super.key});
  @override
  State<RiverPolice> createState() => _RiverPoliceState();
}

class _RiverPoliceState extends State<RiverPolice> {

  @override
  void initState() {
    super.initState();
    fetchAboutData();
  }
  fetchAboutData() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('What Is River Police').doc('Info').get();
    if (snapshot.exists && mounted) {
      setState(() {
        whatIsRiverPolice= snapshot.get('About');
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isAdmin?FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const ReportUpload()));
          },
        label: const Text("Upload Report"),
        icon: const Icon(Icons.add),
      ):null,
      body:
      whatIsRiverPolice != null?
       SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0,bottom: 8.0,left: 8.0,right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      "What Is River Police?",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 5),
                    child: Text(
                      whatIsRiverPolice!,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  //width: MediaQuery.of(context).size.width * 0.9,
                  //height: MediaQuery.of(context).size.height * 0.4,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:MediaQuery.of(context).size.width*0.7,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  hint: const Text("Select River"),
                                  value: selectedValue,
                                  dropdownColor: Theme.of(context).colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(8),
                                  onChanged: (newValue) {
                                    setState(() {
                                      if (newValue == 'Select River') {
                                        selectedValue = null;
                                      } else {
                                        selectedValue = newValue;
                                      }
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      value: 'Pawana',
                                      child: Text('Pawana',style: Theme.of(context).textTheme.bodyMedium,),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Indrayani',
                                      child: Text('Indrayani',style: Theme.of(context).textTheme.bodyMedium),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width:10),
                               IconButton(icon:const Icon(FontAwesomeIcons.locationDot),onPressed: (){
                                 if (selectedValue != null &&
                                            selectedValue == 'Pawana') {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const RiverMap()));
                                        } else if (selectedValue ==
                                            'Indrayani') {
                                          showSnackBar("Map not Available",
                                              context, Icons.error, Colors.red);
                                        } else {
                                          showSnackBar(
                                              "Please select the river",
                                              context,
                                              Icons.error,
                                              Colors.red);
                                        }
                                      },),
                            ],
                          ),
                          Row(
                              children: [
                                buttonShow("Analysis", context, "Analysis",selectedValue),
                                SizedBox(width:MediaQuery.of(context).size.width*0.05),
                                buttonShow("Report", context, "Report",selectedValue),
                              ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            buttonShow("Register For River Police", context, "River Police Registration",selectedValue),
          ],
        ),
      ): const Loading(),
    );
  }
}
Widget buttonShow(String data,BuildContext context,String action,String? selectedRiver){
  return ElevatedButton(
    onPressed: () {
      if(selectedValue!=null&&action=="Analysis"){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>RiverAnalysis(selectedRiver: selectedRiver!)));
      }
      else if(selectedValue!=null&&action=="Report"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            const ComingSoon(),
        ));
      }
      else if(action=="River Police Registration"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const RiverPoliceRegistration()));
      }
      else{
        showSnackBar("Please select the river", context,Icons.error, Colors.red);
      }
    },
    child:Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          data,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    ),
  );
}
