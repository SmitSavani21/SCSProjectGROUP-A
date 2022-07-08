import 'package:flutter/material.dart';
import 'package:health_app/consts/colors.dart';
import 'package:health_app/consts/theme_utils.dart';

class SocialButton extends StatefulWidget {
  const SocialButton(
      {Key? key,
      required this.onTap,
      required this.isInsta,
      required this.icon})
      : super(key: key);
  final Widget icon;
  final dynamic onTap;
  final bool isInsta;
  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  @override
  Widget build(BuildContext context) {
  double width=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(width*0.02),
      decoration: widget.isInsta
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(boxRadius),
              gradient: instaGradient,
            )
          : BoxDecoration(
              color: facebookColor,
              borderRadius: BorderRadius.circular(boxRadius),
            ),
      child: widget.icon,
    );
  }
}
