import 'package:flutter/material.dart';
import 'package:health_app/consts/colors.dart';
import 'package:health_app/consts/theme_utils.dart';
import 'package:health_app/consts/titles.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({Key? key, required this.onTap, required this.title})
      : super(key: key);
  final String title;
  final dynamic onTap;
  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.all(width * 0.03),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [themeColor1, themeColor2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(boxRadius),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
