// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages, unused_import

import 'package:flutter/material.dart';
import 'package:health_app/consts/colors.dart';
import 'package:health_app/consts/functions.dart';
import 'package:health_app/consts/icons.dart';
import 'package:health_app/main.dart';
import 'package:health_app/models/visit_module.dart';
import 'package:health_app/screens/auth/sign_in_screen.dart';
import 'package:health_app/screens/home_screen.dart';
import 'package:health_app/screens/visit_list.dart';
import 'package:health_app/services/visit_services.dart';
import 'package:health_app/utils/loader.dart';
import 'package:health_app/utils/modules.dart';
import 'package:health_app/utils/theme_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../consts/theme_utils.dart';
import '../../consts/titles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              //background
              appBackground(width, height),

              Container(
                padding: pagePadding,
                child: Column(
                  children: [
                    //header
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          width * 0.03, height * 0.05, 0, height * 0.005),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          title('Records'),
                          IconButton(
                            icon: logoutIcon,
                            onPressed: handleLogOut,
                          ),
                        ],
                      ),
                    ),
                    lastRecord.isCritical
                        ? Container(
                            width: width,
                            padding: EdgeInsets.all(width * 0.02),
                            decoration: BoxDecoration(
                              color: Colors.red[200],
                              borderRadius: BorderRadius.circular(boxRadius),
                            ),
                            child: Text(
                              'NOTE: According to your last visit on ${lastRecord.createdAt.split(' ').first}, your health is critical. Your ${lastRecord.problem} is ${lastRecord.pValue} which is on ${lastRecord.problemType} stage. So take care of your self and kindly visit doctor for further precautions on ${lastRecord.nextAppointment.split(' ').first}',
                              style: labelStyle.copyWith(
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        : SizedBox(),
                    //
                    Expanded(child: VisitListModule(list: visitList)),
                  ],
                ),
              ),
              Loader(flag: isLoading),
            ],
          ),
        ),
      ),
    );
  }

  handleLogOut() async {
    try {
      setState(() {
        isLoading = true;
      });
      await clearTokenData();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignInScreen()));
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  loadData() async {
    try {
      setState(() {
        isLoading = true;
      });
      visitList = await getRecordByEmail(tokenData['email']);
      lastRecord = await getLastRecordByEmail(tokenData['email']);
   setState(() {});
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<VisitModel> visitList = [];
  VisitModel lastRecord = VisitModel(
      email: '',
      weight: '',
      notes: '',
      docs: '',
      isCritical: false,
      problem: 'Blood pressure',
      problemType: 'high',
      pValue: '102',
      nextAppointment: '2022-9-90 90:90:am',
      createdAt: '');
}
