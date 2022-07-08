// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_app/consts/icons.dart';
import 'package:health_app/screens/auth/sign_up_screen.dart';
import 'package:health_app/services/auth_services.dart';
import 'package:health_app/utils/loader.dart';
import 'package:health_app/utils/modules.dart';
import 'package:health_app/utils/theme_button.dart';
import '../../consts/functions.dart';
import '../../consts/theme_utils.dart';
import '../../consts/titles.dart';
import 'otp_verify_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isEmailSelected = true;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                //background
                appBackground(width, height),

                Form(
                  key: key,
                  autovalidateMode: autovalidateMode,
                  child: Container(
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
                              child: title(signIn),
                            ),
                          ],
                        ),

                        //sub header
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(width * 0.03,
                                  height * 0.005, width * 0.03, height * 0.01),
                              child: text(signInMsg),
                            ),
                          ],
                        ),

                        //login input fields
                        Container(
                          padding: EdgeInsets.all(width * 0.03),
                          margin: EdgeInsets.fromLTRB(width * 0.03,
                              height * 0.02, width * 0.03, height * 0.03),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(boxRadius),
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  suffixIcon:
                                      isEmailSelected ? checkIcon : SizedBox(),
                                ),
                                onTap: () {
                                  setState(() {
                                    isEmailSelected = true;
                                  });
                                },
                                controller: emailCon,
                                validator: (value) =>
                                    validator(value!, "Please enter email"),
                              ),
                            ],
                          ),
                        ),

                        //sign in button
                        ThemeButton(
                            onTap: () {
                              handleSignIn();
                            },
                            title: signIn),

                        SizedBox(height: height * 0.05),

                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, height * 0.05, 0, height * 0.01),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                            },
                            child: text(newUserSignUp),
                          ),
                        ),

                        SizedBox(height: height * 0.02),
                      ],
                    ),
                  ),
                ),
                Loader(flag: isLoading),
              ],
            ),
          ),
        ),
      ),
    );
  }

  handleSignIn() async {
    try {
      setState(() {
        isLoading = true;
      });
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });

      if (key.currentState!.validate()) {
        bool isExist = await checkForEmail(emailCon.text.trim());

        if (isExist) {
          if (isEmailSelected) {
            bool result = await sendOtpToUser(emailCon.text);
            if (result) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OTPverifyScreen(email: emailCon.text)));
            }
          }
        } else {
          errorToast(context,
              'We can not found your email in our system. Please try with registered email');
        }
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

  TextEditingController emailCon = TextEditingController();
  TextEditingController mobileCon = TextEditingController();
}
