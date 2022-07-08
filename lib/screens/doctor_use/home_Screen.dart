// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages, unused_import, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:health_app/consts/colors.dart';
import 'package:health_app/consts/functions.dart';
import 'package:health_app/consts/icons.dart';
import 'package:health_app/main.dart';
import 'package:health_app/screens/auth/sign_in_screen.dart';
import 'package:health_app/screens/doctor_use/add_record_screen.dart';
import 'package:health_app/screens/home_screen.dart';
import 'package:health_app/utils/loader.dart';
import 'package:health_app/utils/modules.dart';
import 'package:health_app/utils/theme_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../consts/theme_utils.dart';
import '../../consts/titles.dart';
import '../../models/visit_module.dart';
import '../../services/visit_services.dart';
import '../visit_list.dart';

class DHomeScreen extends StatefulWidget {
  const DHomeScreen({Key? key}) : super(key: key);

  @override
  State<DHomeScreen> createState() => DHomeScreenState();
}

class DHomeScreenState extends State<DHomeScreen> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddrecordScreen()));
        },
        child: addIcon,
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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

      visitList = await getAllRecord();
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
}
