import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_kyc_3/main.dart';
import 'package:new_kyc_3/pancard/pancard_otp.dart';



// import 'package:lottie/lottie.dart';

class pancardd extends StatefulWidget {
  const pancardd({Key? key});

  @override
  State<pancardd> createState() => _pancarddState();
}

class _pancarddState extends State<pancardd> {
  String pan = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _panCardController = TextEditingController();

  // TextEditingController _otpController = TextEditingController();
  // bool _showOtpField = false;

  String? _validatePANCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Your PAN Card Number';
    }
    if (value.length != 10) {
      return 'PAN Card Number should be 10 characters';
    }
    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
      return 'Invalid PAN Card';
    }
    return null;
  }

  // final TextEditingController _pancard_Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  AspectRatio(
                    aspectRatio: 16 /
                        9, // Adjust this ratio according to your image's aspect ratio
                    child: Image.asset('assets/pancard1.png'),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        child: Text(
                          'Pancard Verified',
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 8, top: 10),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      controller: _panCardController,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      keyboardType: TextInputType.text,
                      validator: (value) => _validatePANCard(value!),
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Enter Your PanCard Number',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        prefixIcon: Icon(
                          Icons.account_box_sharp,
                          color: Colors.black,
                        ),
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // PAN card validation is successful
                        // Now, check if the PAN card number is valid
                        if (_validatePANCard(
                                _panCardController.text.toUpperCase()) ==
                            null) {
                          verify();
                          // Valid PAN card, navigate to the OTP verification page
                        } else {
                          // PAN card is invalid, show an error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Invalid PAN Card'),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(195, 4, 78, 73),
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
                        'Sign In',
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  SizedBox(height: screenHeight * 0.05),
                  Text(
                    'Powered by ARHAMSHARE Pvt Ltd.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Color.fromARGB(255, 4, 78, 73),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verify() async {
    String pancard = _panCardController.text;
    Map<String, String> data = {
      'pan': pancard,
    };

    // Make the API request
    Uri url = Uri.parse('http://connect.arhamshare.com:9090/EAPI/signIN');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: data,
    );

    if (response.statusCode == 200) {
      // Request successful, parse the response

      final responseData = response.body;
      final responseData1 = jsonDecode(response.body)["pan_otp"];

      // Handle the received data here
      print(responseData);
      print("(pancard)$responseData1");
      storage.write('pancard_otp', responseData1);
      if (responseData == "404") {
        // print('Request failed with status: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                          content:
                              Text("OTP Not Successfully.. Please try again."),
                        ),
                      );
      } else {
          ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text("OTP successfully."),
                        backgroundColor: Colors
                            .green, // You can customize the background color.
                      ),
                      ).closed.then((reason) {
        if (reason != SnackBarClosedReason.action) {
          // Navigate to verify_pan() page only if the timer hasn't expired
          // if (mounted && !isOtpVerified) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pancard_otp(),
              ),
            );
          }
      });}
    }}}
      
                   
                    // Both OTPs are valid, navigate to the next screen.
      
  

