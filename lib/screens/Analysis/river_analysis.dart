import 'package:flutter/material.dart';
import 'package:jaldindi/screens/Analysis/pawana_analysis.dart';
import 'package:percent_indicator/percent_indicator.dart';

class RiverAnalysis extends StatefulWidget {
  const RiverAnalysis({super.key , required this.selectedRiver});
  final String selectedRiver;
  @override
  State<RiverAnalysis> createState() => _RiverAnalysisState();
}

class _RiverAnalysisState extends State<RiverAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Pawana River Analysis'),
      ),
      body: Column(
             children: [
               SizedBox(
                 height: MediaQuery.of(context).size.height*0.04,
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   CircularPercentIndicator(
                     radius: MediaQuery.of(context).size.width*0.23,
                     lineWidth: 14.0,
                     animation: true,
                     animationDuration: 1200,
                     percent: 0.75,
                     circularStrokeCap: CircularStrokeCap.round,
                     progressColor: Colors.deepPurple,
                     //header: Text("Colleges Participated"),
                     center:const Text("Colleges \n Participated- 3",style: TextStyle(fontWeight: FontWeight.bold),
                       softWrap: true,
                       textAlign: TextAlign.center,
                     )
                   ),
                   CircularPercentIndicator(
                       radius: MediaQuery.of(context).size.width*0.23,
                       lineWidth: 14.0,
                       animation: true,
                       animationDuration: 1200,
                       percent: 0.62,
                       circularStrokeCap: CircularStrokeCap.round,
                       progressColor: Colors.purple,
                       //header: Text("Colleges Participated"),
                       center:const Text("Volunteers \n Participated- 62",style: TextStyle(fontWeight: FontWeight.bold),
                         softWrap: true,
                         textAlign: TextAlign.center,
                       )
                   ),
                 ],
               ),
               SizedBox(
                 height: MediaQuery.of(context).size.height*0.08,
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         LinearPercentIndicator(
                           width: MediaQuery.of(context).size.width - 50,
                           animation: true,
                           lineHeight: 40.0,
                           animationDuration: 2500,
                           percent: 0.8,
                           center: const Text("Distance Covered- 25.5 KM",style: TextStyle(fontWeight: FontWeight.bold),
                             ),
                           progressColor: Colors.green,
                         ),
                        ],
               ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.08,
                ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=>PawanaReportAnalysis(selectedRiver: widget.selectedRiver,))
                          );
                        },
                        child:
                        const Text('View Detailed Report',),
                    )
                  ],
               )

             ],
    ),
      );

  }
}
