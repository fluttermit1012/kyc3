// ignore_for_file: camel_case_types, unused_field, no_leading_underscores_for_local_identifiers, unused_local_variable, non_constant_identifier_names
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_kyc_3/common/common.dart';

final GlobalKey<FormState> formkey2 = GlobalKey<FormState>();

class nominee2 extends StatefulWidget {
  const nominee2({super.key});
  @override
  State<nominee2> createState() => _nominee2State();
}

class _nominee2State extends State<nominee2> { 

   final TextEditingController _date2 = TextEditingController();
 @override
 void initState() {
   _date2.text = globle.date2;
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
  final List<String> _proofname2 = ["Aadhar Card", "PAN card"];
   bool _checkbox2 = false;
  // String? _relation_2;
  // String? state;
  // String? _proof2;
  List formgroups = [];
  int _currentindex = 0;
  DateTime? _selectedDate;


// File? nominee_2_ImageFile;
//  String nominee2_Path = '';
Future<void> nominee2_proofupload() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg' ],
  );

  if (result != null) {
    String? fileName = result.files.single.name;
    final filePath = result.files.single.path;
    if (filePath != null && filePath.isNotEmpty) {
  setState(() {
  globle.nominee2_Path = filePath.split('/').last; // Set the file name only
    globle.nominee_2_ImageFile = File(filePath);
   
  });
  // await storage.write('nominee_2_Path', nominee2_Path);
  // await  storage.write('nominee_2_ImageFile', nominee_2_ImageFile!.path);
}

  }
}

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: theme_color, // Set the color of the header
              // Set the color of the selected date
              colorScheme: ColorScheme.light(primary: theme_color),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        }))! ;

    if (picked != _selectedDate) {
      //picked != null &&
      setState(() {
        _selectedDate = picked;

       globle.date2 = picked.toLocal().toString().split(' ')[0];
       _date2.text = globle.date2;
        //  storage.write('_date2', _date2.text);
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

  void nextPage() {
    if (_currentindex < formgroups.length - 1) {
      setState(() {
        _currentindex++;
      });
    } else {
      "Please fill up all details of Nominee 1";
    }
  }

  @override
  void dispose() {
  //  _date2.dispose();

    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
   
        Form(
      key: formkey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8.h,
          ),
          comman().txt(text: 'Details Of Nominee 2:', size: 15.sp),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.0.h, right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom :8.0),
                  child: comman().txt(text: 'Name of nominee: 2', size: 12.sp),
                ),
                comman().textformfield(
                  onchange: (value) {
                    setState(() {
                      globle.name2 =value.toString();
                    });
                  //  storage.write('_name2', _name2.text);
                  },
                 initialValue: globle.name2.toString(),
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
                  padding: const  EdgeInsets.only(bottom :8.0),
                  child: comman().txt(
                      text: 'Share of each nominee in(%)and not more than 100%',
                      size: 11.sp),
                ),
                comman().textformfield(
                    onchange: (value) {
                      setState(() {
                        globle.share2 = value.toString();
                      });
                    //  final share = storage.write('_share1', _share1.text);
                    },
                    initialValue: globle.share2,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a number between 1 and 100";
                      }
                      final int? number = int.tryParse(value);
                      if (number == null || number < 1 || number > 100) {
                        return "Enter a valid  percentage between 1 and 100";
                      }
                      return null;
                    },
                    textlength: [LengthLimitingTextInputFormatter(3)],
                    hinttext: "Share Of Each Nominee",
                    textinputtype: TextInputType.number),
              ],
            ),
          ),

          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.w, bottom: 8),
            child: comman().txt(text: 'Relation With Application', size: 12.sp),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.w),
            child: DropdownButtonFormField<String>(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Select Your Relation";
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding:
                     EdgeInsets.all(10.r),
                hintText: '--Select Relation--',
                hintStyle: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: "Gotham",
                    color: textfield_color),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: textfield_color,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: textfield_color,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
              ),
              value: globle.relation2,
              onChanged: (String? newValue) {
                setState(() {
                  globle.relation2 = newValue.toString();
               //  final _relation2_= storage.write('relation_2',_relation_2 );
                  // print(_currentSelectedValue1);
                });
              },
              items: _relation.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
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
                  setState(() {});
                  _checkbox2 = value!;
                },
              ),
              comman().txt(
                  text: '''nominee address same as a my address''',
                  size: 12.sp),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0.h, right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const  EdgeInsets.only(bottom :8.0),
                  child: comman().txt(text: 'Address 1:', size: 12.sp),
                ),
                comman().textformfield(
                    onchange: (value) {
                      setState(() {
                        globle.add1_2 = value.toString();
                      });
                  //  storage.write('_add1_2', _add1_2.text);
                  },
                  hinttext: "Address 1",
                 initialValue: globle.add1_2.toString(),
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
                  child: comman().txt(text: 'Address 2:', size: 12.sp),
                ),
                comman().textformfield(
                    onchange: (value) {
                      setState(() {
                        globle.add2_2 = value.toString();
                      });
                   // storage.write('_add2_2', _add2_2.text);
                  },
                  hinttext: "Address 2",
                 initialValue: globle.add2_2.toString(),
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom :8.0),
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
                    onchange: (value) {
                      setState(() {
                        globle.add3_2 = value.toString();
                      });
                   // storage.write('_add3_2', _add3_2.text);
                  },
                  hinttext: "Address 1",
                  initialValue: globle.add3_2.toString(),
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
                  padding: const EdgeInsets.only(bottom :8.0),
                  child: comman().txt(text: 'City:', size: 12.sp),
                ),
                comman().textformfield(
                    onchange: (value) {
                      setState(() {
                        setState(() {
                          globle.city2 = value.toString();
                        });
                      });
                   // storage.write('_city2', _city2.text);
                  },
                  initialValue: globle.city2.toString(),
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
                        globle.pincode2 = value.toString();
                      });
                    //storage.write('_pincode2', _pincode2.text);
                  },
                   initialValue: globle.pincode2.toString(),
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
            padding:EdgeInsets.only(top: 12.0.h, right: 20.w, left: 20.w,bottom: 8),
            child: comman().txt(text: 'State:', size: 12.sp),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.w),
            child: DropdownButtonFormField<String>(
              style: TextStyle(
                  color: txt_color1,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Gotham",
                  fontSize: 12.sp),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return " Please select your state";
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding:
                     EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                hintText: '--Select State--',
                hintStyle: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: "Gotham",
                    color: textfield_color),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: textfield_color,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: textfield_color,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
              ),
              value: globle.state2,
              onChanged: (String? newValue) {
                setState(() {
                  globle.state2 = newValue.toString();
               // final state2_ =   storage.write('_state2', state);
                  // print(_currentSelectedValue1);
                });
              },
              items: _states.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
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
                        globle.country2 = value.toString();
                      });
                  //  storage.write('_country2', _country2.text);
                  },
                  initialValue: globle.country2.toString(),
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
                  padding: const  EdgeInsets.only(bottom :8.0),
                  child: comman()
                      .txt(text: 'Mobile No Of Nominee(Optional):', size: 12.sp),
                ),
                comman().textformfield(
                    onchange: (value) {
                      setState(() {
                        globle.mobile2 = value.toString();
                      });
                   // storage.write('_mobile2', _mobile2.text);
                  },
                   initialValue: globle.mobile2.toString(),
                    textinputtype: TextInputType.number,
                    textlength: [LengthLimitingTextInputFormatter(10)],
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

                    onchange: (value) {
                      setState(() {
                        globle.email2 = value.toString();
                      });
                   // storage.write('_email2', _email2.text);
                  },
                   initialValue: globle.email2.toString(),
                    textinputtype: TextInputType.emailAddress,
                    hinttext: "Nominee email",
                    validator: (value) {
                      var email = isEmailValid(globle.email2);
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
                  padding: const  EdgeInsets.only(bottom :8.0),
                  child: comman().txt(text: 'Date Of Birth Nominee:', size: 12.sp),
                ),
                TextFormField(
                    onChanged: (value) {
                  //  storage.write('_date2', _date2);
                  },
                  style: TextStyle(
                      color: txt_color1,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Gotham",
                      fontSize: 12.sp),
                  enabled: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please select Your birth date";
                    }
                    return null;
                  },
                  controller: _date2,
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
                        borderSide: BorderSide(color: textfield_color),
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
                      onTap: () => _selectDate(context),
                      child: Icon(Icons.calendar_today,
                          color: theme_color, size: 18.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding:  EdgeInsets.only(top: 12.0.h, right: 20.w, left: 20.w,bottom: 8),
            child: comman().txt(text: 'Proof:', size: 12.sp),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.w),
            child: DropdownButtonFormField<String>(
              style: TextStyle(
                  color: txt_color1,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Gotham",
                  fontSize: 12.sp),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select proof:";
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding:
                     EdgeInsets.all(10.r),
                hintText: '--Select proof--',
                hintStyle: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: "Gotham",
                    color: textfield_color),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: textfield_color,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: textfield_color,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
              ),
              value: globle.proof2,
              onChanged: (String? newValue) {
                setState(() {
                   globle.proof2 = newValue.toString();
              // final proof2_ = storage.write('_proof2',_proof2 );
                 
                  // print(_currentSelectedValue1);
                });
              },
              items: _proofname2.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0.h, right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const  EdgeInsets.only(bottom :8.0),
                  child: comman().txt(text: 'Enter Selceted Proof Number:', size: 12.sp),
                ),
                comman().textformfield(
                    onchange: (value) {
                      setState(() {
                        globle.proofnumber2 = value.toString();
                      });
                  //  storage.write('_proofnumber2', _proofnumber2.text);
                  },
                 initialValue: globle.proofnumber2.toString(),
                  hinttext: "Enter Aadhar / PAN Number",
                  validator: (value) {
                    final proofnmuber = isValidPAN(globle.proofnumber2.toUpperCase());
                    if (value!.isEmpty) {
                      return "Please enter proof number";
                    } else if (globle.proof2 == "PAN card" &&
                        proofnmuber == false) {
                      return "Please enter Valid PAN number";
                    } else if (globle.proof2 == "Aadhar Card" &&
                        value.length != 16) {
                      return "Please enter Valid Aadhar number";
                    }
                    return null;
                  },
                  textinputtype: globle.proof2 == "Aadhar Card"
                      ? TextInputType.number
                      : TextInputType.multiline,
                  textlength: [
                    globle.proof2 == "PAN card"
                        ? LengthLimitingTextInputFormatter(10)
                        : LengthLimitingTextInputFormatter(16)
                  ],
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
                  child: comman().txt(text: 'Proof Of (Identity) (*):', size: 12.sp),
                ),
                TextFormField(
                  style: TextStyle(
                      color: txt_color1,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Gotham",
                      fontSize: 12.sp),
                   controller: TextEditingController(text:globle.nominee2_Path.toString()  ),
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
                          nominee2_proofupload();
                        },
                        child: Icon(
                          Icons.attach_file,
                          color: Colors.black,
                          size: 18.sp,
                        )),
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
                        borderSide: BorderSide(color: textfield_color),
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
 