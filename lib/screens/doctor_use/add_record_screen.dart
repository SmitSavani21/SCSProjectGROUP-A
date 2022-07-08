// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, depend_on_referenced_packages, unused_import, sort_child_properties_last, prefer_final_fields

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:health_app/consts/colors.dart';
import 'package:health_app/consts/functions.dart';
import 'package:health_app/consts/icons.dart';
import 'package:health_app/main.dart';
import 'package:health_app/models/visit_module.dart';
import 'package:health_app/screens/auth/sign_in_screen.dart';
import 'package:health_app/screens/auth/sign_up_screen.dart';
import 'package:health_app/screens/home_screen.dart';
import 'package:health_app/utils/loader.dart';
import 'package:health_app/utils/modules.dart';
import 'package:health_app/utils/theme_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../consts/theme_utils.dart';
import '../../consts/titles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

import '../../models/user_model.dart';
import '../../services/auth_services.dart';
import '../../services/visit_services.dart';
import 'home_Screen.dart';

class AddrecordScreen extends StatefulWidget {
  const AddrecordScreen({Key? key}) : super(key: key);

  @override
  State<AddrecordScreen> createState() => AddrecordScreenState();
}

class AddrecordScreenState extends State<AddrecordScreen> {
  bool isLoading = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
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
                child: Form(
                  key: key,
                  autovalidateMode: autovalidateMode,
                  child: ListView(
                    children: [
                      //header
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            width * 0.03, height * 0.05, 0, height * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            title('Add Records'),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.fromLTRB(
                            width * 0.04, 0, width * 0.02, 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(boxRadius),
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text(selectedUser.name == 'name'
                              ? 'Select User'
                              : selectedUser.name),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: userList.map((UserModel items) {
                            return DropdownMenuItem(
                              value: items.name,
                              child: Text(items.name),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedUser = userList
                                  .where((element) => element.name == newValue)
                                  .toList()
                                  .first;
                            });
                          },
                          underline: Container(color: Colors.white),
                        ),
                      ),

                      //name
                      Container(
                        width: width,
                        margin: textFieldMargin,
                        padding: EdgeInsets.all(width * 0.03),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(boxRadius),
                        ),
                        child: Text(selectedUser.name),
                      ),

                      //email
                      Container(
                        width: width,
                        margin: textFieldMargin,
                        padding: EdgeInsets.all(width * 0.03),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(boxRadius),
                        ),
                        child: Text(selectedUser.email),
                      ),

                      Row(
                        children: [
                          //birth date
                          Expanded(
                            child: Container(
                              width: width,
                              margin: textFieldMargin,
                              padding: EdgeInsets.all(width * 0.03),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(boxRadius),
                              ),
                              child:
                                  Text(selectedUser.birthDate.split(' ').first),
                            ),
                          ),
                          SizedBox(width: width * 0.02),

                          //female
                          Expanded(
                            child: Container(
                              width: width,
                              margin: textFieldMargin,
                              padding: EdgeInsets.all(width * 0.03),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(boxRadius),
                              ),
                              child: Text(selectedUser.gender),
                            ),
                          ),
                        ],
                      ),

                      //phone number
                      Container(
                        width: width,
                        margin: textFieldMargin,
                        padding: EdgeInsets.all(width * 0.03),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(boxRadius),
                        ),
                        child: Text(selectedUser.phone),
                      ),

                      //address
                      Container(
                        width: width,
                        margin: textFieldMargin,
                        padding: EdgeInsets.all(width * 0.03),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(boxRadius),
                        ),
                        child: Text(selectedUser.address),
                      ),

                      Divider(
                        color: Colors.white,
                      ),

                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                fileName,
                                style: labelStyle.copyWith(color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: ThemeButton(
                                  onTap: pickDocument, title: 'Upload'),
                            ),
                          ],
                        ),
                      ),
                      isFileEmpty
                          ? Text(
                              'Please add report file',
                              style: labelStyle.copyWith(color: Colors.red),
                            )
                          : SizedBox(),

                      //weight input
                      // Padding(
                      //   padding: textFieldMargin,
                      //   child: TextFormField(
                      //     decoration: InputDecoration(
                      //       filled: true,
                      //       hintText: weightLabel,
                      //       hintStyle: labelStyle,
                      //       fillColor: Colors.white,
                      //       border: textFieldBorder,
                      //       focusedBorder: textFieldBorder,
                      //       errorBorder: textFieldBorder,
                      //       enabledBorder: textFieldBorder,
                      //       focusedErrorBorder: textFieldBorder,
                      //       contentPadding: textFieldPadding,
                      //     ),
                      //     keyboardType: TextInputType.number,
                      //     style: labelStyle,
                      //     controller: _weightCon,
                      //     validator: (value) =>
                      //         validator(value!, "Please add weight"),
                      //   ),
                      // ),

                      //date of birth input
                      Padding(
                        padding: textFieldMargin,
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Next Appointment',
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
                          validator: (value) => validator(
                              value!, "Please select appointment date"),
                        ),
                      ),

                      //address input
                      Padding(
                        padding: textFieldMargin,
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Notes',
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
                              validator(value!, "Please add notes"),
                        ),
                      ),

                      //critical
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Is patient\'s health critical?',
                            style: labelStyle.copyWith(color: Colors.white),
                          ),
                          Switch(
                            value: isCritical,
                            onChanged: (value) {
                              setState(() {
                                isCritical = value;
                              });
                            },
                            activeColor: themeColor1,
                          ),
                        ],
                      ),
                      isCritical
                          ? Container(
                              padding: EdgeInsets.fromLTRB(
                                  width * 0.04, 0, width * 0.02, 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(boxRadius),
                              ),
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text(selectedProblem == ''
                                    ? 'Select Problem'
                                    : selectedProblem),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: [
                                  "Blood Pressure",
                                  "Blood Suger",
                                  "Hemoglobin"
                                ].map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedProblem = newValue.toString();
                                  });
                                },
                                underline: Container(color: Colors.white),
                              ),
                            )
                          : SizedBox(),
                      isCritical
                          ? Padding(
                              padding: textFieldMargin,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        hintText: '00.00',
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
                                      controller: problemCon,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(boxRadius),
                                      ),
                                      child: Text(
                                        showHumanrisk(
                                            selectedProblem, problemCon.text),
                                        style: labelStyle.copyWith(
                                            color: showHumanrisk(
                                                            selectedProblem,
                                                            problemCon.text) ==
                                                        'Low' ||
                                                    showHumanrisk(
                                                            selectedProblem,
                                                            problemCon.text) ==
                                                        "High"
                                                ? Colors.red
                                                : showHumanrisk(selectedProblem,
                                                            problemCon.text) ==
                                                        "Normal"
                                                    ? Colors.green
                                                    : Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),

                      SizedBox(height: height * 0.03),
                      ThemeButton(onTap: handleSubmit, title: 'Submit'),
                    ],
                  ),
                ),
              ),
              Loader(flag: isLoading),
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController _dobCon = TextEditingController();
  TextEditingController _addressCon = TextEditingController();
  TextEditingController _weightCon = TextEditingController();
  TextEditingController problemCon = TextEditingController();
  DateTime selectedDate = DateTime.now();
  List<UserModel> userList = [];
  File selectedFile = File('');
  UserModel selectedUser = UserModel(
      name: 'name',
      email: 'email',
      phone: 'phone',
      birthDate: 'birthDate',
      address: 'address',
      weight: 'weight',
      image: 'image',
      gender: 'gender',
      userId: 'userId',
      createdAt: 'createdAt',
      editedAt: 'editedAt');
  List<String> item = ["1", "2"];
  String fileName = '';
  String selectedProblem = '';
  String selectedType = '';
  bool isCritical = false;
  bool isFileEmpty = false;
  handleSubmit() async {
    try {
      setState(() {
        isLoading = true;
      });

      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
      if (selectedFile.path == '') {
        setState(() {
          isFileEmpty = true;
        });
      } else {
        setState(() {
          isFileEmpty = false;
        });
      }

      if (key.currentState!.validate()) {
        if (selectedUser.name == 'name') {
          errorToast(context, 'Please Select Patient');
        }
        String url = await uploadFile(selectedFile);

        VisitModel visitModel = VisitModel(
            email: selectedUser.email,
            weight: _weightCon.text,
            notes: _addressCon.text,
            docs: url,
            nextAppointment: selectedDate.toString(),
            createdAt: DateTime.now().toString(),
            isCritical: isCritical,
            problem: selectedProblem,
            problemType: showHumanrisk(selectedProblem, problemCon.text),
            pValue: problemCon.text);

        if (isCritical) {
          if (visitModel.problemType == 'Low' ||
              visitModel.problemType == 'High') {
            await sendReportMail(selectedUser.email,
                'Hello ${selectedUser.name}, We check your report and found a critical issue of $selectedProblem. Your score of $selectedProblem is ${problemCon.text} that is ${visitModel.problemType}. So we schedule your appintment on ${_dobCon.text}. Hope you be there. Thank You.');
          }
        }

        await addVisitRecord(visitModel);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DHomeScreen()));
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
      firstDate: startDate,
      lastDate: DateTime(3000),
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

  pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        selectedFile = File(result.files.single.path!);
        setState(() {
          fileName = selectedFile.path.split('/').last;
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
    }
  }

  loadData() async {
    try {
      setState(() {
        isLoading = true;
      });
      userList.clear();
      userList = await getAllUser();
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
