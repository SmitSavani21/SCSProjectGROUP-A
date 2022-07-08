// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:health_app/consts/colors.dart';
import 'package:health_app/consts/titles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

EdgeInsetsGeometry pagePadding = EdgeInsets.all(15);
double boxRadius = 15;
EdgeInsetsGeometry textFieldPadding = EdgeInsets.fromLTRB(15, 8, 15, 8);
EdgeInsetsGeometry textFieldMargin = EdgeInsets.fromLTRB(0, 8, 0, 8);

LinearGradient instaGradient = LinearGradient(
  colors: [
    instaColor1,
    instaColor2,
    instaColor3,
    instaColor4,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [
    0.01,
    0.05,
    0.95,
    1,
  ],
);

PinTheme otpPinTheme(double width) {
  return PinTheme(
    shape: PinCodeFieldShape.circle,
    inactiveFillColor: Colors.white,
    activeFillColor: Colors.white,
    activeColor: themeColor2,
    inactiveColor: themeColor2,
    selectedColor: themeColor2,
    selectedFillColor: Colors.white,
    fieldWidth: width * 0.18,
  );
}

OutlineInputBorder textFieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(boxRadius),
);

TextStyle textStyle = TextStyle(
  fontSize: 13,
  color: Colors.white,
  fontFamily: fontFamily,
);

TextStyle titleStyle = TextStyle(
  fontSize: 24,
  color: Colors.white,
  fontFamily: fontFamily,
  fontWeight: FontWeight.w600,
);

TextStyle labelStyle = TextStyle(
  fontSize: 14,
  color: Colors.black,
  fontFamily: fontFamily,
);
