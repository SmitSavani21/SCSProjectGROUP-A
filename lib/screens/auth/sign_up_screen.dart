// ignore_for_file: sort_child_properties_last, prefer_const_constructors, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:io';
import 'package:health_app/consts/functions.dart';
import 'package:health_app/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:health_app/consts/colors.dart';
import 'package:image_picker/image_picker.dart';
import '../../consts/icons.dart';
import '../../consts/theme_utils.dart';
import '../../consts/titles.dart';
import '../../services/auth_services.dart';
import '../../utils/loader.dart';
import '../../utils/modules.dart';
import '../../utils/theme_button.dart';
import '../home_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
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

              Form(
                key: key,
                autovalidateMode: autovalidateMode,
                child: Container(
                  padding: pagePadding,
                  child: ListView(
                    children: [
                      //header
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(width * 0.03,
                                height * 0.02, width * 0.03, height * 0.005),
                            child: title(signUp),
                          ),
                        ],
                      ),

                      //sub header
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(width * 0.03,
                                height * 0.005, width * 0.03, height * 0.01),
                            child: text(signUpMsg),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          imagePicker();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(
                              0, height * 0.02, 0, height * 0.02),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              SizedBox(
                                width: width * 0.25,
                                child: pickedFile.path == ''
                                    ? CircleAvatar(
                                        radius: width * 0.125,
                                        child: profileIcon,
                                        backgroundColor: Colors.white,
                                      )
                                    : CircleAvatar(
                                        radius: width * 0.125,
                                        backgroundImage:
                                            FileImage(File(pickedFile.path))),
                              ),
                              SizedBox(
                                width: width * 0.07,
                                child: profileEditIcon,
                              ),
                            ],
                          ),
                        ),
                      ),

                      //name input
                      Padding(
                        padding: textFieldMargin,
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: nameLabel,
                            hintStyle: labelStyle,
                            fillColor: Colors.white,
                            border: textFieldBorder,
                            focusedBorder: textFieldBorder,
                            errorBorder: textFieldBorder,
                            enabledBorder: textFieldBorder,
                            focusedErrorBorder: textFieldBorder,
                            contentPadding: textFieldPadding,
                          ),
                          keyboardType: TextInputType.name,
                          style: labelStyle,
                          controller: _nameCon,
                          validator: (value) =>
                              validator(value!, "Please enter name"),
                        ),
                      ),

                      //email input
                      Padding(
                        padding: textFieldMargin,
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: emailLabel,
                            hintStyle: labelStyle,
                            fillColor: Colors.white,
                            border: textFieldBorder,
                            focusedBorder: textFieldBorder,
                            errorBorder: textFieldBorder,
                            enabledBorder: textFieldBorder,
                            focusedErrorBorder: textFieldBorder,
                            contentPadding: textFieldPadding,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          style: labelStyle,
                          controller: _emailCon,
                          validator: (value) =>
                              validator(value!, "Please enter email"),
                        ),
                      ),

                      //number input
                      Padding(
                        padding: textFieldMargin,
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: numberLabel,
                            hintStyle: labelStyle,
                            fillColor: Colors.white,
                            border: textFieldBorder,
                            focusedBorder: textFieldBorder,
                            errorBorder: textFieldBorder,
                            enabledBorder: textFieldBorder,
                            focusedErrorBorder: textFieldBorder,
                            contentPadding: textFieldPadding,
                          ),
                          keyboardType: TextInputType.number,
                          style: labelStyle,
                          controller: _numberCon,
                          validator: (value) =>
                              validator(value!, "Please enter phone number"),
                        ),
                      ),

                      //date of birth input
                      Padding(
                        padding: textFieldMargin,
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: dateOfBirthLabel,
                            hintStyle: labelStyle,
                            fillColor: Colors.white,
                            border: textFieldBorder,
                            focusedBorder: textFieldBorder,
                            errorBorder: textFieldBorder,
                            enabledBorder: textFieldBorder,
                            focusedErrorBorder: textFieldBorder,
                            contentPadding: textFieldPadding,
                          ),
                          onTap: selectDate,
                          readOnly: true,
                          style: labelStyle,
                          controller: _dobCon,
                          validator: (value) =>
                              validator(value!, "Please select birth date"),
                        ),
                      ),

                      Container(
                        margin: textFieldMargin,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(boxRadius),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Radio(
                                value: male,
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                }),
                            Text(
                              male,
                              style: labelStyle,
                            ),
                            SizedBox(width: width * 0.1),
                            Radio(
                                value: female,
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                }),
                            Text(
                              female,
                              style: labelStyle,
                            ),
                          ],
                        ),
                      ),

                      //weight input
                      Padding(
                        padding: textFieldMargin,
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: weightLabel,
                            hintStyle: labelStyle,
                            fillColor: Colors.white,
                            border: textFieldBorder,
                            focusedBorder: textFieldBorder,
                            errorBorder: textFieldBorder,
                            enabledBorder: textFieldBorder,
                            focusedErrorBorder: textFieldBorder,
                            contentPadding: textFieldPadding,
                          ),
                          keyboardType: TextInputType.number,
                          style: labelStyle,
                          controller: _weightCon,
                          validator: (value) =>
                              validator(value!, "Please enter weight"),
                        ),
                      ),
                      //address input
                      Padding(
                        padding: textFieldMargin,
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: addressLabel,
                            hintStyle: labelStyle,
                            fillColor: Colors.white,
                            border: textFieldBorder,
                            focusedBorder: textFieldBorder,
                            errorBorder: textFieldBorder,
                            enabledBorder: textFieldBorder,
                            focusedErrorBorder: textFieldBorder,
                            contentPadding: textFieldPadding,
                          ),
                          maxLines: 3,
                          style: labelStyle,
                          controller: _addressCon,
                          validator: (value) =>
                              validator(value!, "Please enter address"),
                        ),
                      ),

                      //sign in button
                      ThemeButton(onTap: handleSignUp, title: signIn),

                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, height * 0.05, 0, height * 0.01),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                          },
                          child: text(alreadyHaveAnAccount),
                        ),
                      ),

                      SizedBox(height: height * 0.02),
                    ],
                  ),
                ),
              ),
              Loader(flag: isLoading)
            ],
          ),
        ),
      ),
    );
  }

  handleSignUp() async {
    try {
      setState(() {
        isLoading = true;
      });

      if (pickedFile.path == '') {
        errorToast(context, 'Please add profile image');
      } else {
        setState(() {
          autovalidateMode = AutovalidateMode.always;
        });

        if (key.currentState!.validate()) {
          unfocus(context);
          userModel = UserModel(
              name: _nameCon.text.trim(),
              email: _emailCon.text.trim(),
              phone: _numberCon.text.trim(),
              birthDate: selectedDate.toString(),
              address: _addressCon.text.trim(),
              weight: _weightCon.text.trim(),
              image: pickedFile.path,
              gender: gender,
              userId: '',
              createdAt: DateTime.now().toString(),
              editedAt: DateTime.now().toString());

          bool result = await createUser(userModel!);
          scheduleDailyNotification(
              1,
              'It\'s time for daily check up',
              'Do your regular chekcup as per doctor\'s guidence. If found any issue contact doctor.',
              Time(11, 00));

          if (result) {
            await setTokenData(userModel!.email, userModel!.name);
            await getTokenData();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          }
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

  selectDate() async {
    dynamic startDate = DateTime.now().subtract(Duration(days: 1));
    var picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(1900),
      lastDate: startDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: themeColor1, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Colors.blueGrey, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dobCon.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  imagePicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150,
            margin: EdgeInsets.fromLTRB(30, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pick Image',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    ImagePicker imagePicker = ImagePicker();
                    pickedFile = (await imagePicker.getImage(
                      source: ImageSource.camera,
                    ))!;
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Take Photo',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    ImagePicker imagePicker = ImagePicker();
                    pickedFile = (await imagePicker.getImage(
                      source: ImageSource.gallery,
                    ))!;
                    setState(() {});

                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'From Library',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

TextEditingController _emailCon = TextEditingController();
TextEditingController _numberCon = TextEditingController();
TextEditingController _nameCon = TextEditingController();
TextEditingController _dobCon = TextEditingController();
TextEditingController _addressCon = TextEditingController();
TextEditingController _weightCon = TextEditingController();
DateTime selectedDate = DateTime.now();
bool isMale = false;
bool isLoading = false;
String gender = male;
PickedFile pickedFile = PickedFile('');
UserModel? userModel;
