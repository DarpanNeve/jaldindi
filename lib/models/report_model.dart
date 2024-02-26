import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String riverName;
  String locationName;
  String ghatName;
  double temperature;
  double pH;
  double dissolvedSolids;
  double hardness;
  double alkalinity;
  double chloride;
  double dissolvedOxygen;
  double bod;
  double cod;
  double mpn;
  Timestamp date;

  Report(
      {required this.riverName,
      required this.locationName,
      required this.ghatName,
      required this.temperature,
      required this.pH,
      required this.dissolvedSolids,
      required this.hardness,
      required this.alkalinity,
      required this.chloride,
      required this.dissolvedOxygen,
      required this.bod,
      required this.cod,
      required this.mpn,
      required this.date});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      riverName: json['riverName'],
      locationName: json['locationName'],
      ghatName: json['ghatName'],
      temperature: double.parse(json['temperature'].toStringAsFixed(2)),
      pH: double.parse(json['pH'].toStringAsFixed(2)),
      dissolvedSolids: double.parse(json['dissolvedSolids'].toStringAsFixed(2)),
      hardness: double.parse(json['hardness'].toStringAsFixed(2)),
      alkalinity: double.parse(json['alkalinity'].toStringAsFixed(2)),
      chloride: double.parse(json['chloride'].toStringAsFixed(2)),
      dissolvedOxygen: double.parse(json['dissolvedOxygen'].toStringAsFixed(2)),
      bod: double.parse(json['bod'].toStringAsFixed(2)),
      cod: double.parse(json['cod'].toStringAsFixed(2)),
      mpn: double.parse(json['mpn'].toStringAsFixed(2)),
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "riverName": riverName,
      "locationName": locationName,
      "ghatName": ghatName,
      "temperature": double.parse(temperature.toStringAsFixed(2)),
      "pH": double.parse(pH.toStringAsFixed(2)),
      "dissolvedSolids": double.parse(dissolvedSolids.toStringAsFixed(2)),
      "hardness": double.parse(hardness.toStringAsFixed(2)),
      "alkalinity": double.parse(alkalinity.toStringAsFixed(2)),
      "chloride": double.parse(chloride.toStringAsFixed(2)),
      "dissolvedOxygen": double.parse(dissolvedOxygen.toStringAsFixed(2)),
      "bod": double.parse(bod.toStringAsFixed(2)),
      "cod": double.parse(cod.toStringAsFixed(2)),
      "mpn": double.parse(mpn.toStringAsFixed(2)),
      "date": date,
    };
  }
  dynamic getProp(String key) => <String, dynamic>{
    'riverName': riverName,
    'locationName': locationName,
    'ghatName': ghatName,
    'Temperature': temperature,
    'pH': pH,
    'DissolvedSolids': dissolvedSolids,
    'Hardness': hardness,
    'Alkalinity': alkalinity,
    'Chloride': chloride,
    'DissolvedOxygen': dissolvedOxygen,
    'BOD': bod,
    'COD': cod,
    'MPN': mpn,
    'date': date,
  }[key].toString();

}
