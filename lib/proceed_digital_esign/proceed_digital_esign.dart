import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:new_kyc_3/e_sign/esign_api.dart';
import 'package:new_kyc_3/common/common.dart';
import 'package:new_kyc_3/global.dart';
import 'package:new_kyc_3/webfile.dart';
import 'package:open_file/open_file.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
class proceed_digital_esign extends StatefulWidget {
 
  final int accset;
  final TextEditingController brokname;
  final int pastaction;
   proceed_digital_esign({super.key,required this.accset,
    required this.brokname,
    required this.pastaction,});

  @override
  State<proceed_digital_esign> createState() => _proceed_digital_esignState();
}

class _proceed_digital_esignState extends State<proceed_digital_esign> {
    List<String> selectedValues = [ 'I hereby consent to use my adhar (UID) for authenticating/e-signing and completing account opening process with Arham share Pvt Ltd. under ekyc subject to policy, procedure, terms and conditions laid by it so hereby i consent to use my adhar to perform e-kyc & generate electronic signature & affix same to my application & documents which i have reviewed & approved for submission \n I have read, understood and agree to the terms of use and other terms and conditions laid out by Arham.',];
  List<String> radioOptions = [
    'I hereby consent to use my adhar (UID) for authenticating/e-signing and completing account opening process with Arham share Pvt Ltd. under ekyc subject to policy, procedure, terms and conditions laid by it so hereby i consent to use my adhar to perform e-kyc & generate electronic signature & affix same to my application & documents which i have reviewed & approved for submission \n I have read, understood and agree to the terms of use and other terms and conditions laid out by Arham.',
  ];
  List<String> selectedValues1 = [
     'I/We wish to instruct DP to accept all the pledge instructions in my/our account without any further instructions from my/our end.',
    'I/We instruct DP to receive each and every credit in my/our Account.',
    'I/We would like  to share the email id with RTA.',
    'I/We would like to recieve Annual reports through electronic mode.',
    'I/We wish to  to receive dividend/interest directly into my bank account through ECS.',
    'I/We would like to receive account statement as per SEBI regulations.',
    ' I/we wish you to send Electronic Transaction Cum Holding statement with other required documents on the registered email id.'
  ];
  List<String> radioOptions1 = [
    'I/We wish to instruct DP to accept all the pledge instructions in my/our account without any further instructions from my/our end.',
    'I/We instruct DP to receive each and every credit in my/our Account.',
    'I/We would like  to share the email id with RTA.',
    'I/We would like to recieve Annual reports through electronic mode.',
    'I/We wish to  to receive dividend/interest directly into my bank account through ECS.',
    'I/We would like to receive account statement as per SEBI regulations.',
    ' I/we wish you to send Electronic Transaction Cum Holding statement with other required documents on the registered email id.'
  ];
  bool areAllCheckboxesSelected() {
    // Check if all checkboxes in both lists are selected
    return selectedValues.length == radioOptions.length &&
        selectedValues1.length == radioOptions1.length;
  }
  final GlobalKey<State> _dialogKey = GlobalKey<State>();
 Future<void> downlod() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            key: _dialogKey,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitCircle(color: Colors.blue),
                const SizedBox(height: 10),
                Text(
                  "Please Wait...",
                ),
              ],
            ),
          );
        },
      );
      Uri url =
          Uri.parse('http://connect.arhamshare.com:9090/EAPI/download_pdf');

      var request = http.MultipartRequest('POST', url);

      request.fields['pan_card'] = '';
      request.fields['account_type'] = 'Individual';
      request.fields['session_pan'] = globle.pancard_dob;
      request.fields['past_action'] = 'Yes';
      request.fields['broker_name'] = 'Upstock';
      request.fields['runnning_account_settelment'] = 'quarterly';
      request.fields['geo_latitude'] = '21.185890';
      request.fields['geo_longitude'] = '72.810287';
      request.fields['download_pdf_type'] = 'download';

      var response = await request.send();

      if (response.statusCode == 200) {
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        File file = File('$tempPath/downloaded.pdf');
        await response.stream.pipe(file.openWrite());
        await OpenFile.open(file.path);
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
      return;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Esign OR Manual',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color.fromARGB(255, 4, 78, 73)),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, bottom: 8, top: 10),
                  child: Text("Aadhar Consent", textAlign: TextAlign.start),
                ),
              ],
            ),
           
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: radioOptions.map((option) {
                  return Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        activeColor: Color.fromARGB(255, 4, 78, 73),
                        value: selectedValues.contains(option),
                        onChanged: (isSelected) {
                          setState(() {
                            if (isSelected == true) {
                              selectedValues.add(option);
                            } else {
                              selectedValues.remove(option);
                            }
                          });
                        },
                        //  onChanged: null,
                      ),
                      SizedBox(
                          width:
                              4.0), // Add spacing between the checkbox and text
                      Expanded(
                        child: Text(
                          option,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 12.0),
                        ),
                      )
                    ],
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, bottom: 8, top: 10),
                  child:
                      Text("Agree to all Consent", textAlign: TextAlign.start),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: radioOptions1.map((option1) {
                  return Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        activeColor: Color.fromARGB(255, 4, 78, 73),
                        value: selectedValues1.contains(option1),
                        onChanged: (isSelected) {
                          setState(() {
                            if (isSelected == true) {
                              selectedValues1.add(option1);
                            } else {
                              selectedValues1.remove(option1);
                            }
                          });
                          
                        },
                        //  onChanged: null,
                        
                      ),
                      SizedBox(
                          width:
                              4.0), // Add spacing between the checkbox and text
                      Expanded(
                        child: Text(
                          option1,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 12.0),
                        ),
                      )
                    ],
                  );
                }).toList(),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            SizedBox(height: 15.0),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1)
          ),
           child: Column(
             children: [
               Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25, right: 25, bottom: 8, top: 10),
                            child: Text("Proceed for Digital eSign \n(if your mobile number is linked to Aadhar)", textAlign: TextAlign.start),
                          ),
                        ],
                      ),
                       Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 8, top: 10),
                    child: Text('please download the form and verify the details before proceeding further',style: TextStyle(fontSize: 8),
                     textAlign: TextAlign.start), ),
                ]
                  ),

             ],
           ),
         ),
       ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonBar(
                      children: [
                       OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 4, 78, 73)),
                            onPressed: () {
                             downlod();
                            },
                            child: Text(
                              'View Download PDF',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            )),

                       OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 4, 78, 73)),
                            onPressed: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context) => Esignpage(accset: widget.accset,
                                    brokname: widget.brokname,
                                    pastaction: widget.pastaction,),));
                            },
                            child: Text(
                              'Proceed for eSign',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            )),
                      ],
                    )
                  ],
                ),
              )
                ],
              ),

        ),

    );
  }
}

