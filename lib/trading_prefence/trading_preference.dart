import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:new_kyc_3/common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:new_kyc_3/global.dart';

import 'package:new_kyc_3/proceed_digital_esign/proceed_digital_esign.dart';


class trading_preference extends StatefulWidget {
  const trading_preference({super.key});

  @override
  State<trading_preference> createState() => _trading_preferenceState();
}

class _trading_preferenceState extends State<trading_preference> {
  TextEditingController _Introducer_Controller =
      TextEditingController(text: 'Client');
        TextEditingController _leverage_Controller =
      TextEditingController(text: 'Lifetime');
      
  TextEditingController _br_codeController =
      TextEditingController(text: 'Main');
      
       TextEditingController _rm_codeController =
      TextEditingController();
      TextEditingController _ro_codeController =
      TextEditingController();
  bool showAdditionalFields = false;
 TextEditingController brokname = TextEditingController();
  int? pastaction = 1;
  int? accset = 0;
  bool areTradingPreferencesSelected() {
    return selectedValues.length >= 1;
  }

  File? _selected_bank_statement_pdf_ImageFile;
  String _selected_bank_statement_pdf_upload_Path = '';
  Future<void> pickAadharFrontImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Only allow PDF files
    );

    if (result != null) {
      String? fileName = result.files.single.name;
      final filePath = result.files.single.path;
      if (filePath != null && filePath.isNotEmpty) {
        setState(() {
          _selected_bank_statement_pdf_upload_Path =
              filePath.split('/').last; // Set the file name only
          _selected_bank_statement_pdf_ImageFile = File(filePath);
        });
      }
    }
  }

  Future<void> trading_verify() async {
    _isLoading = true;
    _showLoadingDialog();
  String tradingPreferences = selectedValues.join(',');
    Uri url =
        Uri.parse('http://connect.arhamshare.com:9090/EAPI/TradingPreferences');
    var request = http.MultipartRequest('POST', url);

    // Add form data
    request.fields['pan_card'] = '';
    request.fields['account_type'] = 'Individual';
    request.fields['session_pan'] = globle.pancard_dob;
    request.fields['leverage_plan'] =_leverage_Controller.text;
    request.fields['trading_preference'] = tradingPreferences;
    request.fields['introducer_type'] = _Introducer_Controller.text;
    request.fields['refferal_code_a'] = '';
    request.fields['branch_code'] = _br_codeController.text;
    request.fields['rm_code'] = _rm_codeController.text;
    request.fields['ro_code'] =_ro_codeController.text;
    request.fields['Running_Account_Settlement']='';
    request.fields['Past_Action']='';
    request.fields['Broker_Name']='';
print(tradingPreferences);
    // Add the 'aadhar_front' image
//   if (_selected_manual_bank_proof_upload_ImageFile != null) {
//   request.files.add(await http.MultipartFile.fromPath(
//     'manual_bank_proof_upload', // Field name for the image
//     _selected_manual_bank_proof_upload_ImageFile!.path,
//     contentType: MediaType('image', 'jpeg'), // Change to the correct image format
//   ));
// }
    // if (_selected_bank_statement_pdf_ImageFile != null) {
    //   final contentType = _selected_bank_statement_pdf_ImageFile!.path
    //           .toLowerCase()
    //           .endsWith('.pdf')
    //       ? MediaType('application', 'pdf')
    //       : MediaType('image', 'jpeg');

    //   request.files.add(await http.MultipartFile.fromPath(
    //     'bank_statement_pdf',
    //     _selected_bank_statement_pdf_ImageFile!.path,
    //     contentType: contentType,
    //   ));
    // }
    if (_selected_bank_statement_pdf_ImageFile != null) {
      final filePath = _selected_bank_statement_pdf_ImageFile!.path;
      final fileName = filePath.split('/').last;

      if (filePath.toLowerCase().endsWith('.pdf')) {
        final contentType = MediaType('application', 'pdf');

        request.files.add(await http.MultipartFile.fromPath(
          'bank_statement_pdf',
          filePath,
          contentType: contentType,
        ));
      } else {
        // Handle the case where the selected file is not a PDF
        // You can display an error message or take appropriate action.
      }
    }

    // Send the request
    var response = await request.send();

    if (response.statusCode == 200) {

      // Handle the response as needed
      _hideLoadingDialog();

      var responseDATA = await response.stream.bytesToString();
      var reason123 = jsonDecode(responseDATA)['reason'];
      var errorcode = jsonDecode(responseDATA)['errorCode'];
      print(reason123);
      print(errorcode);
       ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
              content: Text(reason123.toString()),
              backgroundColor: Colors.green,
            ))
            .closed
            .then((reason) {
          if (reason == SnackBarClosedReason.action) {
            // Handle the action, if any
          } else {
            // Navigate to a new screen after the SnackBar is closed
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return 
                // SignaturePage();
                proceed_digital_esign(
                  accset: accset!,
                                    brokname: brokname,
                                    pastaction: pastaction!,
                );
              },
            ));
          }
     } );
      // Rest of your code to handle different cases
    } else {
      _hideLoadingDialog();
      // Handle the error case her
    }}

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
                    style: TextStyle(fontSize: 18),
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
Widget buildSegment(String text) => Text(text,
    );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int groupValue1 = 1;
  int groupValue2 = 2;
  String labelText = 'Client Code / Sub-Broker Code';

  List<String> selectedValues = ['Cash/Mutual fund', 'DEBT'];

  List<String> radioOptions = [
    'Cash/Mutual fund',
    'DEBT',
    'Future & Options',
    'Currency Derivatives',
  ];
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '##Trading Preference##',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 4, 78, 73)),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                // SizedBox(
                //   height: 5,
                // ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, bottom: 8, top: 10),
                      child:
                          Text("Select Introducer", textAlign: TextAlign.start),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                  child: Container(
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl<int>(
                      thumbColor: Color.fromARGB(255, 4, 78, 73),
                      backgroundColor: Colors.white,
                      children: {
                        1: Text("Client", style: _segmentTextStyle(1)),
                        2: Text("Sub / Broker", style: _segmentTextStyle(2)),
                        3: Text("Branch / R M / R O",
                            style: _segmentTextStyle(3)),
                      },
                      onValueChanged: (value) {
                        setState(() {
                          groupValue1 = value!;
                          if (value == 1) {
                            // Update _mrtlst_Controller for "Married"
                            _Introducer_Controller.text = "Client";
                          } else if (value == 2) {
                            // Update _mrtlst_Controller for "Unmarried"
                            _Introducer_Controller.text = "Sub / Broker";
                          } else if (value == 3) {
                            // Update _mrtlst_Controller for "Other"
                            _Introducer_Controller.text = "Branch / R M / R O";
                          }
                          showAdditionalFields = value ==
                              3; // Set showAdditionalFields based on selected segment
                          if (value == 3) {
                            labelText =
                                'Branch Code'; // Change the label text for "Branch / R M / R O"
                          } else {
                            labelText =
                                'Client Code / Sub-Broker Code'; // Reset the label text for other segments
                          }
                        });
                      },
                      groupValue: groupValue1,
                    ),
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
                      child: Text(labelText, textAlign: TextAlign.start),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                  child: TextFormField(
                    controller: _br_codeController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Client Code / Sub-Broker Code';
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter Your Client Code / Sub-Broker Code',
                      prefixIcon: Icon(
                        Icons.account_box_sharp,
                        color: Colors.black,
                      ),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Visibility(
                  visible: showAdditionalFields,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25, right: 25, bottom: 8, top: 10),
                            child: Text('Branch / R M ',
                                textAlign: TextAlign.start),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 8),
                            child: Container(
                              width: 145,
                              child: TextFormField(
                                controller: _rm_codeController,
                                // initialValue: 'Main',
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Branch / R M ';
                                  } else {
                                    return null;
                                  }
                                },
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Enter Branch / R M ',
                                  prefixIcon: Icon(
                                    Icons.account_box_sharp,
                                    color: Colors.black,
                                  ),
                                ),
                                cursorColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25, right: 25, bottom: 8, top: 10),
                            child: Text('Branch / R O ',
                                textAlign: TextAlign.start),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 8),
                            child: Container(
                              width: 145,
                              child: TextFormField(
                                controller: _ro_codeController,
                                // initialValue: 'Main',
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Branch / R O ';
                                  } else {
                                    return null;
                                  }
                                },
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Enter Branch / R O ',
                                  prefixIcon: Icon(
                                    Icons.account_box_sharp,
                                    color: Colors.black,
                                  ),
                                ),
                                cursorColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                      child: Text("Choose a Leverage Plan",
                          textAlign: TextAlign.start),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                  child: Container(
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl<int>(
                      thumbColor: Color.fromARGB(255, 4, 78, 73),
                      backgroundColor: Colors.white,
                      //                 children: {
                      //   if (groupValue1 == 1 || groupValue1 == 2) 1: Text("Freedom(111)", style: _segmentTextStyle1(1)),
                      //   if (groupValue1 == 1 || groupValue1 == 2) 2: Text("LifeTime", style: _segmentTextStyle1(2)),
                      //   if (groupValue1 == 1) 3: Text("IPO", style: _segmentTextStyle1(3)),
                      // },
                      children: {
                        1: Text("Freedom(111)", style: _segmentTextStyle1(1)),
                        2: Text("LifeTime", style: _segmentTextStyle1(2)),
                        if (groupValue1 == 0 || groupValue1 == 2)
                          3: Text("IPO", style: _segmentTextStyle1(3)),
                      },
                      onValueChanged: (value) {
                      setState(() {
                        groupValue2 = value!;
                        if (value == 1) {
                          // Update _education_Controller for "Graduate"
                          _leverage_Controller.text = "Freedom(111)";
                        } else if (value == 2) {
                          // Update _education_Controller for "Post Graduate"
                          _leverage_Controller.text = "LifeTime";
                        } else if (value == 3) {
                          // Update _education_Controller for "Other"
                          _leverage_Controller.text = "IPO";
                        }
                      });
                    },
                      groupValue: groupValue2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, bottom: 8, top: 10),
                      child: Text("Trading Preference",
                          textAlign: TextAlign.start),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    children: radioOptions.map((option) {
                      bool isNonInteractive =
                          option == "Cash/Mutual fund" || option == "DEBT";

                      return Row(
                        children: <Widget>[
                          Checkbox(
                            activeColor: Color.fromARGB(255, 4, 78, 73),
                            value: selectedValues.contains(option),
                            onChanged: isNonInteractive
                                ? null
                                : (isSelected) {
                                    setState(() {
                                      if (isSelected == true) {
                                        selectedValues.add(option);
                                      } else {
                                        selectedValues.remove(option);
                                      }
                                    });
                                  },
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Expanded(
                            child: Text(
                              option,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: isNonInteractive
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Visibility(
                  visible: selectedValues.contains("Future & Options") ||
                      selectedValues.contains("Currency Derivatives"),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, top: 10),
                              child: Text("Upload Proof (bank_statement_pdf)",
                                  textAlign: TextAlign.start),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                         padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 8, top: 10),
                        child: TextFormField(
                          readOnly: true,
                          controller: TextEditingController(
                              text: _selected_bank_statement_pdf_upload_Path),
                          decoration: InputDecoration(
                            labelText: 'Selected File',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.folder_open),
                              onPressed: pickAadharFrontImage,
                            ),
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
                 Padding(
                   padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 8, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Past Action",
                       
                        ),
                        const Spacer(),
                        Container(
                          alignment: Alignment.center,
                          child: CupertinoSlidingSegmentedControl(
                            thumbColor: Colors.white,
                            padding: const EdgeInsets.all(3.5),
                            groupValue: pastaction,
                            children: {
                              0: buildSegment("Yes"),
                              1: buildSegment("No"),
                            },
                            onValueChanged: (value) {
                              setState(() {
                                pastaction = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: pastaction == 0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 8, top: 10),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        
                        keyboardType: TextInputType.text,
                        controller: brokname,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Valid Name";
                          }
                          return null;
                        },
                        enabled: true,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Global.fc),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Global.fc),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(Icons.person_remove)
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Global.fc, width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                           labelText: "Broker Name",
                       
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                   padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 8, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Runnning Account Settelment",
                       
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 8, top: 10),
                          child: Container(
                            alignment: Alignment.center,
                            child: CupertinoSlidingSegmentedControl(
                              backgroundColor: Global.fc,
                              thumbColor: Colors.white,
                              padding: const EdgeInsets.all(3.5),
                              groupValue: accset,
                              children: {
                                0: buildSegment("Quarterly"),
                                1: buildSegment("Monthly"),
                              },
                              onValueChanged: (value) {
                                setState(() {
                                  accset = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, bottom: 8, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 4, 78, 73)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print(_br_codeController.text);
                              print(_Introducer_Controller.text);
                              print(_leverage_Controller.text);
                              print(_rm_codeController.text);
                              print(_ro_codeController.text);
                              
                              trading_verify();
                              if (!areTradingPreferencesSelected()) {
                                // Show a Snackbar for not selecting trading preferences
                                _showSnackBar(
                                  context,
                                  "Please select at least Two trading preference",
                                );
                              } else {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => manual_upload_bank(),
                                //   ),
                                // );
                              }
                            }

                            // }
                          },
                          child: Text(
                            'Next',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    ],
                  ),
                )
              ],
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

  TextStyle _segmentTextStyle(int value) {
    return TextStyle(
      fontSize: 12,
      color: groupValue1 == value ? Colors.white : Colors.black,
    );
  }

  TextStyle _segmentTextStyle1(int value) {
    return TextStyle(
      fontSize: 12,
      color: groupValue2 == value ? Colors.white : Colors.black,
    );
  }
}
