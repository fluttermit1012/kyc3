import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:new_kyc_3/main.dart';


import 'package:new_kyc_3/personal_page/finall_personal_details.dart';
import 'package:new_kyc_3/personaldetails_.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class pancard_otp extends StatefulWidget {
  const pancard_otp({super.key});

  @override
  State<pancard_otp> createState() => _pancard_otpState();
}

class _pancard_otpState extends State<pancard_otp> {
  String currentText = "";
  bool validateOTP(String otp) {
    // Add your OTP validation logic here.
    // Return true if the OTP is valid, otherwise return false.
    // You can compare 'otp' with the expected OTP.
    // For example:
    return otp ==
        storage
            .read('pancard_otp')
            .toString(); // Replace with your actual OTP validation logic.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 /
                    9, // Adjust this ratio according to your image's aspect ratio
                child: Image.asset('assets/password.png'),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'OTP Verified',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 4, 78, 73)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 8, top: 10),
                    child: Text('Enter Mobile Otp', textAlign: TextAlign.start),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, bottom: 8, top: 10),
                child: PinCodeTextField(
                  cursorColor: Color.fromARGB(195, 4, 78, 73),
                  keyboardType: TextInputType.number,
                  appContext: context,
                  // animationCurve: Curves.linear,
                  autoFocus: true,
                  length: 6, // Length of the Otp
                  onChanged: (value) {
                    setState(() {
                      currentText = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async{
                  if (validateOTP(currentText)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text("OTP successfully verified."),
                        backgroundColor: Colors
                            .green, // You can customize the background color.
                      )
                      ).closed.then((reason) {
        if (reason != SnackBarClosedReason.action) {
          // Navigate to verify_pan() page only if the timer hasn't expired
          // if (mounted && !isOtpVerified) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => fin_personal_details(),
              ),
            );
        }});
                    
                  } else {
                    // Handle invalid OTP, e.g., show an error message.
                    // You can display a SnackBar or show an AlertDialog.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(  backgroundColor: Colors
                            .red,
                        duration: Duration(seconds: 2),
                        content: Text("Invalid OTP. Please try again."),
                      ),
                    );
                  }
                },
                child: Text("Verify OTP"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(195, 4, 78, 73)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          90.0), // Adjust the radius as needed
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80),
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
    );
  }
}
