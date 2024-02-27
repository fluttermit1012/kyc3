import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:new_kyc_3/main.dart';
import 'package:new_kyc_3/mob_email_otp/new_otp.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:new_kyc_3/pancard/pancard.dart';

class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Gotham",
                    ),
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

  String email = '';
  String mobile = '';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _sign_up_mail_id_Controller =
      TextEditingController();

  final TextEditingController _sign_up_mobile_Controller =
      TextEditingController();
  bool isValidEmail(String email) {
    // Regular expression pattern for a valid email address
    final emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    final regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  Future<void> loginuser() async {
    _isLoading = true;
    _showLoadingDialog();
    String email = _sign_up_mail_id_Controller.text;
    String mobile = _sign_up_mobile_Controller.text;
    Map<String, String> data = {
      'sign_up_mail_id': email,
      'sign_up_mobile': mobile,
      'refferal': 'Main',
    };

    // Make the API request
    Uri url = Uri.parse('http://connect.arhamshare.com:9090/EAPI/signUP');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: data,
    );

    if (response.statusCode == 200) {
      _hideLoadingDialog();
      // Request successful, parse the response

      final responseData = response.body;
      final responseData1 = jsonDecode(response.body)["email_OTP"];
      final responseData2 = jsonDecode(response.body)["mobile_OTP"];
      // Handle the received data here
      print('+++++++++++$responseData');
      print("(email)$responseData1");
      print("(mobile)$responseData2");
      storage.write('email_otp', responseData1);
      storage.write('mobile_otp', responseData2);
      _hideLoadingDialog();
      if (responseData == "404") {
        // print('Request failed with status: ${response.statusCode}');
        // showDialog(
        //     context: context,
        //     builder: (context) {
        //       Future.delayed(Duration(seconds: 2), () {
        //         Navigator.of(context).pop(true);
        //       });
        //       return AlertDialog(
        //         title: Text('Invalid Credential'),
        //         content: Text('Please Try Again.!'),
        //       );
        //     });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
            content: Text(
              'Invalid Credential',
              style: TextStyle(
                fontFamily: "Gotham",
              ),
            )));
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              content: Text(
                'Successfully Login',
                style: TextStyle(
                  fontFamily: "Gotham",
                ),
              )))
          .closed
          .then((reason) {
        if (reason != SnackBarClosedReason.action) {
          // Navigate to verify_pan() page only if the timer hasn't expired
          // if (mounted && !isOtpVerified) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => otp_page(),
            ),
          );
          // }
        }
      });
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       Future.delayed(Duration(seconds: 2), () {
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => otp_page(),
      //             ));
      //       });
      //       return AlertDialog(
      //         title: Center(
      //           child: Column(
      //             children: [
      //               SpinKitWave(
      //                   color: Color.fromARGB(194, 4, 78, 73), size: 20.0),
      //               Text('Success'),
      //             ],
      //           ),
      //         ),
      //         content: Text('Welcome To ArhamShare.'),
      //       );
      //     });
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => intro2page(),
      //     ));
    }
  }
  //  else {
  //   // Request failed, handle the error
  //   print('Request failed with status: ${response.statusCode}');
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text('Invalid Credential ')));
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    var container = Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(children: [
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.04,
                    right: screenWidth * 0.04,
                    bottom: screenHeight * 0.006,
                    top: screenHeight * 0.01),
                child: Text(
                  "Email ID",
                  textAlign: TextAlign.start,
                ),
              ),
            ]),
            TextFormField(
              controller: _sign_up_mail_id_Controller,
              onChanged: (value) {
                email = value;
              },
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Your Email Id';
                } else if (!isValidEmail(value)) {
                  return 'Please Enter a Valid Email';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Enter Your Email Id',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.black),
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
              ),
              cursorColor: Colors.black,
            ),
            SizedBox(height: screenHeight * 0.016),
            Row(children: [
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.04,
                    right: screenWidth * 0.04,
                    bottom: screenHeight * 0.006,
                    top: screenHeight * 0.01),
                child: Text(
                  "Mobile Number",
                  textAlign: TextAlign.start,
                ),
              ),
            ]),
            TextFormField(
              controller: _sign_up_mobile_Controller,
              onChanged: (value) {
                mobile = value;
              },
              keyboardType: TextInputType.number,
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Your Mobile Number';
                } else if (value.length != 10) {
                  return 'Mobile number must be 10 digits';
                } else {
                  return null;
                }
              },
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Enter Your Mobile Number',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.black),
                ),
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
              ),
              cursorColor: Colors.black,
            ),
            SizedBox(height: screenHeight * 0.019),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  loginuser();
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return otp();
                  //     },
                  //   ),
                  // );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 4, 78, 73),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: screenWidth * 0.028),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          height: screenHeight * 0.1,
          width: screenWidth * 0.4,
          child: Image.asset(
            'assets/logo6.png',
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: screenHeight * 0.01,
              ),
              AspectRatio(
                aspectRatio: 16 /
                    8, // Adjust this ratio according to your image's aspect ratio
                child: Image.asset('assets/otp.png'),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Text(
                'Sign Up To ArhamShare',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenHeight * 0.025,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: container,
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Do You Already Have An Account",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return pancardd();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Color.fromARGB(255, 4, 78, 73)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
              Text(
                'Powered by ARHAMSHARE Pvt Ltd.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.02,
                  color: Color.fromARGB(255, 4, 78, 73),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
