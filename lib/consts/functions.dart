// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'colors.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

dynamic currentFocus;

loader() {
  return Center(
    child: CircularProgressIndicator(
      color: themeColor1,
    ),
  );
}

//store access token of user
setTokenData(String email, String name) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString("email", email);
  pref.setString("name", name);
}

//get access token of user
getTokenData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  tokenData['email'] = pref.getString("email") ?? '';
  tokenData['name'] = pref.getString("name") ?? '';
}

//clear access token from share preference
clearTokenData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.remove("email");
  pref.remove("name");
}

//hide keyboard
unfocus(BuildContext context) {
  currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

Widget loadingBuilder(
    BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
  if (loadingProgress == null) return child;
  return Center(
    child: CircularProgressIndicator(
      color: themeColor1,
      value: loadingProgress.expectedTotalBytes != null
          ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
          : null,
    ),
  );
}

Widget errorBuilder(BuildContext context, Object child, StackTrace? trace) {
  return Container();
}

dynamic launchUrlReport(String url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch Report';
  return await "Report";
}

successToast(BuildContext context, String msg) {
  MotionToast.success(
    description: Text(msg),
    width: 300,
  ).show(context);
}

errorToast(BuildContext context, String msg) {
  MotionToast.error(
    description: Text(msg),
  ).show(context);
}

scheduleDailyNotification(int id, String title, String des, Time time) {
  try {
    // ignore: deprecated_member_use
    flutterLocalNotificationsPlugin.showDailyAtTime(
        id,
        title,
        des,
        time,
        NotificationDetails(
            android: AndroidNotificationDetails(
              "Reminder Notify",
              "Reminder Notify",
              enableVibration: true,
              importance: Importance.max,
              priority: Priority.max,
            ),
            iOS: IOSNotificationDetails(
              presentAlert: true,
              presentSound: true,
            )));
  } catch (e) {
    rethrow;
  }
}

validator(String value, String msg) {
  if (value.trim().isEmpty) {
    return msg;
  } else {
    return null;
  }
}
