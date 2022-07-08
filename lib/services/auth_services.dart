// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:health_app/models/user_model.dart';
import 'package:health_app/screens/auth/sign_up_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../consts/titles.dart';
import '../main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<dynamic> createUser(UserModel data) async {
  try {
    dynamic url = await upload(File(data.image));

    data.image = url;
    await FirebaseFirestore.instance.collection("Users").add(data.toJson());
    return true;
  } catch (e) {
    // handleError('');
  }
}

upload(File file) async {
  // Create a reference to the Firebase Storage bucket
  final storageRef = FirebaseStorage.instance.ref();

  final uploadTask = storageRef
      .child('profile')
      .child(DateTime.now().toString())
      .putFile(file);

  dynamic url;
  await uploadTask.whenComplete(
      () async => url = await uploadTask.snapshot.ref.getDownloadURL());

  return url;
}

Future<dynamic> sendOtpToUser(String email) async {
  try {
    String username = 'mails@sandboxb386b17a7f7142509a4836e526d12719.mailgun.org';
    String password = '95b635407f0ce8f99aed7130e687a33f-1b8ced53-b4e8805d';

    final smtpServer = SmtpServer(
      'smtp.mailgun.org',
      port: 587,
      username: username,
      password: password,
    );
    // gmail(username, password);
    // Create our message.
   
    // Map<String, String> headers = new Map();
    // headers["Authorization"] =
    //     "Bearer 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";
    // headers["Content-Type"] = "application/json";

    // String url = "https://api.sendgrid.com/v3/mail/send";

    var random = Random();
    int otp = 1000 + random.nextInt(9999 - 1000);
    verifyOTP = otp;

    // var response = await http.post(Uri.parse(url),
    //     headers: headers,
    //     body:
    //         "{\n          \"personalizations\": [\n            {\n              \"to\": [\n                {\n                  \"email\": \"$email\"\n                },\n                       ]\n            }\n          ],\n          \"from\": {\n            \"email\": \"contact@patternsign.com\"\n          },\n         \"subject\": \"Verification OTP From $appName\",\n          \"content\": [\n            {\n              \"type\": \"text\/plain\",\n              \"value\": \"your otp is  $otp\"\n           }\n          ]\n        },");
    // print('response--------------------${response.body}');
     final message = Message()
      ..from = Address('smitsavani158@gmail.com', 'Verification mail')
      ..recipients.add(email)
      ..subject = 'Verification Code'
      ..text = 'Your otp is $otp';
     try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. $e');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    return true;
  } catch (e) {
    print('error-------------------$e');
  }
}

Future<dynamic> getAllUser() async {
  QuerySnapshot snap =
      await FirebaseFirestore.instance.collection('Users').get();
  List<UserModel> userList = [];
  if (snap.docs.isNotEmpty) {
    for (var i in snap.docs) {
      UserModel userModel = userModelFromJson(json.encode(i.data()));
      if (userModel.email != doctorEmail) {
        userList.add(userModel);
      }
    }
    return userList;
  }
}

Future<bool> checkForEmail(String email) async {
  bool isExist = false;
  QuerySnapshot snap =
      await FirebaseFirestore.instance.collection('Users').get();
  if (snap.docs.isNotEmpty) {
    for (var i in snap.docs) {
      UserModel userModel = userModelFromJson(json.encode(i.data()));
      if (userModel.email == email) {
        isExist = true;
      }
    }
  }
  return isExist;
}
