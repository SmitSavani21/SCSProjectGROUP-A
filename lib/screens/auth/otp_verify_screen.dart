// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages, unused_import

import 'package:flutter/material.dart';
import 'package:health_app/consts/colors.dart';
import 'package:health_app/consts/functions.dart';
import 'package:health_app/main.dart';
import 'package:health_app/screens/doctor_use/home_Screen.dart';
import 'package:health_app/screens/home_screen.dart';
import 'package:health_app/utils/loader.dart';
import 'package:health_app/utils/modules.dart';
import 'package:health_app/utils/theme_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../consts/theme_utils.dart';
import '../../consts/titles.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class OTPverifyScreen extends StatefulWidget {
  const OTPverifyScreen({Key? key, required this.email}) : super(key: key);
  final String email;
  @override
  State<OTPverifyScreen> createState() => _OTPverifyScreenState();
}

class _OTPverifyScreenState extends State<OTPverifyScreen> {
  bool isLoading = false;
  TextEditingController textEditingController = TextEditingController();
  String currentText = '';
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //header
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(width * 0.03,
                              height * 0.02, width * 0.03, height * 0.005),
                          child: title(otpVerification),
                        ),
                      ],
                    ),

                    //sub header
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(width * 0.03,
                              height * 0.005, width * 0.03, height * 0.01),
                          child: text(signIn),
                        ),
                      ],
                    ),
                    PinCodeTextField(
                      appContext: context,
                      length: 4,
                      obscureText: false,
                      validator: (v) {
                        if (v!.length < 4) {
                          return "Enter Valid OTP";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: otpPinTheme(width),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                    ),
                    SizedBox(height: height * 0.3),
                    //sign in button
                    ThemeButton(onTap: handleSubmit, title: submit),

                    SizedBox(height: height * 0.02),
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

  handleSubmit() async {
    try {
      setState(() {
        isLoading = true;
      });

      if (verifyOTP == int.parse(currentText)) {
        await setTokenData(widget.email, '');
        await getTokenData();
        if (widget.email.trim() != doctorEmail) {
          scheduleDailyNotification(
              1,
              'It\'s time for daily check up',
              'Do your regular chekcup as per doctor\'s guidence. If found any issue contact doctor.',
              Time(11, 00));
        }

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => widget.email.trim() == doctorEmail
                ? DHomeScreen()
                : HomeScreen()));
      } else {
        textEditingController.clear();
        currentText = '';
        errorToast(context, 'Please enter valid OTP');
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
