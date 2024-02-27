// ignore_for_file: avoid_print, equal_keys_in_map, unused_import, non_constant_identifier_names, unused_element, use_key_in_widget_constructors, camel_case_types, prefer_const_constructors, use_build_context_synchronously, unnecessary_brace_in_string_interps
import 'dart:convert';
import 'dart:io';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_kyc_3/common/common.dart';
import 'package:http/http.dart' as http;
import 'package:new_kyc_3/bank_details/bank_details.dart';


import 'package:http_parser/http_parser.dart';
import 'package:new_kyc_3/pancard/pancard.dart';


import 'package:new_kyc_3/personal_page/nominee/nm_nm_nm.dart';

String? MaritalStatus;
String nationality = "Other";
String? gross_incm;
String tax_residencyy = "No";
String? trading_experince;
String? occuptionn;
String ac_op_mode = "";
String political_exposed = "No";
String nominee = "No";
String education = "Graduation";
String? selectedOccupation = '';
String? selectedIncome = '';
String? selectedtrading = '';

String getValidDefaultMaritalStatus(String? currentValue) {
  List<String> validValues = ["Single", "Married", "Other"];
  String fallbackValue = "Single";
  return validValues.contains(currentValue) ? currentValue! : fallbackValue;
}

String getValidDefaultEducation(String? currentValue) {
  List<String> validValues = ["Graduate", "Post Graduate", "Other"];
  String fallbackValue = "Graduate";
  return validValues.contains(currentValue) ? currentValue! : fallbackValue;
}

String getValidDefaultNationality(String? currentValue) {
  List<String> validValues = ["Indian", "Other"];
  String fallbackValue = "Indian";
  return validValues.contains(currentValue) ? currentValue! : fallbackValue;
}

String getValidDefaultTaxResidency(String? currentValue) {
  List<String> validValues = ["Yes", "No"];
  String fallbackValue = "No";
  return validValues.contains(currentValue) ? currentValue! : fallbackValue;
}

class fin_personal_details extends StatefulWidget {
  @override
  State<fin_personal_details> createState() => _fin_personal_detailsState();
}

String getValidDefaultPoliticalExposed(String? currentValue) {
  List<String> validValues = ["Yes", "No"];
  String fallbackValue = "No"; // Set your desired fallback value

  return validValues.contains(currentValue) ? currentValue! : fallbackValue;
}

String getValidDefaultNominee(String? currentValue) {
  List<String> validValues = ["Yes", "No"];
  String fallbackValue = "No"; // Set your desired fallback value

  return validValues.contains(currentValue) ? currentValue! : fallbackValue;
}

class _fin_personal_detailsState extends State<fin_personal_details> {
  String _validateDefault(String? defaultValue, List<String> valuesList) {
    return valuesList.contains(defaultValue) ? defaultValue! : valuesList.last;
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
    "0",
    "1",
    "1-2",
    "2-5",
    "5-10",
    "10-20",
  ];
  final List<String> __annual_income = [
    'Up to 1 Lac',
    '1 to 5 Lacs',
    '5 to 10 Lacs',
    '10 to 25 Lacs',
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
      var responseData = jsonDecode(response.body);
      globle.mother = jsonDecode(response.body)["AadharDetails"]['MotherName'];
      globle.aadharr = responseData["AadharDetails"]["AadharCard"];
      // education = jsonDecode(response.body)["AadharDetails"]['Eduction'];
      // if (education == "" || education == "null") {
      //   education = "Graduate";
      // }
      try {
        education = responseData["AadharDetails"]["Eduction"];
        education =
            (education == "" || education == "null") ? "Graduate" : education;
      } catch (e) {
        print("Error decoding JSON: $e");
        education = "Unknown";
      }
      globle.father =
          responseData["AadharDetails"]["Father_SpouseName"] ?? "Unknown";

      // globle.aadharr = responseData["AadharDetails"]["AadharCard"];

      // Extracting AadharCard information

      globle.mobile = responseData["AadharDetails"]["BelongMobile"];
      globle.email = responseData["AadharDetails"]["BelongEmailID"];
      MaritalStatus = responseData["AadharDetails"]["MaritalStatus"];
      if (MaritalStatus == "" || MaritalStatus == "null") {
        MaritalStatus = "Single";
      }
      nationality = responseData["AadharDetails"]["Nationality"];
      if (nationality == "" || nationality == "null") {
        nationality = "Indian";
      }
      trading_experince = responseData["AadharDetails"]["TradingExp"];
      if (trading_experince == "" || trading_experince == "null") {
        trading_experince = "";
      }

      gross_incm = responseData["AadharDetails"]["GrossIncome"].toString();
      if (gross_incm == "" || gross_incm == "null") {
        gross_incm = "";
      }
      occuptionn = responseData["AadharDetails"]["Occupation"];
      if (occuptionn == "" || occuptionn == "null") {
        occuptionn = "";
      }

      tax_residencyy = responseData["AadharDetails"]["ResidentStatus"];
      if (tax_residencyy == "" || tax_residencyy == "null") {
        tax_residencyy = "Yes";
      }
      ac_op_mode = responseData["AadharDetails"]["Oth_IWTrading"];

      if (ac_op_mode == "" || ac_op_mode == "null") {
        ac_op_mode = "";
      }

      print(globle.mother);
      print(globle.aadharr);
      print(globle.father);
      print(globle.mobile);
      print(globle.email);
      print(MaritalStatus);
      print(gross_incm);
      print(trading_experince);
      print(ac_op_mode);
      print(tax_residencyy);
      print(nationality);
      print(education);
      print(occuptionn);
      print(responseData);
      setState(() {
        isLoading = false;
      });
    } else {
      // Handle error response (e.g., display an error message)
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
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
                      height: 10,
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
                      height: 10,
                    ),

                    Form(
                        key: formkey,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 12.0, bottom: 10, right: 20, left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    comman()
                                        .txt(text: 'Aadhar Number', size: 12),
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
                                    top: 12.0, bottom: 10, right: 20, left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    comman().txt(text: 'Mother Name', size: 12),
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
                                  top: 12.0,
                                  right: 20,
                                  left: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    comman().txt(text: 'Father Name', size: 12),
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
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: comman().txt(
                                    text: 'Account Operation mode:', size: 12),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomRadioButton(
                                  height: 35,
                                  width: 95,
                                  customShape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.3, color: Colors.black54),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3))),
                                  enableShape: true,
                                  defaultSelected: _validateDefault(ac_op_mode,
                                      const ['eDIS', 'DIS', 'DDPI']),
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
                                      textStyle: TextStyle(fontSize: 9)),
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
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    comman().txt(text: 'Occupation', size: 12),
                                    DropdownButtonFormField<String>(
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Gotham",
                                        color: txt_color1,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Enter Your Occupation";
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
                                        hintText: 'Please select Occupation',
                                        hintStyle: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: "Gotham",
                                          color: textfield_color,
                                        ),
                                      ),
                                      value: _occupation.contains(occuptionn)
                                          ? occuptionn
                                          : null,
                                      onChanged: (String? newValue3) {
                                        setState(() {
                                          selectedOccupation =
                                              newValue3.toString();
                                        });
                                      },
                                      items: _occupation.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 12.0, bottom: 10, right: 20, left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    comman().txt(
                                        text: 'Mobile Belongs To:', size: 12),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: comman().textformfield(
                                          //initialValue:storage.read('aadhar').toString() ,
                                          onchange: (value) {
                                            setState(() {
                                              globle.mobile = value;
                                            });
                                          },
                                          // initialValue: globle.mobile,
                                          initialValue: 'self',
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
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 12,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: comman()
                                      .txt(text: 'Marital Status', size: 12),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomRadioButton(
                                  height: 35,
                                  width: 95,
                                  customShape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.3, color: Colors.black54),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3))),
                                  enableShape: true,
                                  defaultSelected: getValidDefaultMaritalStatus(
                                      MaritalStatus),
                                  elevation: 4,
                                  unSelectedBorderColor: textfield_color,
                                  selectedBorderColor: textfield_color,
                                  absoluteZeroSpacing: true,
                                  unSelectedColor:
                                      Theme.of(context).canvasColor,
                                  buttonLables: const [
                                    "Single",
                                    "Married",
                                    "Other",
                                  ],
                                  buttonValues: const [
                                    "Single",
                                    "Married",
                                    "Other",
                                  ],
                                  buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor: Colors.black,
                                      textStyle: TextStyle(fontSize: 12)),
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
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child:
                                    comman().txt(text: 'Education', size: 12),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomRadioButton(
                                  height: 35,
                                  width: 95,
                                  customShape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.3, color: Colors.black54),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3))),
                                  enableShape: true,
                                  defaultSelected:
                                      getValidDefaultEducation(education),
                                  elevation: 4,
                                  unSelectedBorderColor: textfield_color,
                                  selectedBorderColor: textfield_color,
                                  absoluteZeroSpacing: true,
                                  unSelectedColor:
                                      Theme.of(context).canvasColor,
                                  buttonLables: const [
                                    "Graduate",
                                    "Post Graduate",
                                    "Other",
                                  ],
                                  buttonValues: const [
                                    "Graduate",
                                    "Post Graduate",
                                    "Other",
                                  ],
                                  buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor: Colors.black,
                                      textStyle: TextStyle(fontSize: 9.5)),
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
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 12.0, bottom: 10, right: 20, left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    comman().txt(
                                        text: 'Email Belongs To:', size: 12),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: comman().textformfield(
                                          // initialValue: globle.email,
                                           initialValue: 'self',
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
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    comman()
                                        .txt(text: 'Annual Income', size: 12),
                                    DropdownButtonFormField<String>(
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Gotham",
                                        color: txt_color1,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please Select Annual Income";
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
                                        hintText: 'Please Select Annual Income',
                                        hintStyle: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: "Gotham",
                                          color: textfield_color,
                                        ),
                                      ),
                                      value: __annual_income
                                              .contains(gross_incm.toString())
                                          ? gross_incm.toString()
                                          : null,
                                      onChanged: (String? newValue3) {
                                        setState(() {
                                          selectedIncome = newValue3.toString();
                                        });
                                      },
                                      items:
                                          __annual_income.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
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
                                      value: _experience
                                              .contains(trading_experince)
                                          ? trading_experince
                                          : null,
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
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child:
                                    comman().txt(text: 'Nationality', size: 12),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomRadioButton(
                                  height: 35,
                                  width: 90,
                                  customShape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.3, color: Colors.black54),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3))),
                                  enableShape: true,
                                  defaultSelected:
                                      getValidDefaultNationality(nationality),
                                  elevation: 4,
                                  unSelectedBorderColor: textfield_color,
                                  selectedBorderColor: textfield_color,
                                  absoluteZeroSpacing: true,
                                  unSelectedColor:
                                      Theme.of(context).canvasColor,
                                  buttonLables: const [
                                    "Indian",
                                    "Other",
                                  ],
                                  buttonValues: const [
                                    "Indian",
                                    "Other",
                                  ],
                                  buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor: Colors.black,
                                      textStyle: TextStyle(fontSize: 12)),
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
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 12,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: comman().txt(
                                      text: 'Tax residency other than india?',
                                      size: 13),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomRadioButton(
                                  height: 35,
                                  width: 90,
                                  customShape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.3, color: Colors.black54),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3))),
                                  enableShape: true,
                                  defaultSelected: getValidDefaultTaxResidency(
                                      tax_residencyy),
                                  elevation: 4,
                                  unSelectedBorderColor: textfield_color,
                                  selectedBorderColor: textfield_color,
                                  absoluteZeroSpacing: true,
                                  unSelectedColor:
                                      Theme.of(context).canvasColor,
                                  buttonLables: const [
                                    "Yes",
                                    "No",
                                  ],
                                  buttonValues: const [
                                    "Yes",
                                    "No",
                                  ],
                                  buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor: Colors.black,
                                      textStyle: TextStyle(fontSize: 12)),
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
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 12,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: comman().txt(
                                      text: 'Politically Exposed?', size: 12),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomRadioButton(
                                  height: 35,
                                  width: 90,
                                  customShape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.3, color: Colors.black54),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3))),
                                  enableShape: true,
                                  defaultSelected:
                                      getValidDefaultPoliticalExposed(
                                          political_exposed),
                                  elevation: 4,
                                  unSelectedBorderColor: textfield_color,
                                  selectedBorderColor: textfield_color,
                                  absoluteZeroSpacing: true,
                                  unSelectedColor:
                                      Theme.of(context).canvasColor,
                                  buttonLables: const [
                                    "Yes",
                                    "No",
                                  ],
                                  buttonValues: const [
                                    "Yes",
                                    "No",
                                  ],
                                  buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor: Colors.black,
                                      textStyle: TextStyle(fontSize: 12)),
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
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 12,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: comman().txt(
                                      text: 'I/We wish to make a Nomination?',
                                      size: 12),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomRadioButton(
                                  height: 35,
                                  width: 90,
                                  customShape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.3, color: Colors.black54),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3))),
                                  enableShape: true,
                                  defaultSelected:
                                      getValidDefaultNominee(nominee),
                                  elevation: 4,
                                  unSelectedBorderColor: textfield_color,
                                  selectedBorderColor: textfield_color,
                                  absoluteZeroSpacing: true,
                                  unSelectedColor:
                                      Theme.of(context).canvasColor,
                                  buttonLables: const [
                                    "Yes",
                                    "No",
                                  ],
                                  buttonValues: const [
                                    "Yes",
                                    "No",
                                  ],
                                  buttonTextStyle: ButtonTextStyle(
                                      selectedColor: Colors.white,
                                      unSelectedColor: Colors.black,
                                      textStyle: TextStyle(fontSize: 12)),
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
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: errorMessage != null
                          ? Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info,
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    errorMessage!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Text(''),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 40,
                          width: 90,
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
                                 isLoading == true;
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
                                print("12${gross_incm}");
                                print("13${political_exposed}");
                                print("14${education}");
                              }
                            },
                            child: Text(
                              'Next',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Gotham',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
    request.fields['annual_income_aadhar'] = gross_incm.toString();
    request.fields['education_aadhar'] = education;
    request.fields['nominee'] = nominee;
    request.fields['Upload_proof'] = '';
    request.fields['Enter_Number'] = '';
    request.fields['Mobile_User'] = globle.mobile;
    request.fields['Email_User'] = globle.email;
    request.fields['ac_op_mode'] = ac_op_mode;
    request.fields['personal_father_name'] = globle.father;
    request.fields['marital_status'] = MaritalStatus.toString();
    request.fields['per_occupation'] = occuptionn.toString();
    request.fields['per_trading_experience'] = trading_experince.toString();
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
      // setState(() {
      //   isLoading = false;
      // });
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
