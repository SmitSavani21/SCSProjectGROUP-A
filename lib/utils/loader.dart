// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../consts/functions.dart';
class Loader extends StatelessWidget {
  const Loader({Key? key, required this.flag}) : super(key: key);

  final bool flag;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return flag
        ? Container(
            width: width,
            height: height,
            color: Colors.black45.withOpacity(0.2),
            child: loader(),
          )
        : const SizedBox();
  }
}

