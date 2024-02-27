import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_kyc_3/common/common.dart';
import 'package:new_kyc_3/main.dart';

import 'package:http/http.dart' as http;
import 'package:new_kyc_3/pancard/pancard.dart';

class d_o_b extends StatefulWidget {
  const d_o_b({super.key});

  @override
  State<d_o_b> createState() => _d_o_bState();
}

class _d_o_bState extends State<d_o_b> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TextEditingController _panCardController = TextEditingController();
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

  Future<void> loginuser() async {
    String pancard = _panCardController.text;
    String date_of_birth = selectedDate.toString();

    Map<String, String> data = {
      'dob_pan_number': pancard,
      'dob': date_of_birth,
      'register_mail': storage.read('email_otp').toString(),
      'register_mobile_no': storage.read('mobile_otp').toString()
    };

    // Make the API request
    Uri url =
        Uri.parse('http://connect.arhamshare.com:9090/EAPI/PanVerification');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: data,
    );

    if (response.statusCode == 200) {
      // Request successful, parse the response

      final responseData = response.body;
      final responseData1 = jsonDecode(response.body)["As_Per_KRA_Name"];
      final respondeData2 = jsonDecode(response.body)['reason'];
      final error = jsonDecode(response.body)['errorCode'];
      // Handle the received data here
      print(responseData);
      print("(data)$responseData1");
      print("(reason)$respondeData2");
      print("(error)$error");
      storage.write('data', responseData1);
      storage.write('reason', respondeData2);
      storage.write('error1', error);
      storage.write('error2', error);
      storage.write('error3', error);
      storage.write('error4', error);
      if (responseData == "404") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid Credential ')));
      } else if (storage.read('error1') == "302") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            content: Text(storage.read('reason').toString())));
      } else if (storage.read('error3') == "403") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text(storage.read('reason').toString()),
            backgroundColor:
                Colors.red, // You can customize the background color.
          ),
        );
      } else if (storage.read('error2') == "200") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text(storage.read('data').toString()),
            backgroundColor:
                Colors.green, // You can customize the background color.
          ),
        );
        await Future.delayed(Duration(seconds: 3));
        // Both OTPs are valid, navigate to the next screen.
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => pancardd(),
            ));
      } else if (storage.read('error4') == "201") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Text(storage.read('reason').toString()),
            backgroundColor:
                Colors.blue, // You can customize the background color.
          ),
        );
        await Future.delayed(Duration(seconds: 3));
        // Both OTPs are valid, navigate to the next screen.
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => pancardd(),
        //     ));
      }
    }
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
        body: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 /
                        9, // Adjust this ratio according to your image's aspect ratio
                    child: Image.asset('assets/dob.png'),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Date Of Birth',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        child: Text(
                          'Pancard ',
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 8, top: 10),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          globle.pancard_dob = value;
                        });
                      },
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, bottom: 6, top: 10),
                        child:
                            Text("Date of Birth", textAlign: TextAlign.start),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 6),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      readOnly: true,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: GestureDetector(
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: selectedDate ?? DateTime.now(),
                                firstDate: DateTime(1947),
                                lastDate: DateTime(2101),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: Color.fromARGB(194, 4, 78, 73),
                                        onPrimary: Colors.white, // <-- SEE HERE
                                        onSurface: Colors.black, // <-- SEE HERE
                                      ),
                                    ),
                                    child: child!,
                                  );
                                });

                            if (pickedDate != null &&
                                pickedDate != selectedDate) {
                              setState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                          child: Icon(
                            Icons
                                .calendar_month_sharp, // You can replace this with your desired icon
                            color: Colors.grey,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.grey), // Remove border highlight
                        ),
                        hintText: selectedDate != null
                            ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                            : "dd/mm/yyyy",
                        hintStyle: TextStyle(
                          color:
                              selectedDate != null ? Colors.black : Colors.grey,
                        ), // Change the hint text color
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        loginuser();
                        if (selectedDate == null) {
                          // Show a validation message for groupValue
                          _showSnackBar(
                            context,
                            "Please Enter date of birth",
                          );
                        } else {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return pancard();
                          //     },
                          //   ),
                          // );
                        }
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
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text(
                        'Verify',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
