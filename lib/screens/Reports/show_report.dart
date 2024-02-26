import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../models/report_model.dart';
import 'get_data.dart';

class ShowReport extends StatefulWidget {
  const ShowReport(
      {super.key, required this.selectedOption, required this.selectedRiver});

  final String selectedOption;
  final String selectedRiver;
  @override
  State<ShowReport> createState() => _ShowReportState();
}

class _ShowReportState extends State<ShowReport> {
  final _formKey = GlobalKey<FormState>();
  List<Report> data = [];
  String? selectedLocation;
  String? selectedGhat;
  List<String> locations = [
    'Location1',
    'Location2',
    'Location3',
    'Location4',
    'Location5',
    'Location6',
    'Location7',
    'Location8',
    'Location9',
    'Location10',
    'Location11',
  ];
  List<String> ghats = [
    'Ghat1',
    'Ghat2',
  ];
  _getDataFromFirebase() async {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    data = await fetchDummyData(
        selectedLocation!, selectedGhat!, widget.selectedRiver);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.selectedOption} Analysis'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // DropdownButtonFormField<String>(
                    //   value: selectedLocation,
                    //   items: MapRepo().mapList.map<DropdownMenuItem<String>>(
                    //         (Map value) {
                    //       return DropdownMenuItem<String>(
                    //         value: value.locationName,
                    //         child: Text(value.locationName),
                    //       );
                    //     },
                    //   ).toList(),
                    //   onChanged: (String? newValue) {
                    //     setState(() {
                    //       selectedLocation = newValue;
                    //     });
                    //   },
                    //   decoration: const InputDecoration(
                    //     labelText: 'Select Location',
                    //   ),
                    // ),
                    DropdownButtonFormField<String>(
                      value: selectedLocation,
                      items: locations.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: Theme.of(context).textTheme.bodyMedium),
                          );
                        },
                      ).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedLocation = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a location';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Select Location',
                      ),
                    ),

                    // DropdownButtonFormField<String>(
                    //   value: selectedGhat,
                    //   items: MapRepo().mapList.map<DropdownMenuItem<String>>(
                    //         (Map value) {
                    //       return DropdownMenuItem<String>(
                    //         value: value.ghatName,
                    //         child: Text(value.ghatName),
                    //       );
                    //     },
                    //   ).toList(),
                    //   onChanged: (String? newValue) {
                    //     setState(() {
                    //       selectedGhat = newValue;
                    //     });
                    //   },
                    //   decoration: const InputDecoration(
                    //     labelText: 'Select Location',
                    //   ),
                    // ),
                    DropdownButtonFormField<String>(
                      value: selectedGhat,
                      items: ghats.map<DropdownMenuItem<String>>(
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
                      onChanged: (String? newValue) {
                        setState(
                          () {
                            selectedGhat = newValue;
                          },
                        );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a location';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Select Location',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              ElevatedButton(
                onPressed: _getDataFromFirebase,
                child: const Text("Generate "),
              ),
              if (data.isNotEmpty)
                AspectRatio(
                  aspectRatio: 1,
                  child: LineChart(
                    LineChartData(
                      lineTouchData: const LineTouchData(
                        enabled: true,
                      ),
                      gridData: const FlGridData(
                        show: true,
                      ),
                      minY: 0,
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withOpacity(0.8),
                          ),
                          dotData: const FlDotData(show: false),
                          spots: [
                            for (Report report in data)
                              FlSpot(
                                report.date.toDate().day.toDouble(),
                                double.parse(report.getProp(widget.selectedOption)),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
