import 'package:flutter/material.dart';
import 'package:health_app/models/visit_module.dart';

import '../consts/functions.dart';
import '../consts/theme_utils.dart';

class VisitModule extends StatefulWidget {
  const VisitModule({Key? key, required this.model}) : super(key: key);
  final VisitModel model;
  @override
  State<VisitModule> createState() => _VisitModuleState();
}

class _VisitModuleState extends State<VisitModule> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(width * 0.03),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Next Appointment : ${widget.model.nextAppointment.split(' ').first}",
            style: labelStyle,
          ),
          SizedBox(height: height * 0.01),
          Text(
            "Email : ${widget.model.email}",
            style: labelStyle,
          ),
          // SizedBox(height: height * 0.01),
          // Text(
          //   "Weight : ${widget.model.weight} KG",
          //   style: labelStyle,
          // ),
          SizedBox(height: height * 0.01),
          Text(
            "Notes : ${widget.model.notes}",
            style: labelStyle,
          ),
          Row(
            children: [
              Text(
                "Doc :",
                style: labelStyle,
              ),
              TextButton(
                onPressed: () {
                  launchUrlReport(widget.model.docs);
                },
                child: Text(
                  "Report",
                  style: labelStyle.copyWith(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
