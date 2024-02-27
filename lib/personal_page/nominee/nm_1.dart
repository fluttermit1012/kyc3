// ignore_for_file: camel_case_types, equal_keys_in_map, avoid_print, unused_element, unused_local_variable, unnecessary_brace_in_string_interps, non_constant_identifier_names, unused_field
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:new_kyc_3/common/common.dart';
// import 'package:new_kyc_3/nomination/nominationform1.dart';
bool forerror = false;
bool forpan = false;
String? errorMessage1;
String? errorMessage2;
String? errorMessage3;
final GlobalKey<FormState> formkey1 = GlobalKey<FormState>();

//  String nominee1_Path = '';
class nominee1 extends StatefulWidget {
  const nominee1({super.key});
  @override
  State<nominee1> createState() => _nominee1State();
}

class _nominee1State extends State<nominee1> {
 
  final TextEditingController _date1 = TextEditingController();

 @override
 void initState() {
 _date1.text = globle.date1;
    super.initState();
  }

  final List<String> _relation = [
    "Father",
    "Mother",
    "Brother",
    "sister",
    "Son",
    "Daughter",
  ];
  final List<String> _states = [
    'Andaman and Nicobar Islands',
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chandigarh',
    'Chhattisgarh',
    'Dadra and Nagar Haveli',
    'Daman and Diu',
    'Delhi',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Lakshadweep',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Puducherry',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];
  final List<String> _proofname = ["Aadhar Card", "PAN card"];
 final _uppercaseFormatter = FilteringTextInputFormatter.allow(RegExp('[A-Z]'));
   bool _checkbox2 = false;
  //  String? relation;
  // String? state;
  // String? _proof;
  List<Widget> formgroups = [];
  DateTime? _selectedDate;


Future<void> nominee1_proofupload() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg'],
  );

  if (result != null) {
    String? fileName = result.files.single.name;
    final filePath = result.files.single.path;
    if (filePath != null && filePath.isNotEmpty) {
  setState(() {
   globle.nominee1_Path = filePath.split('/').last; // Set the file name only
   globle.nominee_1_ImageFile = File(filePath);
  
  });
  // await  storage.write('nominee_1_Path', nominee1_Path);
  // await  storage.write('nominee_1_ImageFile', globle.nominee_1_ImageFile!.path);
}
}
}

  Future<void> _selectDate(BuildContext context) async {
  

  //   storage.write('_date1', _selectedDate);
    final DateTime picked = (await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: theme_color,
              
// Set the color of the header
              // Set the color of the selected date
              colorScheme: ColorScheme.light(primary: theme_color),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        }))!;

    if (picked != _selectedDate) {
      //picked != null &&
      setState(() {
        _selectedDate = picked;
      globle.date1 = picked.toLocal().toString().split(' ')[0];
      _date1.text = globle.date1;
      //  storage.write('_date1', _date1.text);
        
      });
    }
  }

  bool isEmailValid(String email) {
    final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPAN(String panNumber) {
    final RegExp panPattern = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    return panPattern.hasMatch(panNumber);
  }

  @override
  void dispose() {
  //  _date1.dispose();
  //  nominee_1_Path.dispose();
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey1,
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: comman().txt(text: 'Details Of Nominee 1:', size: 15.sp),
          ),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.0.h, right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:const  EdgeInsets.only(bottom :8.0),
                  child: comman().txt(text: 'Name of nominee: 1', size: 12.sp),
                ),
                comman().textformfield(
                  onchange: (value) {
                    setState(() {
                       globle.name1 = value.toString();
                    });
               
                  },
                  initialValue: globle.name1,
                  hinttext: "Nominee Name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter nominee name";
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(bottom :8.0),
                  child: comman().txt(
                      text: 'Share of each nominee in(%)and not more than 100%',
                      size: 11.sp),
                ),
                comman().textformfield(
                    onchange: (value) {
                      setState(() {
                        globle.share1 = value.toString();
                      });
                    //  final share = storage.write('_share1', _share1.text);
                    },
                    textlength: [LengthLimitingTextInputFormatter(3)],
                    initialValue: globle.share1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a number between 1 and 100";
                      }
                      final int? number = int.tryParse(value);
                      if (number == null || number < 1 || number > 100 ) {
                        return "Enter a valid  percentage between 1 and 100";
                      }
                      return null;
                    },
                    hinttext: "Share Of Each Nominee",
                    textinputtype: TextInputType.number),
              ],
            ),
          ),

          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(bottom :8.0),
                child: comman().txt(text: 'Relation With Application', size: 12.sp),
              ),
              DropdownButtonFormField<String>(
                style: TextStyle(
                    color: txt_color1,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Gotham",
                    fontSize: 12.sp),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select your relation";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.all(10.r),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfield_color,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: '--Select Relation--',
                  hintStyle: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: "Gotham",
                      color: textfield_color),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfield_color,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfield_color,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                ),
                value: globle.relation1 ,
                onChanged: (String? newValue) {
                  setState(() {
                 globle.relation1   = newValue;
                
                  });
                },
                items: _relation.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ]),
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStatePropertyAll(txt_color2),
                value: _checkbox2,
                onChanged: (bool? value) {
                  setState(() {
                    _checkbox2 = value!;
                  });
                },
              ),
              comman().txt(
                  text: '''nominee address same as a my address''',
                  size: 12.sp),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.0.h, right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(bottom :8.0),
                  child: comman().txt(text: 'Address 1:', size: 12.sp),
                ),
                comman().textformfield(
                  onchange: (value) {
                    setState(() {
                      globle.add1_1 = value.toString();
                    });
                   // final add1_1 = storage.write('_add1_1', _add1_1.text);
                  },
                  hinttext: "Address 1",
                  initialValue: globle.add1_1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Your address";
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0.h, right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const  EdgeInsets.only(bottom :8.0),
                  child: comman().txt(text: 'Address 2:', size: 12.sp),
                ),
                comman().textformfield(
                  onchange: (value) {
                    setState(() {
                      globle.add2_1 = value.toString();
                    });
                  //  final add2_1 = storage.write('_add2_1', _add2_1.text);
                  },
                  hinttext: "Address 2",
                  initialValue: globle.add2_1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Your address";
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0.h, right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const  EdgeInsets.only(bottom :8.0),
                      child: comman().txt(text: 'Address 3:', size: 12.sp),
                    ),
                    Padding(
                      padding: const  EdgeInsets.only(bottom :8.0),
                      child: Text(
                        '(Please Do Not Enter City Or Pincode In Address3)',
                        style: TextStyle(
                            fontSize: 9.sp,
                            color: Colors.red,
                            fontFamily: "Gotham",
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
                comman().textformfield(
                  hinttext: "Address 3",
                  onchange: (value) {
                    setState(() {
                      globle.add3_1 = value.toString();
                    });
                   // final add3_1 = storage.write('_add3_1', _add3_1.text);
                  },
                  initialValue: globle.add3_1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Your address";
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0.h, right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const  EdgeInsets.only(bottom :8.0),
                  child: comman().txt(text: 'City:', size: 12.sp),
                ),
                comman().textformfield(
                  onchange: (value) {
                    setState(() {
                      globle.city1 = value.toString();
                    });
                   // final city_1 = storage.write('_city1', _city1.text);
                  },
                  initialValue: globle.city1,
                  hinttext: "Enter City Name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your city";
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0.h, right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const  EdgeInsets.only(bottom :8.0),
                  child: comman().txt(text: 'Pincode', size: 12.sp),
                ),
                comman().textformfield(
                    onchange: (value) {
                      setState(() {
                        globle.pincode1 = value.toString();
                      });
                     // final pincode =  storage.write('_pincode1', _pincode1.text);
                    },
                   initialValue: globle.pincode1,
                    hinttext: "Enter Pincode",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter pincode";
                      } else if (value.length != 6) {
                        return "Please enter pincode";
                      }
                      return null;
                    },
                    textlength: [LengthLimitingTextInputFormatter(6)],
                    textinputtype: TextInputType.number)
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const  EdgeInsets.only(bottom :8.0),
                child: comman().txt(text: 'State', size: 12.sp),
              ),
              DropdownButtonFormField<String>(
                style: TextStyle(
                    color: txt_color1,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Gotham",
                    fontSize: 12.sp),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select your state";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.all(10.r),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfield_color,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfield_color,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfield_color,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  hintText: '--Select State--',
                  hintStyle: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: "Gotham",
                      color: textfield_color),
                ),
                value: globle.state1,
                onChanged: (String? newValue) {
                  setState(() {
                  globle.state1 = newValue;
                   // globle.state1 = state.toString();
                 //   final state_ = storage.write('_state1', state);
                  });
                },
                items: _states.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0.h, right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const  EdgeInsets.only(bottom :8.0),
                  child: comman().txt(text: 'Country', size: 12.sp),
                ),
                comman().textformfield(
                  onchange: (value) {
                    setState(() {
                      globle.country1 = value.toString();
                    });
                   //  storage.write('_country1_', _country1.text);
                    setState(() {  
                  // storage.write('_country', _country1);                
                 //  storage.write('_country1', _country1.value);
                  
                     });
                  },
                 initialValue: globle.country1,
                  hinttext: "INDIA",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your country";
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0.h, right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom :8.0),
                  child: comman()
                      .txt(text: 'Mobile No Of Nominee(Optional):', size: 12.sp),
                ),
                comman().textformfield(
                    textinputtype: TextInputType.number,
                    textlength: [LengthLimitingTextInputFormatter(10)],
                   initialValue: globle.mobile1,
                    onchange: (value) {
                      setState(() {
                        globle.mobile1 = value.toString();
                      });
                    //  final mobile = storage.write('_mobile1', _mobile1.text);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter nominee's mobile no.";
                      } else if (value.length != 10) {
                        return "Please enter nominee's mobile no.";
                      }
                      return null;
                    },
                    hinttext: "Nominee Mobile")
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0.h, right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const  EdgeInsets.only(bottom :8.0),
                  child: comman().txt(text: 'Email Of nominee(Optional):', size: 12.sp),
                ),
                comman().textformfield(
                   initialValue: globle.email1,
                    onchange: (value) {
                      setState(() {
                        globle.email1 = value.toString();
                      });
                   //   final email = storage.write('_email1', _email1.text);
                    },
                    textinputtype: TextInputType.emailAddress,
                    hinttext: "Nominee email",
                    validator: (value) {
                      var email = isEmailValid(globle.email1);
                      if (email == false) {
                        return "please enter your valid email id";
                      }
                      return null;
                    })
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0.h, right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom :8.0),
                  child: comman().txt(text: 'Date Of Birth Nominee:', size: 12.sp),
                ),
                TextFormField(
                  style: TextStyle(
                      color: txt_color1,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Gotham",
                      fontSize: 12.sp),
                  enabled: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please select your birth date";
                    }
                    return null;
                  },
                  onChanged: (value) {
               
                  },
                 controller: _date1,
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.all(10.r),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfield_color,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfield_color,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfield_color,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    hintText: "Select Date",
                    hintStyle: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: 12.sp,
                        color: textfield_color),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Icon(Icons.calendar_today,
                          color: theme_color, size: 18.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const  EdgeInsets.only(bottom :8.0),
                child: comman().txt(text: 'Proof:', size: 12.sp),
              ),
              DropdownButtonFormField<String>(
                style: TextStyle(
                    color: txt_color1,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Gotham",
                    fontSize: 12.sp),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return " Please select proof:";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.all(10.r),
                  border: OutlineInputBorder(
                    
                      borderSide: BorderSide(
                        color: textfield_color,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfield_color,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: textfield_color,
                    ),
                    borderRadius: const BorderRadius.all(
                     Radius.circular(100)
                    ),
                  ),
                  hintText: '--Select proof--',
                  hintStyle: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: "Gotham",
                      color: textfield_color),
                ),
                value: globle.proof1,
                onChanged: (String? newValue) {
                  setState(() {
                    globle.proof1 = newValue;
                   // globle.proof1 = _proof.toString();
                //    final proof = storage.write('prrof', _proof);
                    // print(_currentSelectedValue1);
                  });
                },
                items: _proofname.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0.h, right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const  EdgeInsets.only(bottom :8.0),
                  child: comman().txt(text: 'Enter Selceted Proof Number:', size: 12.sp),
                ),
                comman().textformfield(
                  initialValue: globle.proofnumber1.toString(),
                  hinttext: "Enter Aadhar / PAN Number",
                   validator: (value) {
                    final proofnmuber = isValidPAN(globle.proofnumber1.toUpperCase());
                    if (value!.isEmpty) {
                      return "Please enter proof number";
                    } else if (globle.proof1 == "PAN card" &&
                        proofnmuber == false) {
                      return "Please enter Valid PAN number";
                    } else if (globle.proof1 == "Aadhar Card" &&
                        value.length != 16) {
                      return "Please enter Valid Aadhar number";
                    }
                    return null;
                  },
                  onchange: (value) {
                    setState(() {
                      globle.proofnumber1 = value.toString();
                    });
              
                  },
                  textinputtype: globle.proof1 == "Aadhar Card"
                      ? TextInputType.number
                      :  TextInputType.multiline,
                  textlength: [
                    globle.proof1 == "PAN card"
                        ? LengthLimitingTextInputFormatter(10)
                        : LengthLimitingTextInputFormatter(16)
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0.h, right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const  EdgeInsets.only(bottom :8.0),
                  child: comman().txt(text: 'Proof Of (Identity) (*):', size: 12.sp),
                ),
                TextFormField(
                  onChanged: (value) {},
                  style: TextStyle(
                      color: txt_color1,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Gotham",
                      fontSize: 12.sp),
                  controller: TextEditingController(text:globle.nominee1_Path.toString()  ),
                  enabled: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please choose your Proof/File";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.all(10.r),
                    prefixIcon: InkWell(
                        onTap: () {
                          nominee1_proofupload();
                        },
                        child: Icon(
                          Icons.attach_file,
                          color: Colors.black,
                          size: 18.sp,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textfield_color),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfield_color,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfield_color,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    hintText: "No file Chosen",
                    hintStyle: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: 12.sp,
                        color: textfield_color),
                  ),
                  readOnly: true,
                ),
                comman().txt(
                    text: 'Note: Only JPG/JPEG/PNG/ Max : 5MB', size: 12.sp),
              ],
            ),
          ),
        ],
      ),
    );
    //       );
    // });
  }
}
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
 // final TextEditingController _name1 = TextEditingController();
  // final TextEditingController _share1 = TextEditingController();
  // final TextEditingController _add1_1 = TextEditingController();
  // final TextEditingController _add2_1 = TextEditingController();
  // final TextEditingController _add3_1 = TextEditingController();
  // final TextEditingController _city1 = TextEditingController();
  // final TextEditingController _pincode1 = TextEditingController();
  // final TextEditingController _country1 = TextEditingController(text: "INDIA");
  // final TextEditingController _mobile1 = TextEditingController();
  // final TextEditingController _email1 = TextEditingController();
  // final TextEditingController _proofnumber1 = TextEditingController();
 
 