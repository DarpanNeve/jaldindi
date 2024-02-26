import 'package:flutter/material.dart';
import '../../Widgets/button.dart';

class PawanaReportAnalysis extends StatefulWidget {
  const PawanaReportAnalysis({super.key, required this.selectedRiver});
  final String selectedRiver;
  @override
  State<PawanaReportAnalysis> createState() => _PawanaReportAnalysisState();
}

class _PawanaReportAnalysisState extends State<PawanaReportAnalysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pawana Report Analysis'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            button("All", "All",context,widget.selectedRiver),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            button("Temperature", "Temperature",context, widget.selectedRiver),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            button("pH", "pH",context, widget.selectedRiver),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            button("Dissolved Solids", "DissolvedSolids",context, widget.selectedRiver),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            button("Hardness", "Hardness",context, widget.selectedRiver),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            button("Alkalinity", "Alkalinity",context, widget.selectedRiver),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            button("Chloride", "Chloride",context, widget.selectedRiver),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            button("Dissolved Oxygen", "DissolvedOxygen",context, widget.selectedRiver),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            button("BOD", "BOD",context, widget.selectedRiver),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            button("COD", "COD",context, widget.selectedRiver),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            button("MPN", "MPN",context, widget.selectedRiver),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
          ],
        ),
      ),
    );
  }
}
