import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jaldindi/models/map_model.dart';
import 'package:jaldindi/models/report_model.dart';
import '../../Widgets/report_input_field.dart';

class ReportUpload extends StatefulWidget {
  const ReportUpload({super.key});

  @override
  State<ReportUpload> createState() => _ReportUploadState();
}

class _ReportUploadState extends State<ReportUpload> {
  String? selectedLocation;
  String? selectedGhat;
  String? selectedRiver;
  DateTime selectedDate = DateTime.now();
  Report report=Report(
    riverName: "",
    locationName: "",
    ghatName: "",
    temperature: 0,
    pH: 0,
    dissolvedSolids: 0,
    hardness: 0,
    alkalinity: 0,
    chloride: 0,
    dissolvedOxygen: 0,
    bod: 0,
    cod: 0,
    mpn: 0,
    date: Timestamp.fromDate(DateTime.now()),
  );
  List<String>rivers=["Pawana","Indrayani"];
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      //DateTime selectedDateWithoutTime = DateTime(picked.year, picked.month, picked.day);
      setState(() {
        selectedDate = picked;
        report.date = Timestamp.fromDate(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Upload'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField(
                    items: rivers.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: Theme.of(context).textTheme.bodyMedium),
                        );
                      },
                    ).toList(),
                      onChanged:(String ? newValue) {
                        setState(() {
                          selectedRiver = newValue;
                        });
                      },
                  decoration: const InputDecoration(
                    labelText: "Select River"
                  ),
                    ),
                DropdownButtonFormField<String>(
                  value: selectedLocation,
                  items: MapRepo().mapList.map<DropdownMenuItem<String>>(
                    (Map value) {
                      return DropdownMenuItem<String>(
                        value: value.locationName,
                        child: Text(value.locationName,
                            style: Theme.of(context).textTheme.bodyMedium),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLocation = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Location',
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: selectedGhat,
                  items: MapRepo().mapList.map<DropdownMenuItem<String>>(
                    (Map value) {
                      return DropdownMenuItem<String>(
                        value: value.ghatName,
                        child: Text(
                          value.ghatName,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGhat = newValue;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Location',
                  ),
                ),
                inputShow("Temperature", report, "temperature"),
                inputShow("pH", report, "pH"),
                inputShow("Dissolved Solids", report, "dissolvedSolids"),
                inputShow("Hardness", report, "hardness"),
                inputShow("Alkalinity", report, "alkalinity"),
                inputShow("Chloride", report, "chloride"),
                inputShow("Dissolved Oxygen", report, "dissolvedOxygen"),
                inputShow("BOD", report, "bod"),
                inputShow("COD", report, "cod"),
                inputShow("MPN", report, "mpn"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: const Icon(FontAwesomeIcons.calendar)),
                    Text(selectedDate.toString().substring(0, 10)),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    report.locationName = selectedLocation!;
                    report.ghatName = selectedGhat!;
                    _formKey.currentState!.validate();
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    report = Report(
                        riverName: 'Pawana',
                        locationName: selectedLocation!,
                        ghatName: selectedGhat!,
                        temperature: report.temperature,
                        pH: report.pH,
                        dissolvedSolids: report.dissolvedSolids,
                        hardness: report.hardness,
                        alkalinity: report.alkalinity,
                        chloride: report.chloride,
                        dissolvedOxygen: report.dissolvedOxygen,
                        bod: report.bod,
                        cod: report.cod,
                        mpn: report.mpn,
                        date: Timestamp.fromDate(selectedDate));
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
