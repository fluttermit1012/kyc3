// ignore_for_file: avoid_print, equal_keys_in_map, unused_import, non_constant_identifier_names, unused_element, use_key_in_widget_constructors, camel_case_types, prefer_const_constructors, use_build_context_synchronously, unnecessary_brace_in_string_interps
import 'dart:convert';
import 'dart:io';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:new_kyc_3/bank_details/bank_details.dart';

import 'package:new_kyc_3/common/common.dart';
import 'package:new_kyc_3/pancard/pancard.dart';


import 'package:new_kyc_3/personal_page/nominee/nm_nm_nm.dart';

String MaritalStatus = "";
String nationality = "";
String? annual_incm;
String tax_residencyy = "";
String trading_experince = "";
String? occuptionn;
String ac_op_mode = "";
String political_exposed = "No";
String nominee = "No";
String education = "";
String? selectedOccupation = '';
String? selectedIncome = '';
String? selectedtrading = '';

class personal_details extends StatefulWidget {
  @override
  State<personal_details> createState() => _personal_detailsState();
}

class _personal_detailsState extends State<personal_details> {
  Future<void> _showOccupationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Select Occupation'),
          content: DropdownButtonFormField(
            value: selectedOccupation,
            onChanged: (String? newValue) {
              setState(() {
                selectedOccupation = newValue;
              });
            },
            items: _occupation.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Do something with the selectedOccupation
                print('Selected Occupation: $selectedOccupation');
                Navigator.of(dialogContext).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showIncomeDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Select Annual Income'),
          content: SingleChildScrollView(
            child: Column(
              children: annual_income.map((String value) {
                return ListTile(
                  title: Text(value),
                  onTap: () {
                    setState(() {
                      selectedIncome = value;
                    });
                    Navigator.of(dialogContext).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _aadhardetails();
    print("######################   API CALL  ###########################");
  }

  bool _isLoading = false;

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 55,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircularProgressIndicator(),
                  Text(
                    'Please Wait...',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _hideLoadingDialog() {
    if (_isLoading) {
      Navigator.of(context).pop();
      _isLoading = false;
    }
  }

  final List<String> _occupation = [
    'Business',
    'Housewife',
    'Private',
    'Public',
    'Professional',
    'Retired',
    'Student',
    'Other',
  ];
  final List<String> _experience = [
    "1",
    "1-2",
    "2-5",
    "5-10",
    "10-20",
  ];
  final List<String> annual_income = [
    'Up To 1 Lac',
    '1-5 Lacs',
    '5-10 Lacs',
    '10-25 Lacs',
    '>25 lacs'
  ];
  String? errorMessage;
  void _aadhardetails() async {
    final response = await http.post(
        Uri.parse('http://connect.arhamshare.com:9090/EAPI/AadharDetails'),
        body: {
          'pan_card': globle.pancard_dob,
          'account_type': 'Individual',
          'session_pan': '',
          'aadhar_num': '',
          'mother_name': '',
          'annual_income_aadhar': '',
          'education_aadhar': '',
          'nominee': 'No',
          'Upload_proof': '',
          'Enter_Number': '',
          'Mobile_User': '',
          'Email_User': '',
          'ac_op_mode': '',
          'personal_father_name': '',
          'marital_status': '',
          'per_occupation': '',
          'per_trading_experience': '',
          'Nationality': 'Indian',
          'political_exposed': '',
          'tax_resident': '',
          'name_nominee': '',
          'share_percentage': '',
          'relation': '',
          'nominee_address': '',
          'nominee_state': '',
          'nominee_city': '',
          'nominee_pincode': '',
          'mobile_nominee': '',
          'email_nominee': '',
          'dob': '',
          'Enter_Number': '',
          'Guardian': '',
          'gaurdian_relation': '',
          'gaurdian_address': '',
          'gaurdian_city': '',
          'gaurdian_state': '',
          'name_nominee2': '',
          'share_percentage2': '',
          'relation2': '',
          'nominee_address2': '',
          'nominee_state2': '',
          'nominee_city2': '',
          'nominee_pincode2': '',
          'mobile_nominee2': '',
          'email_nominee2': '',
          'dob2': '',
          'Enter_Number2': '',
          'Guardian2': '',
          'gaurdian_relation2': '',
          'gaurdian_address2': '',
          'gaurdian_city2': '',
          'gaurdian_state2': '',
          'name_nominee3': '',
          'name_nominee3': '',
          'share_percentage3': '',
          'relation3': '',
          'nominee_address3': '',
          'nominee_state3': '',
          'nominee_city3': '',
          'nominee_pincode3': '',
          'mobile_nominee3': '',
          'email_nominee3': '',
          'dob3': '',
          'Enter_Number3': '',
          'Guardian3': '',
          'gaurdian_relation3': '',
          'gaurdian_address3': '',
          'gaurdian_city3': '',
          'gaurdian_state3': '',
          'kra_status': '',
          'name_other_nationality': '',
        });
    if (response.statusCode == 200) {
      globle.mother = jsonDecode(response.body)["AadharDetails"]['MotherName'];
      education = jsonDecode(response.body)["AadharDetails"]['Eduction'];
      if (education == "" || education == "null") {
        education = "Graduate";
      }
      globle.father =
          jsonDecode(response.body)["AadharDetails"]['Father_SpouseName'];
      globle.aadharr = jsonDecode(response.body)["AadharDetails"]["AadharCard"];
      globle.mobile =
          jsonDecode(response.body)["AadharDetails"]["BelongMobile"];
      globle.email =
          jsonDecode(response.body)["AadharDetails"]["BelongEmailID"];
      MaritalStatus =
          jsonDecode(response.body)["AadharDetails"]["MaritalStatus"];
      if (MaritalStatus == "" || MaritalStatus == "null") {
        MaritalStatus = "Single";
      }
      nationality = jsonDecode(response.body)["AadharDetails"]["Nationality"];
      if (nationality == "" || nationality == "null") {
        nationality = "Indian";
      }
      trading_experince =
          jsonDecode(response.body)["AadharDetails"]["TradingExp"];
      if (trading_experince == "" || trading_experince == "null") {
        trading_experince = "1";
      }

      annual_incm = jsonDecode(response.body)["AadharDetails"]["GrossIncome"];
      if (annual_incm == "" || annual_incm == "null") {
        annual_incm = "Up To 1 Lac";
      }
      occuptionn = jsonDecode(response.body)["AadharDetails"]["Occupation"];
      if (occuptionn == "" || occuptionn == "null") {
        occuptionn = "Business";
      }
      tax_residencyy =
          jsonDecode(response.body)["AadharDetails"]["ResidentStatus"];

      if (tax_residencyy == "" || tax_residencyy == "null") {
        tax_residencyy = "Yes";
      }
      ac_op_mode = jsonDecode(response.body)["AadharDetails"]["Oth_IWTrading"];

      if (ac_op_mode == "" || ac_op_mode == "null") {
        ac_op_mode = "DDPI";
      }

      print(globle.mother);
      print(globle.aadharr);
      print(globle.father);
      print(globle.mobile);
      print(globle.email);
      print(MaritalStatus);
      print(annual_incm);
      print(trading_experince);
      print(ac_op_mode);
      print(tax_residencyy);
      print(nationality);
      print(education);
      print(occuptionn);
      print(response.body);
      setState(() {
        isLoading = false;
      });
    } else {
      print('ERROR IN API CALLING');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // foregroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => pancardd()),
                );
              },
              icon: Icon(
                Icons.arrow_back_sharp,
                color: theme_color,
              )),
          //  centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Container(
            height: 50,
            width: 200,
            child: Image.asset(
              'assets/logo6.png',
            ),
          ),
        ),
        body: isLoading
            ? Center(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Please Wait",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Gotham",
                        color: theme_color,
                        fontWeight: FontWeight.w500),
                  ),
                  CircularProgressIndicator(
                    color: theme_color,
                  ),
                ],
              ))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Fill Your Personal Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Color.fromARGB(255, 4, 78, 73)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    Form(
                        key: formkey,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 5.h, top: 5.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 12.0.h,
                                    bottom: 10.h,
                                    right: 20.w,
                                    left: 20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    comman().txt(
                                        text: 'Aadhar Number', size: 12.sp),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: comman().textformfield(
                                        initialValue: globle.aadharr,
                                        onchange: (value) {
                                          setState(() {
                                            globle.aadharr = value.toString();
                                          });
                                        },
                                        hinttext: 'Enter your Aadhar number',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter your Aadhar number";
                                          } else if (value.length != 16) {
                                            setState(() {
                                              errorMessage =
                                                  "Please enter valid Aadhar number";
                                            });
                                            return "Please enter valid Aadhar number";
                                          }
                                          return null;
                                        },
                                        textinputtype: TextInputType.number,
                                        textlength: [
                                          LengthLimitingTextInputFormatter(16),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 12.0.h,
                                    bottom: 10.h,
                                    right: 20.w,
                                    left: 20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    comman()
                                        .txt(text: 'Mother Name', size: 12.sp),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: comman().textformfield(
                                        initialValue: globle.mother,
                                        onchange: (value) {
                                          setState(() {
                                            globle.mother = value.toString();
                                          });
                                        },
                                        hinttext: "Enter your mother name",
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Enter Your mother Name";
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 12.0.h,
                                  right: 20.w,
                                  left: 20.w,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    comman()
                                        .txt(text: 'Father Name', size: 12.sp),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: comman().textformfield(
                                        onchange: (value) {
                                          setState(() {
                                            globle.father = value.toString();
                                          });
                                        },
                                        initialValue: globle.father,
                                        hinttext: "Enter your father name",
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Enter Your Father Name";
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.0.r),
                                child: comman().txt(
                                    text: 'Account Operation mode:',
                                    size: 12.sp),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomRadioButton(
                                  height: 35.h,
                                  width: 95.w,
                                  customShape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.3.w, color: Colors.black54),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3.r))),
                                  enableShape: true,
                                  defaultSelected: ac_op_mode,
                                  elevation: 4,
                                  unSelectedBorderColor: textfield_color,
                                  selectedBorderColor: textfield_color,
                                  absoluteZeroSpacing: true,
                                  unSelectedColor:
                                      Theme.of(context).canvasColor,
                                  buttonLables: const [
                                    'eDIS',
                                    'DIS',
                                    'DDPI',
                                  ],
                                  buttonValues: const [
                                    'eDIS',
                                    'DIS',
                                    'DDPI',
                                    // "Ac_op_mode_ddpi",
                                    // "Ac_op_mode_dis",
                                    // "Ac_op_mode_edis",
                                  ], //Ac_op_mode_ddpi/ Ac_op_mode_dis / Ac_op_mode_edis
                                  buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor: Colors.black,
                                      textStyle: TextStyle(fontSize: 9.sp)),
                                  radioButtonValue: (value) {
                                    setState(
                                      () {
                                        ac_op_mode = value;
                                        errorMessage = null;
                                      },
                                    );
                                  },
                                  selectedColor: button_color,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              // Padding(
                              //   padding:
                              //       EdgeInsets.only(right: 20.0.w, left: 20.w),
                              //   child: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         comman()
                              //             .txt(text: 'Occupation', size: 12.sp),
                              //         Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: DropdownButtonFormField(
                              //             validator: (value) {
                              //               if (value == null ||
                              //                   value.isEmpty) {
                              //                 return "Enter Your Occupation";
                              //               }
                              //               return null;
                              //             },
                              //             style: TextStyle(
                              //               fontSize: 12.sp,
                              //               fontWeight: FontWeight.w600,
                              //               fontFamily: "Gotham",
                              //               color: txt_color1,
                              //             ),
                              //             decoration: InputDecoration(
                              //               contentPadding:
                              //                   EdgeInsets.all(10.r),
                              //               border: OutlineInputBorder(
                              //                 borderSide: BorderSide(
                              //                   color: textfield_color,
                              //                 ),
                              //                 borderRadius:
                              //                     const BorderRadius.all(
                              //                         Radius.circular(10)),
                              //               ),
                              //               errorBorder:
                              //                   const OutlineInputBorder(
                              //                 borderSide: BorderSide(
                              //                   color: Colors.red,
                              //                 ),
                              //                 borderRadius: BorderRadius.all(
                              //                     Radius.circular(10)),
                              //               ),
                              //               enabledBorder: OutlineInputBorder(
                              //                 borderSide: BorderSide(
                              //                   color: textfield_color,
                              //                 ),
                              //                 borderRadius:
                              //                     const BorderRadius.all(
                              //                         Radius.circular(10)),
                              //               ),
                              //               focusedBorder: OutlineInputBorder(
                              //                 borderSide: BorderSide(
                              //                   color: textfield_color,
                              //                 ),
                              //                 borderRadius:
                              //                     const BorderRadius.all(
                              //                         Radius.circular(10)),
                              //               ),
                              //               hintText:
                              //                   'Please select Occupation',
                              //               hintStyle: TextStyle(
                              //                 fontSize: 12.sp,
                              //                 fontFamily: "Gotham",
                              //                 color: textfield_color,
                              //               ),
                              //             ),
                              //             value: selectedOccupation,
                              //             onChanged: (String? newValue1) {
                              //               setState(() {
                              //                 selectedOccupation =
                              //                     newValue1!.toString();
                              //               });
                              //             },
                              //             onSaved: (String? value) {
                              //               occuptionn =
                              //                   value; // Update occuptionn during form save
                              //             },
                              //             items: _occupation
                              //                 .toSet()
                              //                 .toList()
                              //                 .map((String value) {
                              //               return DropdownMenuItem<String>(
                              //                 value: value,
                              //                 child: Text(value),
                              //               );
                              //             }).toList(),
                              //           ),
                              //         ),
                              //       ]),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    comman()
                                        .txt(text: 'Occupation', size: 12.sp),
                                    ElevatedButton(
                                      onPressed: () {
                                        _showOccupationDialog(context);
                                      },
                                      child: Text(selectedOccupation ??
                                          'Select Occupation'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 12.0.h,
                                    bottom: 10.h,
                                    right: 20.w,
                                    left: 20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    comman().txt(
                                        text: 'Mobile Belongs To:',
                                        size: 12.sp),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: comman().textformfield(
                                          //initialValue:storage.read('aadhar').toString() ,
                                          onchange: (value) {
                                            setState(() {
                                              globle.mobile = value;
                                            });
                                          },
                                          initialValue: globle.mobile,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please Fill up";
                                            }
                                            return null;
                                          },
                                          enabled: false),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 12.w,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0.w),
                                  child: comman()
                                      .txt(text: 'Marital Status', size: 12.sp),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomRadioButton(
                                  height: 35.h,
                                  width: 95.w,
                                  customShape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.3.w, color: Colors.black54),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3.r))),
                                  enableShape: true,
                                  defaultSelected: MaritalStatus,
                                  elevation: 4,
                                  unSelectedBorderColor: textfield_color,
                                  selectedBorderColor: textfield_color,
                                  absoluteZeroSpacing: true,
                                  unSelectedColor:
                                      Theme.of(context).canvasColor,
                                  buttonLables: const [
                                    'Single',
                                    'Married',
                                    'Other',
                                  ],
                                  buttonValues: const [
                                    "Single",
                                    "Married",
                                    "Other",
                                  ],
                                  buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor: Colors.black,
                                      textStyle: TextStyle(fontSize: 12.sp)),
                                  radioButtonValue: (value) {
                                    setState(() {
                                      MaritalStatus = value;
                                      errorMessage = null;
                                    });
                                  },
                                  selectedColor: button_color,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.0.w),
                                child: comman()
                                    .txt(text: 'Education', size: 12.sp),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomRadioButton(
                                  height: 35.h,
                                  width: 95.w,
                                  customShape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.3.w, color: Colors.black54),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3.r))),
                                  enableShape: true,
                                  defaultSelected: education,
                                  elevation: 4,
                                  unSelectedBorderColor: textfield_color,
                                  selectedBorderColor: textfield_color,
                                  absoluteZeroSpacing: true,
                                  unSelectedColor:
                                      Theme.of(context).canvasColor,
                                  buttonLables: const [
                                    'Graduate',
                                    'Post Graduate',
                                    'Other',
                                  ],
                                  buttonValues: const [
                                    "Graduate",
                                    "Post Graduate",
                                    "Other",
                                  ],
                                  buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor: Colors.black,
                                      textStyle: TextStyle(fontSize: 9.5.sp)),
                                  radioButtonValue: (value) {
                                    setState(() {
                                      education = value;
                                      errorMessage = null;
                                    });
                                  },
                                  selectedColor: button_color,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 12.0.h,
                                    bottom: 10.h,
                                    right: 20.w,
                                    left: 20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    comman().txt(
                                        text: 'Email Belongs To:', size: 12.sp),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: comman().textformfield(
                                          initialValue: globle.email,
                                          onchange: (value) {
                                            setState(() {
                                              globle.email = value;
                                            });
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please Fill up";
                                            }
                                            return null;
                                          },
                                          enabled: false),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              comman().txt(text: 'Annual Income', size: 12.sp),
                              // SingleChildScrollView(
                              //   scrollDirection: Axis.horizontal,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: CustomRadioButton(
                              //       height: 35.h,
                              //       width: 85.w,
                              //       customShape: RoundedRectangleBorder(
                              //           side: BorderSide(
                              //               width: 0.3.w, color: Colors.black54),
                              //           borderRadius: BorderRadius.all(
                              //               Radius.circular(3.r))),
                              //       enableShape: true,
                              //       defaultSelected:annual_incm,
                              //       // annual_incm.isEmpty ? "Up To 1 Lac" : annual_incm,
                              //       //
                              //       //annual_incm.isEmpty ? "Up To 1 Lac" : annual_incm.toString(),
                              //       elevation: 12,
                              //       unSelectedBorderColor: textfield_color,
                              //       selectedBorderColor: textfield_color,
                              //       absoluteZeroSpacing: true,
                              //       unSelectedColor:
                              //           Theme.of(context).canvasColor,
                              //       buttonLables: const [
                              //         'Up To 1 Lac',
                              //         '1-5 Lacs',
                              //         '5-10 Lacs',
                              //         '10-25 Lacs',
                              //         '>25 lacs'
                              //       ],
                              //       buttonValues: const [
                              //         'Up To 1 Lac',
                              //         '1-5 Lacs',
                              //         '5-10 Lacs',
                              //         '10-25 Lacs',
                              //         '>25 lacs'
                              //       ],
                              //       buttonTextStyle: ButtonTextStyle(
                              //           selectedColor: Colors.white,
                              //           unSelectedColor: Colors.black,
                              //           textStyle: TextStyle(fontSize: 10.sp)),
                              //       radioButtonValue: (value) {
                              //         setState(() {
                              //          annual_incm = value.toString();
                              //           errorMessage = null;
                              //         });
                              //       },
                              //       selectedColor: button_color,
                              //     ),
                              //   ),
                              // ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: 20.0, left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    comman()
                                        .txt(text: 'Annual Income', size: 12.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        _showIncomeDialog();
                                      },
                                      child: Text(selectedIncome ??
                                          'Select Annual Income'),
                                    ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding:
                              //       EdgeInsets.only(right: 20.0, left: 20.w),
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       comman().txt(
                              //           text: 'Annual Income', size: 12.sp),
                              //       DropdownButtonFormField<String>(
                              //         style: TextStyle(
                              //           fontSize: 12.sp,
                              //           fontWeight: FontWeight.w600,
                              //           fontFamily: "Gotham",
                              //           color: txt_color1,
                              //         ),
                              //         validator: (value) {
                              //           if (value == null || value.isEmpty) {
                              //             return "Enter Your Annual Income";
                              //           }
                              //           return null;
                              //         },
                              //         decoration: InputDecoration(
                              //           contentPadding: EdgeInsets.all(10.r),
                              //           border: OutlineInputBorder(
                              //             borderSide: BorderSide(
                              //               color: textfield_color,
                              //             ),
                              //             borderRadius: const BorderRadius.all(
                              //                 Radius.circular(10)),
                              //           ),
                              //           errorBorder: const OutlineInputBorder(
                              //             borderSide: BorderSide(
                              //               color: Colors.red,
                              //             ),
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(10)),
                              //           ),
                              //           enabledBorder: OutlineInputBorder(
                              //             borderSide: BorderSide(
                              //               color: textfield_color,
                              //             ),
                              //             borderRadius: const BorderRadius.all(
                              //                 Radius.circular(10)),
                              //           ),
                              //           focusedBorder: OutlineInputBorder(
                              //             borderSide: BorderSide(
                              //               color: textfield_color,
                              //             ),
                              //             borderRadius: const BorderRadius.all(
                              //                 Radius.circular(10)),
                              //           ),
                              //           hintText: 'Annual Income',
                              //           hintStyle: TextStyle(
                              //             fontSize: 12.sp,
                              //             fontFamily: "Gotham",
                              //             color: textfield_color,
                              //           ),
                              //         ),
                              //         value: selectedIncome,
                              //         onChanged: (String? newValue2) {
                              //           // Check if the selected value is different from the current value

                              //           setState(() {
                              //             selectedIncome = newValue2.toString();
                              //           });
                              //         },
                              //         items: annual_income
                              //             .toSet()
                              //             .toList()
                              //             .map((String value) {
                              //           return DropdownMenuItem<String>(
                              //             value: value,
                              //             child: Text(value),
                              //           );
                              //         }).toList(),
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              SizedBox(
                                height: 20.h,
                              ),
                              // Padding(
                              //   padding:
                              //       EdgeInsets.only(right: 20.0, left: 20.w),
                              //   child: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         comman().txt(
                              //             text: 'Trading Experiance',
                              //             size: 12.sp),
                              //         Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: DropdownButtonFormField<String>(
                              //             style: TextStyle(
                              //                 fontSize: 12.sp,
                              //                 fontWeight: FontWeight.w600,
                              //                 fontFamily: "Gotham",
                              //                 color: txt_color1),
                              //             validator: (value) {
                              //               if (value == null ||
                              //                   value.isEmpty) {
                              //                 return "Enter Your trading Experiance";
                              //               }
                              //               return null;
                              //             },
                              //             decoration: InputDecoration(
                              //               contentPadding:
                              //                   EdgeInsets.all(10.r),
                              //               border: OutlineInputBorder(
                              //                   borderSide: BorderSide(
                              //                     color: textfield_color,
                              //                   ),
                              //                   borderRadius:
                              //                       const BorderRadius.all(
                              //                           Radius.circular(10))),
                              //               errorBorder:
                              //                   const OutlineInputBorder(
                              //                       borderSide: BorderSide(
                              //                         color: Colors.red,
                              //                       ),
                              //                       borderRadius:
                              //                           BorderRadius.all(
                              //                               Radius.circular(
                              //                                   10))),
                              //               enabledBorder: OutlineInputBorder(
                              //                   borderSide: BorderSide(
                              //                     color: textfield_color,
                              //                   ),
                              //                   borderRadius:
                              //                       const BorderRadius.all(
                              //                           Radius.circular(10))),
                              //               focusedBorder: OutlineInputBorder(
                              //                   borderSide: BorderSide(
                              //                     color: textfield_color,
                              //                   ),
                              //                   borderRadius:
                              //                       const BorderRadius.all(
                              //                           Radius.circular(10))),
                              //               hintText:
                              //                   'Please select Your Experiance',
                              //               hintStyle: TextStyle(
                              //                   fontSize: 12.sp,
                              //                   fontFamily: "Gotham",
                              //                   color: textfield_color),
                              //             ),
                              //             value: selectedtrading,
                              //             onChanged: (String? newValue3) {
                              //               setState(() {
                              //                 selectedtrading =
                              //                     newValue3.toString();
                              //                       errorMessage = null;
                              //               });
                              //             },
                              //             items:
                              //                 _experience.map((String value) {
                              //               return DropdownMenuItem<String>(
                              //                 value: value,
                              //                 child: Text(value),
                              //               );
                              //             }).toList(),
                              //           ),
                              //         ),
                              //       ]),
                              // ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: 20.0, left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    comman().txt(
                                        text: 'Trading Experience', size: 12.0),
                                    DropdownButtonFormField<String>(
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Gotham",
                                        color: txt_color1,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Enter Your Trading Experience";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10.0),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: textfield_color,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: textfield_color,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: textfield_color,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        hintText:
                                            'Please select Your Experience',
                                        hintStyle: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: "Gotham",
                                          color: textfield_color,
                                        ),
                                      ),
                                      value: selectedtrading ??
                                          _experience
                                              .first, // Set a default value
                                      onChanged: (String? newValue3) {
                                        setState(() {
                                          selectedtrading =
                                              newValue3.toString();
                                        });
                                      },
                                      items: _experience.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.0.w),
                                child: comman()
                                    .txt(text: 'Notionality', size: 12.sp),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomRadioButton(
                                  height: 35.h,
                                  width: 90.w,
                                  customShape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.3.w, color: Colors.black54),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3.r))),
                                  enableShape: true,
                                  defaultSelected: nationality == null
                                      ? "Indian"
                                      : (nationality == "Indian"
                                          ? "Indian"
                                          : "Other"),
                                  elevation: 4,
                                  unSelectedBorderColor: textfield_color,
                                  selectedBorderColor: textfield_color,
                                  absoluteZeroSpacing: true,
                                  unSelectedColor:
                                      Theme.of(context).canvasColor,
                                  buttonLables: const [
                                    'Indian',
                                    'Other',
                                  ],
                                  buttonValues: const [
                                    "Indian",
                                    "Other",
                                  ],
                                  buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor: Colors.black,
                                      textStyle: TextStyle(fontSize: 12.sp)),
                                  radioButtonValue: (value) {
                                    setState(() {
                                      nationality = value.toString();
                                      errorMessage = null;

                                      //  print(nationality);

                                      // final na = storage.write('_na', nationality);
                                    });
                                  },
                                  selectedColor: button_color,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 12.w,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0.w),
                                  child: comman().txt(
                                      text: 'Tax residency other than india?',
                                      size: 13.sp),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomRadioButton(
                                  height: 35.h,
                                  width: 90.w,
                                  customShape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.3.w, color: Colors.black54),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3.r))),
                                  enableShape: true,
                                  defaultSelected: tax_residencyy,
                                  elevation: 4,
                                  unSelectedBorderColor: textfield_color,
                                  selectedBorderColor: textfield_color,
                                  absoluteZeroSpacing: true,
                                  unSelectedColor:
                                      Theme.of(context).canvasColor,
                                  buttonLables: const [
                                    'Yes',
                                    'No',
                                  ],
                                  buttonValues: const [
                                    "Yes",
                                    "No",
                                  ],
                                  buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor: Colors.black,
                                      textStyle: TextStyle(fontSize: 12.sp)),
                                  radioButtonValue: (value) {
                                    setState(() {
                                      tax_residencyy = value.toString();
                                    });

                                    errorMessage = null;
                                  },
                                  selectedColor: button_color,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 12.w,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0.w),
                                  child: comman().txt(
                                      text: 'Politically Exposed?',
                                      size: 12.sp),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomRadioButton(
                                  height: 35.h,
                                  width: 90.w,
                                  customShape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.3.w, color: Colors.black54),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3.r))),
                                  enableShape: true,
                                  defaultSelected: "No",
                                  elevation: 4,
                                  unSelectedBorderColor: textfield_color,
                                  selectedBorderColor: textfield_color,
                                  absoluteZeroSpacing: true,
                                  unSelectedColor:
                                      Theme.of(context).canvasColor,
                                  buttonLables: const [
                                    'Yes',
                                    'No',
                                  ],
                                  buttonValues: const [
                                    "Yes",
                                    "No",
                                  ],
                                  buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor: Colors.black,
                                      textStyle: TextStyle(fontSize: 12.sp)),
                                  radioButtonValue: (value) {
                                    setState(() {
                                      political_exposed = value.toString();
                                    });

                                    errorMessage = null;
                                  },
                                  selectedColor: button_color,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 12.w,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0.w),
                                  child: comman().txt(
                                      text: 'I/We wish to make a Nomination?',
                                      size: 12.sp),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomRadioButton(
                                  height: 35.h,
                                  width: 90.w,
                                  customShape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.3.w, color: Colors.black54),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(3.r))),
                                  enableShape: true,
                                  defaultSelected: "No",
                                  elevation: 4,
                                  unSelectedBorderColor: textfield_color,
                                  selectedBorderColor: textfield_color,
                                  absoluteZeroSpacing: true,
                                  unSelectedColor:
                                      Theme.of(context).canvasColor,
                                  buttonLables: const [
                                    'Yes',
                                    'No',
                                  ],
                                  buttonValues: const [
                                    "Yes",
                                    "No",
                                  ],
                                  buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor: Colors.black,
                                      textStyle: TextStyle(fontSize: 12.sp)),
                                  radioButtonValue: (value) {
                                    setState(() {
                                      nominee = value.toString();
                                    });

                                    errorMessage = null;

                                    if (nominee == "Yes") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const nomination_page(),
                                          ));
                                    }
                                  },
                                  selectedColor: button_color,
                                ),
                              ),
                            ],
                          ),
                        )),
                    //   );
                    // }),
                    SizedBox(
                      height: 30.h,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: errorMessage != null
                          ? Padding(
                              padding: EdgeInsets.only(left: 5.0.w),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info,
                                    size: 18.sp,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    errorMessage!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Text(''),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 40.h,
                          width: 90.w,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: const MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                elevation: const MaterialStatePropertyAll(10),
                                backgroundColor:
                                    MaterialStatePropertyAll(button_color)),
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                print("calling");
                                //  isLoading == true;
                                _session_pan();
                                print("1${globle.aadharr}");
                                print("2${globle.mother}");
                                print("3${globle.father}");
                                print("4${ac_op_mode}");
                                print("5${occuptionn}");
                                print("6${MaritalStatus}");
                                print("7${trading_experince}");
                                print("8${tax_residencyy}");
                                print("9${nominee}");
                                print("10${globle.email}");
                                print("11${globle.mobile}");
                                print("12${annual_incm}");
                                print("13${political_exposed}");
                                print("14${education}");
                              }
                            },
                            child: Text(
                              'Next',
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  fontFamily: 'Gotham',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _session_pan() async {
    // setState(() {
    //   isLoading = true;
    // });
    _isLoading = true;
    _showLoadingDialog();
    Uri url =
        Uri.parse('http://connect.arhamshare.com:9090/EAPI/AadharDetails');
    var request = http.MultipartRequest('POST', url);
    request.fields['pan_card'] = '';
    request.fields['account_type'] = 'Individual';
    request.fields['session_pan'] = globle.pancard_dob;
    request.fields['aadhar_num'] = globle.aadharr;
    request.fields['mother_name'] = globle.mother;
    request.fields['annual_income_aadhar'] = annual_incm.toString();
    request.fields['education_aadhar'] = education;
    request.fields['nominee'] = nominee;
    request.fields['Upload_proof'] = '';
    request.fields['Enter_Number'] = '';
    request.fields['Mobile_User'] = globle.mobile;
    request.fields['Email_User'] = globle.email;
    request.fields['ac_op_mode'] = ac_op_mode;
    request.fields['personal_father_name'] = globle.father;
    request.fields['marital_status'] = MaritalStatus;
    request.fields['per_occupation'] = occuptionn.toString();
    request.fields['per_trading_experience'] = trading_experince;
    request.fields['Nationality'] = nationality;
    request.fields['political_exposed'] = political_exposed;
    request.fields['tax_resident'] = tax_residencyy;
    request.fields['name_nominee'] = globle.name1;
    request.fields['share_percentage'] = globle.share1;
    request.fields['relation'] = globle.relation1.toString();
    request.fields['nominee_address'] =
        "${globle.add1_1}${globle.add2_1}${globle.add3_1}";
    request.fields['nominee_state'] = globle.state1.toString();
    request.fields['nominee_city'] = globle.city1;
    request.fields['nominee_pincode'] = globle.pincode1;
    request.fields['mobile_nominee'] = globle.mobile1;
    request.fields['email_nominee'] = globle.email1;
    request.fields['dob'] = globle.date1;
    request.fields['Enter_Number'] = globle.proofnumber1;
    request.fields['Upload_proof'] = globle.proof1.toString();
    request.fields['Guardian'] = '';
    request.fields['gaurdian_relation'] = '';
    request.fields['gaurdian_address'] = '';
    request.fields['gaurdian_city'] = '';
    request.fields['gaurdian_state'] = '';
    request.fields['name_nominee2'] = globle.name2;
    request.fields['share_percentage2'] = globle.share2;
    request.fields['relation2'] = globle.relation2.toString();
    request.fields['nominee_address2'] =
        "${globle.add1_2}${globle.add2_2}${globle.add3_2}";
    request.fields['nominee_state2'] = globle.state2.toString();
    request.fields['nominee_city2'] = globle.city2;
    request.fields['nominee_pincode2'] = globle.pincode2;
    request.fields['mobile_nominee2'] = globle.mobile2;
    request.fields['email_nominee2'] = globle.email2;
    request.fields['dob2'] = globle.date2;
    request.fields['Enter_Number2'] = globle.proofnumber2;
    request.fields['Upload_proof2'] = globle.proof2.toString();
    request.fields['Guardian2'] = '';
    request.fields['gaurdian_relation2'] = '';
    request.fields['gaurdian_address2'] = '';
    request.fields['gaurdian_city2'] = '';
    request.fields['gaurdian_state2'] = '';
    request.fields['name_nominee3'] = globle.name3;
    request.fields['share_percentage3'] = globle.share3;
    request.fields['relation3'] = globle.relation3.toString();
    request.fields['nominee_address3'] =
        "${globle.add3_1}${globle.add2_3}${globle.add3_3}";
    request.fields['nominee_state3'] = globle.state3.toString();
    request.fields['nominee_city3'] = globle.city3;
    request.fields['nominee_pincode3'] = globle.pincode3;
    request.fields['mobile_nominee3'] = globle.mobile3;
    request.fields['email_nominee3'] = globle.email3;
    request.fields['dob3'] = globle.date3;
    request.fields['Enter_Number3'] = globle.proofnumber3;
    request.fields['Upload_proof3'] = globle.proof3.toString();
    request.fields['Guardian3'] = '';
    request.fields['gaurdian_relation3'] = '';
    request.fields['gaurdian_address3'] = '';
    request.fields['gaurdian_city3'] = '';
    request.fields['gaurdian_state3'] = '';
    request.fields['kra_status'] = '';
    request.fields['name_other_nationality'] = '';
    // Add the 'aadhar_front' image

    if (globle.nominee_1_ImageFile != null) {
      //  nominee1ImageFile = File(nominee1ImageFilePath!);
      request.files.add(await http.MultipartFile.fromPath(
        'nominee_proof', // Field name for the image
        globle.nominee_1_ImageFile!.path,
        contentType:
            MediaType('image', 'jpg'), // Change to the correct image format
      ));
    }
    if (globle.nominee_2_ImageFile != null) {
      //  nominee2ImageFile = File(nominee2ImageFilePath!);
      request.files.add(await http.MultipartFile.fromPath(
        'nominee_proof2', // Field name for the image
        globle.nominee_2_ImageFile!.path,
        contentType:
            MediaType('image', 'jpg'), // Change to the correct image format
      ));
    }
    if (globle.nominee_3_ImageFile != null) {
      //   nominee3ImageFile = File(nominee3ImageFilePath!);
      request.files.add(await http.MultipartFile.fromPath(
        'nominee_proof3', // Field name for the image
        globle.nominee_3_ImageFile!.path,
        contentType:
            MediaType('image', 'jpg'), // Change to the correct image format
      ));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      _hideLoadingDialog();
      var responseDATA = await response.stream.bytesToString();
      print(responseDATA);

      print('Api calling successfully');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              content: Text('Details Upload Successfully')))
          .closed
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => bank_details()), // Corrected class name
        );
      });
    } else {
      _hideLoadingDialog();
      print('Error in api calling');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid Credetial')));
    }
  }
}
