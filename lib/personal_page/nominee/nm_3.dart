// ignore_for_file: camel_case_types, unused_local_variable, unused_field, non_constant_identifier_names
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_kyc_3/common/common.dart';

final GlobalKey<FormState> formkey3 = GlobalKey<FormState>();

class nominee3 extends StatefulWidget {
  const nominee3({super.key});
  @override
  State<nominee3> createState() => _nominee3_State();
}

class _nominee3_State extends State<nominee3> {
  // final TextEditingController _name3 = TextEditingController();
  // final TextEditingController _share3 = TextEditingController();
  // final TextEditingController _add1_3 = TextEditingController();
  // final TextEditingController _add2_3 = TextEditingController();
  // final TextEditingController _add3_3 = TextEditingController();
  // final TextEditingController _city3 = TextEditingController();
  // final TextEditingController _pincode3 = TextEditingController();
  // final TextEditingController _country3 = TextEditingController(text: "INDIA");
  // final TextEditingController _mobile3 = TextEditingController();
  // final TextEditingController _email3 = TextEditingController();
  // final TextEditingController _proofnumber3 = TextEditingController();
   final TextEditingController _date3 = TextEditingController();
   @override
 void initState() {
  //  storage.write('_country3', _country3.text);
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
  File? _selectedFile3;
   bool _checkbox2 = false;
  // String? _relation3;
  // String? _state3;
  // String? _proof3;
  DateTime? _selectedDate;
  // Future<void> _pickFile3() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _selectedFile3 = File(pickedFile.path);
  //       _fileNameController3.text =
  //           _selectedFile3!.path.split('/').last; // Display the file name
  //     });
  //   }
  // }

// File? nominee_3_ImageFile;
//  String nominee3_Path = '';

Future<void> nominee3_proofupload() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg' ],
  );

  if (result != null) {
    String? fileName = result.files.single.name;
    final filePath = result.files.single.path;
    if (filePath != null && filePath.isNotEmpty) {
  setState(() {
   globle.nominee3_Path = filePath.split('/').last; // Set the file name only
    globle.nominee_3_ImageFile = File(filePath);
   
  });
  // await storage.write('nominee_3_Path', nominee3_Path);
  // await  storage.write('nominee_3_ImageFile', nominee_3_ImageFile!.path);
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
              primaryColor: theme_color,
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
        globle.date3= picked.toLocal().toString().split(' ')[0];
        _date3.text = globle.date3;
      //  storage.write('_date3', _date3.text);
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
  //  _date3.dispose();
 //   _fileNameController3.dispose();
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 20.0.r),
      child: Form(
        key: formkey3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
            ),
            comman().txt(text: 'Details Of Nominee 3:', size: 15.sp),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.0.h, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const  EdgeInsets.only(bottom :8.0),
                    child: comman().txt(text: 'Name of nominee: 3', size: 12.sp),
                  ),
                  comman().textformfield(
                    onchange: (value) {
                      setState(() {
                        globle.name3 = value.toString();
                      });
                   //   storage.write('_name3', _name3.text);
                    },
                   initialValue: globle.name3,
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
            Padding(
              padding: EdgeInsets.only(top: 12.0.h, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom :8.0),
                    child: comman().txt(
                        text: 'Share of each Nominee in(%)And not more than 100%',
                        size: 11.sp),
                  ),
                  comman().textformfield(
                       initialValue: globle.share3,
                      onchange: (value) {
                        setState(() {
                          globle.share3 = value.toString();
                        });
                       // storage.write('_share3', _share3.text);
                      },
                      textlength: [LengthLimitingTextInputFormatter(3)],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your share (%)";
                        }
                        final int? number = int.tryParse(value);
                        if (number == null || number < 1 || number > 100) {
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
              height: 10.h,
            ),
            Padding(
              padding: const  EdgeInsets.only(bottom :8.0),
              child: comman().txt(text: 'Relation With Application', size: 12.sp),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
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
                value: globle.relation3,
                onChanged: (String? newValue) {
                  setState(() {
                      globle.relation3 = newValue;
                 // final relation3_ =   storage.write('_relation3', _relation3);
                  
                   
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
              padding: EdgeInsets.only(top: 12.0.h, right: 20.w),
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
                        globle.add1_3 = value.toString();
                      });
                    //  storage.write('_add1_3', _add1_3.text);
                    },
                    hinttext: "Address 1",
                    initialValue: globle.add1_3,
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
              padding: EdgeInsets.only(top: 12.0.h, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom :8.0),
                    child: comman().txt(text: 'Address 2:', size: 12.sp),
                  ),
                  comman().textformfield(
                    hinttext: "Address 2",
                    onchange: (value) {
                      setState(() {
                        globle.add2_3 = value.toString();
                      });
                   //   storage.write('_add2_3', _add2_3.text);
                    },
                     initialValue: globle.add2_3,
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
              padding: EdgeInsets.only(top: 12.0.h, right: 20.w),
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
                    onchange: (value) {
                      setState(() {
                        globle.add3_3 = value.toString();
                      });
                   //   storage.write('_add3_3', _add3_3.text);
                    },
                    hinttext: "Address 3",
                     initialValue: globle.add3_3,
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
              padding: EdgeInsets.only(top: 12.0.h, right: 20.w),
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
                        globle.city3 = value.toString();
                      });
                    //  storage.write('_city3', _city3.text);
                    },
                    initialValue: globle.city3,
                    hinttext: "Enter City Name",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your city";
                      }
                      return null;
                    },
                  )
                  // ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0.h, right: 20.w),
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
                          globle.pincode3 = value.toString();
                        });
                       // storage.write('_pincode3', _pincode3.text);
                      },
                      initialValue: globle.pincode3,
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
              padding: const  EdgeInsets.only(bottom :8.0),
              child: comman().txt(text: 'State:', size: 12.sp),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0.w),
              child: DropdownButtonFormField<String>(
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
                value: globle.state3,
                onChanged: (String? newValue) {
                  setState(() {
                    globle.state3 = newValue;
                //  final state3_ =  storage.write('_state3', _state3);
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
              padding: EdgeInsets.only(top: 12.0.h, right: 20.w),
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
                        globle.country3 = value.toString();
                      });
                    //  storage.write('_country3', _country3.text);
                    },
                     initialValue: globle.country3,
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
              padding: EdgeInsets.only(top: 12.0.h, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom :8.0),
                    child: comman()
                        .txt(text: 'Mobile No Of Nominee(Optional):', size: 12.sp),
                  ),
                  comman().textformfield(
                      onchange: (value) {
                        setState(() {
                          globle.mobile3 =value.toString();
                        });
                     //   storage.write('_mobile3', _mobile3.text);
                      },
                       initialValue: globle.mobile3,
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
              padding: EdgeInsets.only(top: 12.0.h, right: 20.w),
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
                          globle.email3 = value.toString();
                        });
                      //  storage.write('_email3', _email3.text);
                      },
                      initialValue: globle.email3,
                      textinputtype: TextInputType.emailAddress,
                      hinttext: "Nominee email",
                      validator: (value) {
                        var email = isEmailValid(globle.email3);
                        if (email == false) {
                          return "please enter your valid email id";
                        }
                        return null;
                      })
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0.h, right: 20.w),
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
                        return "Please select Your birth date";
                      }
                      return null;
                    },
                    onChanged: (value) {
                    //  storage.write('_date3', _date3.text);
                    },
                    controller: _date3,
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
                          borderSide: BorderSide(color: textfield_color),
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
              padding: const EdgeInsets.only(bottom :8.0),
              child: comman().txt(text: 'Proof:', size: 12.sp),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0.w),
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
                value: globle.proof3,
                onChanged: (String? newValue) {
                  setState(() {
                    globle.proof3 = newValue;
                 // final proof3_ =  storage.write('_proof3', _proof3);
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
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0.h, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom :8.0),
                    child: comman().txt(text: 'Enter Selceted Proof Number:', size: 12.sp),
                  ),
                  comman().textformfield(
                    onchange: (value) {
                      setState(() {
                        globle.proofnumber3 = value.toString();
                      });
                    //  storage.write('_proofnumber3', _proofnumber3.text);
                    },
                    initialValue: globle.proofnumber3,
                    hinttext: "Enter Aadhar / PAN Number",
                    validator: (value) {
                      final proofnmuber = isValidPAN(globle.proofnumber3.toUpperCase());
                      if (value!.isEmpty) {
                        return "Please enter proof number";
                      } else if (globle.proof3 == "PAN card" && proofnmuber == false) {
                        return "Please enter Valid PAN number";
                      } else if (globle.proof3 == "Aadhar Card" && value.length != 16) {
                        return "Please enter Valid Aadhar number";
                      }
                      return null;
                    },
                     textinputtype: globle.proof3 == "Aadhar Card"
                        ? TextInputType.number
                        : TextInputType.multiline,
                    textlength: [
                      globle.proof3 == "PAN card"
                          ? LengthLimitingTextInputFormatter(10)
                          : LengthLimitingTextInputFormatter(16)
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0.h, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const  EdgeInsets.only(bottom :8.0),
                    child: comman().txt(text: 'Proof Of (Identity) (*):', size: 12.sp),
                  ),
                  TextFormField(
                    style: TextStyle(
                        color: txt_color1,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Gotham",
                        fontSize: 12.sp),

                      controller: TextEditingController(text:globle.nominee3_Path.toString()  ),
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
                            nominee3_proofupload();
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
      ),
    );

  }
}
