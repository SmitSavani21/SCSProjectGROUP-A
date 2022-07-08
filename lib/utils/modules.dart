// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:health_app/consts/titles.dart';

import '../consts/icons.dart';
import '../consts/theme_utils.dart';

Widget appBackground(double width, double height) {
  return Stack(
    children: [
      SizedBox(
        width: width,
        height: height,
        child: background1Img,
      ),
      SizedBox(
        width: width,
        height: height,
        child: background2Img,
      ),
    ],
  );
}

Widget title(String text) {
  return Text(
    text,
    style: titleStyle,
  );
}

Widget text(String text) {
  return Text(
    text,
    style: textStyle,
  );
}
