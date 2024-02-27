// ignore_for_file: non_constant_identifier_names, camel_case_types, prefer_final_fields, unused_field

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Color txt_color1 = Colors.black;
Color txt_color2 = const Color(0xff073935);
Color theme_color = const Color(0xff073935);
Color button_color = const Color(0xff073935);
Color textfield_color = Colors.black54;

class globle{
static String mother = "";
static  String education = "";
static String father = "";
static String  aadharr = "";
static String mobile = "";
static String MaritalStatus = "";
static String nationality = "";
static String annual_incm = "";
static String tax_residencyy = "";
static String email = "";
static String? trading_experince ;
static String? occuptionn;
static String political_exposed = "";
static String ac_op_mode = "";
static String nominee = "";
static bool? forn ;
static String nominee1_Path = ''; 
static String nominee2_Path = ''; 
static String nominee3_Path = '';
static File? nominee_1_ImageFile;
static File? nominee_2_ImageFile;
static File? nominee_3_ImageFile;
static String  name1 = "";
static String  share1 = ""; 
static String? relation1 ;
static String  add1_1 = "";
static String  add2_1 = "";
static String  add3_1 = "";
static String  city1 = "";
static String? state1 ;
static String  pincode1 = "";
static String  country1 = "INDIA";
static String  mobile1 = "";
static String  email1 = "";
static String? proof1 ;
static String  proofnumber1 = "";
static String  date1 = "";
static String  name2 = "";
static String  share2 = ""; 
static String?  relation2 ;
static String  add1_2 = "";
static String  add2_2 = "";
static String  add3_2 = "";
static String  city2 = "";
static String?  state2 ;
static String  pincode2 = "";
static String  country2 = "INDIA";
static String  mobile2 = "";
static String  email2 = "";
static String? proof2;
static String  proofnumber2 = "";
static String  date2 = "";
static String  name3 = "";
static String  share3 = ""; 
static String?  relation3;
static String  add1_3 = "";
static String  add2_3 = "";
static String  add3_3 = "";
static String  city3 = "";
static String?  state3 ;
static String  pincode3 = "";
static String  country3 = "INDIA";
static String  mobile3 = "";
static String  email3 = "";
static String? proof3 ;
static String  proofnumber3 = "";
static String  date3 = "";
static String pancard_dob='';
}

class comman {
  Widget txt({
    required String text,
    double? size,
    TextAlign? align,
  }) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontSize: size,
          color: txt_color1,
        //  fontWeight: FontWeight.w600,
          fontFamily: "Gotham"),
    );
  }

  Widget icon({required IconData? icon}) {
    return Icon(
      icon,
      color: button_color,
      size: 18.sp,
    );
  }

  Widget textformfield({
    String? hinttext,
    String? lebeltext,
    TextEditingController? controller,
    String? Function(String?)? validator,
    List<TextInputFormatter>? textlength,
    TextInputType? textinputtype,
    Function(String)? onchange,
    Widget? perfixicon,
    String? initialValue,
    bool? enabled,
    int? maxleanth,
  }) {
    return TextFormField(
      maxLength: maxleanth,
      initialValue: initialValue,
      style: TextStyle(
          fontSize: 12.sp,
        //  fontWeight: FontWeight.w600,
          fontFamily: "Gotham",
          color: txt_color1),
      controller: controller,
      enabled: enabled,
      inputFormatters: textlength,
      keyboardType: textinputtype,
      validator: validator,
      onChanged: onchange,
      decoration: InputDecoration(
        contentPadding:  EdgeInsets.all(10.r),
        prefixIcon: perfixicon,
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
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: textfield_color,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        hintText: hinttext,
        hintStyle: TextStyle(
            fontSize: 12.sp, fontFamily: 'Gotham', color: textfield_color),
        labelText: lebeltext,
        labelStyle: TextStyle(
            fontSize: 12.sp, fontFamily: 'Gotham', color: textfield_color),
      ),
    );
  }
}

class alert {
  Widget alertdialog({
    String? title,
    String? content,
  }) {
    return AlertDialog(
      title: Text(
        title!,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 15.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
      content: Padding(
        padding: EdgeInsets.all(2.0.r),
        child: Text(
          content!,
          style: TextStyle(
            fontSize: 13..sp,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _fornomination{
  
}

class _fornominee{
  String _nominee1 = "";
String _share1 = "";
String _relation1 = "";
String _add1_1 = "";
String _add1_2 = "";
String _add1_3 = "";
String _city1 = "";
String _pincode1 ="";
String _country1 = "";
String _mobile1 = "";
String _email1 = "";
String _proofnumber1 = "";
String _date1 = "";
String _nominee2 = "";
String _share2 = "";
String _relation2 = "";
String _add2_1 = "";
String _add2_2 = "";
String _add2_3 = "";
String _city2 = "";
String _pincode2 ="";
String _country2 = "";
String _mobile2 = "";
String _email2 = "";
String _proofnumber2 = "";
String _date2 = "";
String _nominee3 = "";
String _share3 = "";
String _relation3 = "";
String _add3_1 = "";
String _add3_2 = "";
String _add3_3 = "";
String _city3 = "";
String _pincode3 ="";
String _country3 = "";
String _mobile3 = "";
String _email3 = "";
String _proofnumber3 = "";
String _date3 = "";
}




// class SlideAnimationTextField extends StatefulWidget {
//   final AnimationController controller;
//   final String label;
//   final TextEditingController controllerText;
//   final void Function(String)? onChanged; // Callback for onChanged event

//   SlideAnimationTextField({
//     required this.controller,
//     required this.label,
//     required this.controllerText,
//     this.onChanged,
//   });

//   @override
//   _SlideAnimationTextFieldState createState() => _SlideAnimationTextFieldState();
// }

// class _SlideAnimationTextFieldState extends State<SlideAnimationTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: widget.controller,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset(
//             widget.controller.value * (MediaQuery.of(context).size.width - 100),
//             0,
//           ),
//           child: Padding(
//             padding: EdgeInsets.only(top: 12.0, bottom: 5, right: 20),
//             child: TextFormField(
//               controller: widget.controllerText,
//               enabled: true,
//               onChanged: widget.onChanged, // Pass the onChanged callback
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "Enter ${widget.label}";
//                 }
//                 return null;
//               },
//               decoration: InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(width: 1),
//                   borderRadius: const BorderRadius.only(
//                     bottomRight: Radius.circular(100),
//                     topRight: Radius.circular(100),
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(width: 1),
//                   borderRadius: const BorderRadius.only(
//                     bottomRight: Radius.circular(100),
//                     topRight: Radius.circular(100),
//                   ),
//                 ),
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(width: 1),
//                   borderRadius: const BorderRadius.only(
//                     bottomRight: Radius.circular(100),
//                     topRight: Radius.circular(100),
//                   ),
//                 ),
//                 hintText: "Enter ${widget.label}",
//                 hintStyle: TextStyle(
//                   fontSize: 12,
//                   fontFamily: 'Gotham',
//                 ),
//                 labelText: widget.label,
//                 labelStyle: TextStyle(
//                   fontSize: 12,
//                   fontFamily: 'Gotham',
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }