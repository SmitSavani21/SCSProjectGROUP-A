// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:health_app/models/visit_module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

import '../consts/titles.dart';

Future<dynamic> addVisitRecord(VisitModel data) async {
  try {
    await FirebaseFirestore.instance
        .collection("VisitRecords")
        .add(data.toJson());
    return true;
  } catch (e) {
    // handleError('');
  }
}

Future<dynamic> getRecordByEmail(String email) async {
  try {
    List<VisitModel> visitList = [];

    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("VisitRecords")
        .where('email', isEqualTo: email.trim())
        .get();

    for (var i in snap.docs) {
      VisitModel visitModel = visitModelFromJson(jsonEncode(i.data()));

      visitList.add(visitModel);
    }

    return visitList;
  } catch (e) {
    // handleError('');
  }
}

Future<dynamic> getLastRecordByEmail(String email) async {
  try {
    VisitModel visitModel = VisitModel(
        email: '',
        weight: '',
        notes: '',
        docs: '',
        isCritical: false,
        problem: '',
        problemType: '',
        pValue: '',
        nextAppointment: '',
        createdAt: '');
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("VisitRecords")
        .where('email', isEqualTo: email.trim())
        // .orderBy("createdAt")
        .orderBy("createdAt", descending: true)
        .limit(1)
        .get();
    if (snap.docs.isNotEmpty) {
      visitModel = visitModelFromJson(jsonEncode(snap.docs.first.data()));
    }

    return visitModel;
  } catch (e) {
    // handleError('');
  }
}

Future<dynamic> getAllRecord() async {
  try {
    List<VisitModel> visitList = [];

    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection("VisitRecords").get();

    for (var i in snap.docs) {
      VisitModel visitModel = visitModelFromJson(jsonEncode(i.data()));

      visitList.add(visitModel);
    }

    return visitList;
  } catch (e) {
    // handleError('');
  }
}

uploadFile(File file) async {
  // Create a reference to the Firebase Storage bucket
  final storageRef = FirebaseStorage.instance.ref();

  final uploadTask = storageRef
      .child('reports')
      .child(DateTime.now().toString())
      .putFile(file);

  dynamic url;
  await uploadTask.whenComplete(
      () async => url = await uploadTask.snapshot.ref.getDownloadURL());

  return url;
}

Future<dynamic> sendReportMail(String email, String msg) async {
  try {
    Map<String, String> headers = Map();
    headers["Authorization"] =
        "Bearer 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";
    headers["Content-Type"] = "application/json";

    String url = "https://api.sendgrid.com/v3/mail/send";

    var response = await http.post(Uri.parse(url),
        headers: headers,
        body:
            "{\n          \"personalizations\": [\n            {\n              \"to\": [\n                {\n                  \"email\": \"$email\"\n                },\n                       ]\n            }\n          ],\n          \"from\": {\n            \"email\": \"contact@patternsign.com\"\n          },\n         \"subject\": \"Alert From $appName\",\n          \"content\": [\n            {\n              \"type\": \"text\/plain\",\n              \"value\": \"$msg\"\n           }\n          ]\n        },");

    return true;
  } catch (e) {
  }
}

String showHumanrisk(String problem, String con) {
  double value = 0.0;
  if (con == '') {
    value = 0.0;
  } else if (double.tryParse(con) != null) {
    value = double.parse(con);
  }
  String risk = '';
  switch (problem) {
    case "Blood Pressure":
      if (value <= 79.0) risk = "Low";
      if (value >= 80.0 && value <= 120.0) risk = "Normal";
      if (value >= 121.0) risk = "High";
      break;
    case "Blood Suger":
      if (value <= 123.0) risk = "Low";
      if (value >= 124.0 && value <= 128.0) risk = "Normal";
      if (value >= 129.0) risk = "High";
      break;
    case "Hemoglobin":
      if (value <= 9.0) risk = "Low";
      if (value >= 9.5 && value <= 15.0) risk = "Normal";
      if (value >= 16.0) risk = "High";
      break;
  }
  return risk;
}
