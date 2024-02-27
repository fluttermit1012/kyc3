
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_kyc_3/common/common.dart';


import 'package:new_kyc_3/d_o_b_/d_o_b.dart';
import 'package:new_kyc_3/main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:async';

class otp_page extends StatefulWidget {
  @override
  State<otp_page> createState() => _otp_pageState();
}
class _otp_pageState extends State<otp_page> {
   bool isOtpVerified = false;
  final formkey = GlobalKey<FormState>();
  final TextEditingController _otp1 = TextEditingController();
  final TextEditingController _otp2 = TextEditingController();
  String otp1 = "";
  String otp2 = "";
  

 
 int mobileOTPTimerSeconds = 60;
  int emailOTPTimerSeconds = 60;
  late Timer mobileOTPTimer;
  late Timer emailOTPTimer;

  @override
  void initState() {
    super.initState();
    startTimers();
  }

  @override
  void dispose() {
    mobileOTPTimer.cancel();
    emailOTPTimer.cancel();
    super.dispose();
  }

void startTimers() {
  mobileOTPTimer = Timer.periodic(Duration(seconds: 1), (timer) {
    setState(() {
      if (mobileOTPTimerSeconds > 0) {
        mobileOTPTimerSeconds--;
      } else {
        timer.cancel();
        // Automatically navigate back after the mobile OTP timer expires
         if (mounted) {
          if (emailOTPTimerSeconds <= 0) {
           if (mounted && !isOtpVerified) {
          Navigator.pop(context);
        }
          }
        }
      }
    });
  });



    emailOTPTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (emailOTPTimerSeconds > 0) {
          emailOTPTimerSeconds--;
       } else {
        timer.cancel();
        // Automatically navigate back after the mobile OTP timer expires
       
      }
      });
    });
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true, elevation: 0,
        backgroundColor: Colors.transparent,
        title:
        Container(
              height: 50,
              width: 200,
              child: Image.asset(
                'assets/logo6.png',
              )),
      ),
      body:
       SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.h,
            ),
            SizedBox(
              height: 130.h,
              width: 140.w,
              child: Image.asset('assets/otp.png'),
            ),
            SizedBox(
              height: 15.h,
            ),
            comman().txt(text: 'Verified OTP', size: 18.sp),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.all(18.0.r),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: 20.0.w, left: 20.w, bottom: 10.h),
                      child: comman().txt(text: 'verify Email OTP', size: 12.sp),
                    ),
                    Center(
                      child: SizedBox(
                        width: 450.w,
                        child: PinCodeTextField(
                          enableActiveFill: false,
                          enablePinAutofill: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a valid OTP";
                            }
                            return null;
                          },
                      
                          appContext: context,
                          keyboardType: TextInputType.number,
                          length: 6,
                          animationType: AnimationType.none,
                          cursorColor: textfield_color,
                          controller: _otp1,
                          onChanged: (value) {
                            setState(() {
                              otp1 = value;
                            });
                          },
                          pinTheme: PinTheme(
                            borderWidth: 0.3,
                            shape: PinCodeFieldShape.box,
                            selectedColor: theme_color,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 40.h,
                            fieldWidth: 40.w,
                            inactiveColor: textfield_color,
                            activeColor: textfield_color,
                          ),
                        ),
                      ),
                    ),
                     Padding(
                      padding:  EdgeInsets.all(2.0.r),
                      child: Align(alignment: Alignment.centerRight,
                      child: comman().txt(text: '$emailOTPTimerSeconds  seconds remaining', size: 12.sp),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 20.0.w, left: 20.w, bottom: 10.h),
                      child: comman().txt(text: 'verify Mobile OTP', size: 12.sp),
                    ),
                    Center(
                      child: SizedBox(
                        width: 450.w,
                        child: PinCodeTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a valid OTP";
                            }
                            return null;
                          },
                         
                          appContext: context,
                          keyboardType: TextInputType.number,
                          length: 6,
                          animationType: AnimationType.none,
                          cursorColor: textfield_color,
                          controller: _otp2,
                          onChanged: (value) {
                            setState(() {
                              otp2 = value;
                            });
                          },
                          pinTheme: PinTheme(
                            borderWidth: 0.3,
                            shape: PinCodeFieldShape.box,
                            selectedColor: theme_color,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 40.h,
                            fieldWidth: 40.w,
                            inactiveColor: textfield_color,
                            activeColor: textfield_color,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.all(4.0.r),
                      child: Align(alignment: Alignment.centerRight,
                      child: comman().txt(text: '$mobileOTPTimerSeconds seconds remaining', size: 12.sp),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  if (formkey.currentState!.validate()) {
                    _verifyOTP();
                  }
                },
                child: Container(
                  height: 40.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15.0,
                        spreadRadius: 5.0,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                    color: txt_color2,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(100),
                      bottomLeft: Radius.circular(100),
                    ),
                    border: Border.all(width: 1, color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      'Verify',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: 'Gotham',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  // void _verifyOTP() {
  //   final emailOTP = storage.read('email_otp').toString();
  //   final mobileOTP = storage.read('mobile_otp').toString();
  //   print("aaaaa$emailOTP");
  //   if (_otp1.text == emailOTP && _otp2.text == mobileOTP) {
  //   print('OTP verify successfully!');
  //     // showDialog(
  //     //   context: context,
  //     //   builder: (context) {
  //     //     Future.delayed(const Duration(seconds: 2), () {
  //     //       // Navigator.of(context).pop(true);
  //     //        Navigator.push(
  //     //             context,
  //     //             MaterialPageRoute(
  //     //               builder: (context) => verify_pan(),
  //     //             ));
  //     //     });
  //     //       // storage.remove('email_otp');
  //     //       // storage.remove('mobile_otp');
  //     //       // setState(() {
  //     //       //   _signup == true;
  //     //       // });
  //     //     return  AlertDialog(
  //     //       title: Text('OK'),
  //     //       content: Text('OTP Verified Successfully!'),
  //     //     );          
  //     //   },
  //     // );
  //      ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(
  //             behavior: SnackBarBehavior.floating,
  //             duration: Duration(seconds: 2),
  //             content: Text('Otp iS Success'),
  //             backgroundColor: Colors.green,
  //           ))
  //           .closed
  //           .then((reason) {
  //         if (reason == SnackBarClosedReason.action) {
  //           // Handle the action, if any
  //         } else {
  //           // Navigate to a new screen after the SnackBar is closed
  //           Navigator.of(context).push(MaterialPageRoute(
  //             builder: (context) {
  //               return verify_pan();
  //         }
  //           ));
  //         }
  //       });
  //     // .then((value) {
  //     //   Navigator.push(
  //     //     context,
  //     //     MaterialPageRoute(
  //     //       builder: (context) => const verify_pan(),
  //     //     ),
  //     //   );
  //   // }
  //     // );
  void _verifyOTP() {
    final emailOTP = storage.read('email_otp').toString();
    final mobileOTP = storage.read('mobile_otp').toString();

    if (_otp1.text == emailOTP && _otp2.text == mobileOTP) {
      setState(() {
        isOtpVerified = true; // Set flag to true on successful OTP verification
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          content: Text('Otp is Success'),
          backgroundColor: Colors.green,
        ),
      ).closed.then((reason) {
        if (reason != SnackBarClosedReason.action) {
          // Navigate to verify_pan() page only if the timer hasn't expired
          // if (mounted && !isOtpVerified) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => d_o_b(),
              ),
            );
          // }
        }
      });
    } else {
      // If OTP verification fails, show an alert
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return const AlertDialog(
            title: Text('Alert'),
            content: Text('Please Try Again!'),
          );
        },
      );
    }
  }
}