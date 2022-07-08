// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:health_app/consts/colors.dart';

Image background1Img = Image.asset(
  'assets/images/bg1.png',
  filterQuality: FilterQuality.high,
  fit: BoxFit.fill,
);

Image background2Img = Image.asset(
  'assets/images/bg2.png',
  filterQuality: FilterQuality.high,
  fit: BoxFit.fill,
);

Icon instaIcon = Icon(
  AntDesign.instagram,
  color: Colors.white,
);

Icon facebookIcon = Icon(
  FontAwesome.facebook_f,
  color: Colors.white,
);

Icon checkIcon = Icon(
  Icons.check_circle,
  color: themeColor2,
);

Icon profileIcon = Icon(
  Icons.person,
  size: 60,
  color: themeColor2,
);

Widget profileEditIcon = CircleAvatar(
  backgroundColor: Colors.green.shade700,
  child: Icon(
    MaterialIcons.edit,
    color: Colors.white,
  ),
);

Icon logoutIcon = Icon(
  Icons.logout,
  color: themeColor2,
);

Icon addIcon = Icon(
  Icons.add,
  color: themeColor2,
);
