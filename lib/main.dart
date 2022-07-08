// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:health_app/consts/functions.dart';
import 'package:health_app/consts/titles.dart';
import 'package:health_app/screens/doctor_use/home_Screen.dart';
import 'package:health_app/screens/home_screen.dart';
import 'screens/auth/sign_in_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await getTokenData();

  var initializationSettingAndroid =
      AndroidInitializationSettings('ic_launcher');
  var initializationSettings = InitializationSettings(
      android: initializationSettingAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload!.isNotEmpty) {}
  });

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: tokenData['email'] != ''
          ? tokenData['email'] == doctorEmail
              ? DHomeScreen()
              : HomeScreen()
          : SignInScreen(),
    );
  }
}

int verifyOTP = 0;
dynamic tokenData = {"email": "", "name": ""};

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(onDidReceiveLocalNotification: (
  int id,
  String? title,
  String? body,
  String? payload,
) async {
  didReceiveLocalNotificationSubject.add(
    ReceivedNotification(
      id: id,
      title: title,
      body: body,
      payload: payload,
    ),
  );
});

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();
