import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/report_model.dart';

Future<List<Report>> fetchDummyData(
    String selectedLocation, String selectedGhat ,String selectedRiver) async {
  // print(selectedRiver);
  List<Report> reports =
      await fetchDataFromFirebase(selectedLocation, selectedGhat,selectedRiver);

  if (reports.isEmpty) {
    // print('No data found for the specified location and ghat.');
    return reports;
  }

  // print('Fetched ${reports.length} report(s) from Firebase:');
  // for (Report report in reports) {
    // print('-----------------------------------------');
    // print('Location: ${report.locationName}');
    // print('Ghat: ${report.ghatName}');
    // print('Temperature: ${report.temperature}');
    // print('Date: ${report.date.toDate()}');
  // }
  // print('-----------------------------------------');

  return reports;
}

Future<List<Report>> fetchDataFromFirebase(String? selectedLocation, String? selectedGhat, String? selectedRiver) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    QuerySnapshot querySnapshot = await firestore
        .collection('dummyData1')
        .where("riverName", isEqualTo:selectedRiver)
        .where('locationName', isEqualTo:selectedLocation)
        .where('ghatName', isEqualTo: selectedGhat)
        .orderBy('date')
        .get();
    List<Report> reports = querySnapshot.docs.map((DocumentSnapshot document) {
      return Report.fromJson(document.data() as Map<String, dynamic>);
    }).toList();
    return reports;
  } catch (e) {
    // print('Error fetching data: $e');
    return [];
  }
}
