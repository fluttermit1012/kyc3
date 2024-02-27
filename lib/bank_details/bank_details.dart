// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// import 'package:new_kyc_3/main.dart';
// import 'package:new_kyc_3/manual_upload_bank.dart';
// import 'package:new_kyc_3/trading_preference.dart';
// import 'package:http/http.dart' as http;

// class bank_details extends StatefulWidget {
//   const bank_details({super.key});

//   @override
//   State<bank_details> createState() => _bank_detailsState();
// }

// class _bank_detailsState extends State<bank_details> {

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// TextEditingController _ac_no_controller=TextEditingController();
// TextEditingController _name_pancard_controller=TextEditingController();
// TextEditingController _bank_acc_ifsc_controller=TextEditingController();
// TextEditingController _bank_ac_type_controller = TextEditingController(text: 'Saving');

//   String? _selectedItem = 'Saving';

//   final List<String> _items = [
//     'Saving',
//     'Current',
//     'NRE',
//     'NRO',
//     'OD',
//     'Others'
//   ];

//    bool _isLoading = false;

//   void _showLoadingDialog() {
//    showDialog(
//   context: context,
//   barrierDismissible: false,
//   builder: (context) {
//     return AlertDialog(
//       //  backgroundColor: Colors.black.withOpacity(0.9),
//       content: Container(
//         height: 100, // Set the desired height
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               CircularProgressIndicator(),
//               Text('Please Wait...',style: TextStyle(fontSize: 18),)
//             ],
//           ),
//         ),
//       ),
//     );
//   },
// );

//   }

//   void _hideLoadingDialog() {
//     if (_isLoading) {
//       Navigator.of(context).pop();
//       _isLoading = false;
//     }
//   }

//   Future<void> bankverify() async {
//       _isLoading = true;
//     _showLoadingDialog();
//     Uri url = Uri.parse('http://connect.arhamshare.com:9090/EAPI/BankDetails');
//     var response = await http.post(url, headers: {
//       'Content-Type': 'application/x-www-form-urlencoded'
//     }, body: {
//       'pan_card': '',
//       'account_type': 'Individual',
//       'session_pan': 'AMUPU4253H',
//       'bank_acc_no': _ac_no_controller.text,
//       'bank_ac_type': _bank_ac_type_controller.text,
//       'bank_acc_ifsc': _bank_acc_ifsc_controller.text,
//       'name_pancard': _name_pancard_controller.text,
//       'phone': '8401841185',
//       'email': 'arhamshare.flutter.2@gmail.com',
//       'leverage_plan': '',
//       'trading_preference': 'Cash/Mutual fund',
//       'bank_statement_pdf': '',
//       'refferal_code_a': '',
//       'introducer_type': '',
//       'branch_code': '',
//       'rm_code': '',
//       'ro_code': ''
//     });
//     if (response.statusCode == 200) {
//               _hideLoadingDialog();

//       final responseDATA = response.body;
//       final reason = jsonDecode(response.body)['reson'];
//       final error = jsonDecode(response.body)['errorCode'];

//       print(responseDATA);
//       print(error);
//       print(reason);
//       storage.write('err', error);
//       storage.write('reasn', reason);
//       if (responseDATA == "404") {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('does not match')));
//       } else if (storage.read('err') == "403") {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar( behavior: SnackBarBehavior.floating,
//             duration: Duration(seconds: 2),
//             content: Text(storage.read('reasn').toString()),
//             backgroundColor:
//                 Colors.red, // You can customize the background color.
//           ),
//         );
//       }
//        else if (storage.read('err') == "302") {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar( behavior: SnackBarBehavior.floating,
//             duration: Duration(seconds: 2),
//             content: Text(storage.read('reasn').toString()),
//             backgroundColor:
//                 Colors.red, // You can customize the background color.
//           ),
//         );
//         await Future.delayed(Duration(seconds: 2));
//          Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => manual_upload_bank(),
//             ));
//       }
//        else if (storage.read('err') == "200") {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(  behavior: SnackBarBehavior.floating,
//             duration: Duration(seconds: 2),
//             content: Text(storage.read('reasn').toString()),
//             backgroundColor:
//                 Colors.green, // You can customize the background color.
//           ),
//         );
//          await Future.delayed(Duration(seconds: 2));
//          Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => trading_preference(),
//             ));
//       }
//       } else {
//         _hideLoadingDialog();
//         // Handle the error case here
//       }
//     }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           foregroundColor: Colors.black,
//           centerTitle: true,
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           title: Container(
//             height: 50,
//             width: 200,
//             child: Image.asset(
//               'assets/logo6.png',
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Bank Details',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 22,
//                           color: Color.fromARGB(255, 4, 78, 73)),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             left: 25, right: 25, bottom: 6, top: 10),
//                         child: Text("Name (As Per PanCard)",
//                             textAlign: TextAlign.start),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: 20, right: 20, bottom: 6),
//                     child: TextFormField(
//                       controller: _name_pancard_controller,
//                       inputFormatters: [UpperCaseTextFormatter()],
//                       keyboardType: TextInputType.name,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Enter Your Name";
//                         } else {
//                           return null;
//                         }
//                       },
//                       style: TextStyle(color: Colors.black),
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(8),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         hintText: "Enter Your Name",
//                         prefixIcon: Icon(
//                           Icons.account_box_sharp,
//                           color: Colors.black,
//                         ),
//                       ),
//                       cursorColor: Colors.black,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             left: 25, right: 25, bottom: 6, top: 10),
//                         child: Text("Bank Account Number",
//                             textAlign: TextAlign.start),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: 20, right: 20, bottom: 6),
//                     child: TextFormField(
//                       controller: _ac_no_controller,
//                        keyboardType: TextInputType.number,

//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Enter Your Bank Account Number";
//                         }
//       // You can add more specific validation logic if needed.
//       // For example, check if it only contains digits.
//       if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
//         return "Account number must contain only digits.";
//       }
//       // If all checks pass, return null to indicate a valid input.
//       return null;
//                       },
//                       style: TextStyle(color: Colors.black),
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(8),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         hintText: "Enter Your Bank Account Number",
//                         prefixIcon: Icon(
//                           Icons.account_box_sharp,
//                           color: Colors.black,
//                         ),
//                       ),
//                       cursorColor: Colors.black,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             left: 25, right: 25, bottom: 6, top: 10),
//                         child:
//                             Text("Bank IFSC Code", textAlign: TextAlign.start),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: 20, right: 20, bottom: 6),
//                     child: TextFormField(
//                       controller: _bank_acc_ifsc_controller,
//                       keyboardType: TextInputType.name,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Enter Your Bank IFSC Code";
//                         } else {
//                           return null;
//                         }
//                       },
//                       style: TextStyle(color: Colors.black),
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(8),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         hintText: "Enter Your Bank IFSC Code",
//                         prefixIcon: Icon(
//                           Icons.account_box_sharp,
//                           color: Colors.black,
//                         ),
//                       ),
//                       cursorColor: Colors.black,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             left: 25, right: 25, bottom: 8, top: 10),
//                         child: Text("Bank Account Type",
//                             textAlign: TextAlign.start),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: 20, right: 20, bottom: 6),
//                     child: DropdownButtonFormField<String>(

//                       value: _selectedItem,
//                       items: _items.map((String item) {
//                         return DropdownMenuItem<String>(
//                           value: item,
//                           child: Text(
//                             item,
//                             style: TextStyle(fontSize: 14),
//                           ),
//                         );
//                       }).toList(),
//                       onChanged: (String? value) {
//                         setState(() {
//                           _selectedItem = value!;
//                           _bank_ac_type_controller.text = value;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(8),
//                         hintText: 'Select Type',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: Colors.black),
//                         ),
//                       ),

//                     ),
//                   ),
//                   SizedBox(
//                     height: 55,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: 25, right: 25, bottom: 8, top: 10),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         OutlinedButton(
//                             style: OutlinedButton.styleFrom(
//                                 backgroundColor:
//                                     Color.fromARGB(255, 4, 78, 73)),
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 print(_ac_no_controller.text);
//                                 print(_bank_acc_ifsc_controller.text);
//                                 print(_name_pancard_controller.text);
//                                 print(_selectedItem);
//                                 bankverify();
//                                 if (_selectedItem == null) {
//                                   // Show a validation message for groupValue
//                                   _showSnackBar(
//                                     context,
//                                     "Please select Bank Account Type",
//                                   );
//                                 } else {
//                                   // Navigator.push(
//                                   //   context,
//                                   //   MaterialPageRoute(
//                                   //     builder: (context) =>
//                                   //         trading_preference(),
//                                   //   ),
//                                   // );
//                                 }
//                               }
//                             },
//                             child: Text(
//                               'Next',
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 18),
//                             )),
//                       ],
//                     ),
//                   ),
//                 ],
//               )),
//         ));
//   }

//   void _showSnackBar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }
// }
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:io';
import 'package:new_kyc_3/common/common.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:new_kyc_3/bank_details/manual_upload_bank.dart';


import 'package:new_kyc_3/signature_selfie/signature___.dart';


class bank_details extends StatefulWidget {
  const bank_details({Key? key}) : super(key: key);

  @override
  State<bank_details> createState() => _bank_detailsState();
}

class _bank_detailsState extends State<bank_details> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _acNoController = TextEditingController();
  TextEditingController _namePancardController = TextEditingController();
  TextEditingController _bankAccIfscController = TextEditingController();
  // TextEditingController _fileController = TextEditingController(text: '');
//       Future<void> _pickFile() async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//     type: FileType.custom,
//     allowedExtensions: ['jpg'],
//   );

//   if (result != null) {
//     String? fileName = result.files.single.name;
//     setState(() {
//       _fileController.text = fileName ?? '';
//     });
//   }
// }

  File? _selectedAadharFrontImageFile;
  String _selectedAadharFrontImagePath =
      ''; // Initialize it as an empty string.

  File? _selectedAadharBackImageFile;
  String _selectedAadharBackImagePath = '';

  File? _selectedPANCARDFrontImageFile;
  String _selectedPANCARDFrontImagePath = '';

  Future<void> pickAadharFrontImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedAadharFrontImageFile = File(pickedFile.path);
        _selectedAadharFrontImagePath = pickedFile.path; // Set the path.
      });
    }
  }

  Future<void> pickAadharBackImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedAadharBackImageFile = File(pickedFile.path);
        _selectedAadharBackImagePath = pickedFile.path; // Set the path.
      });
    }
  }

  Future<void> pickPANCARDImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedPANCARDFrontImageFile = File(pickedFile.path);
        _selectedPANCARDFrontImagePath = pickedFile.path; // Set the path.
      });
    }
  }

  TextEditingController _bankAcTypeController =
      TextEditingController(text: 'Saving');

  String? _selectedItem = 'Saving';

  final List<String> _items = [
    'Saving',
    'Current',
    'NRE',
    'NRO',
    'OD',
    'Others'
  ];

  ScrollController _scrollController = ScrollController();

  void _scrollToOffset(double offset) {
    _scrollController.animateTo(
      offset,
      duration: Duration(
          milliseconds: 20), // Adjust the duration for slower scrolling
      curve: Curves
          .ease, // You can adjust the curve for different scrolling animations
    );
  }

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

  //   Future<void> bankVerify() async {
  //     _isLoading = true;
  //     _showLoadingDialog();
  //     Uri url = Uri.parse('http://connect.arhamshare.com:9090/EAPI/BankDetails');
  //     var response = await http.post(url, headers: {
  //       'Content-Type': 'application/x-www-form-urlencoded'
  //     }, body: {
  //       'pan_card': '',
  //       'account_type': 'Individual',
  //       'session_pan': 'AMUPU4253H',
  //       'bank_acc_no': _acNoController.text,
  //       'bank_ac_type': _bankAcTypeController.text,
  //       'bank_acc_ifsc': _bankAccIfscController.text,
  //       'name_pancard': _namePancardController.text,
  //       'phone': '8401841185',
  //       'email': 'arhamshare.flutter.2@gmail.com',
  //       'leverage_plan': '',
  //       'trading_preference': 'Cash/Mutual fund',
  //       'bank_statement_pdf': '',
  //       'refferal_code_a': '',
  //       'introducer_type': '',
  //       'branch_code': '',
  //       'rm_code': '',
  //       'ro_code': '',
  //       'aadhar_front':''

  //     });
  //   if (response.statusCode == 200) {
  //     _hideLoadingDialog();

  //     final responseDATA = response.body;
  //     final reason = jsonDecode(response.body)['reson'];
  //     final error = jsonDecode(response.body)['errorCode'];

  //     print(responseDATA);
  //     print(error);
  //     print(reason);

  //     if (responseDATA == "404") {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('does not match')));
  //     } else if (error == "403") {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           behavior: SnackBarBehavior.floating,
  //           duration: Duration(seconds: 2),
  //           content: Text(reason.toString()),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     } else if (error == "302") {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(
  //             behavior: SnackBarBehavior.floating,
  //             duration: Duration(seconds: 2),
  //             content: Text(reason.toString()),
  //             backgroundColor: Colors.red,
  //           ))
  //           .closed
  //           .then((reason) {
  //         if (reason == SnackBarClosedReason.action) {
  //           // Handle the action, if any
  //         } else {
  //           // Navigate to a new screen after the SnackBar is closed
  //           Navigator.of(context).push(MaterialPageRoute(
  //             builder: (context) {
  //               return manual_upload_bank();
  //             },
  //           ));
  //         }
  //       });
  //       await Future.delayed(Duration(seconds: 2));
  //       _scrollToOffset(200.0); // Adjust the offset as needed
  //     } else if (error == "200") {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(
  //             behavior: SnackBarBehavior.floating,
  //             duration: Duration(seconds: 2),
  //             content: Text(reason.toString()),
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
  //               return trading_preference();
  //             },
  //           ));
  //         }
  //       });
  //       await Future.delayed(Duration(seconds: 2));
  //       _scrollToOffset(300.0); // Adjust the offset as needed
  //     }
  //   } else {
  //     _hideLoadingDialog();
  //     // Handle the error case here
  //   }
  // }
  Future<void> bankVerify() async {
    _isLoading = true;
    _showLoadingDialog();

    Uri url = Uri.parse('http://connect.arhamshare.com:9090/EAPI/BankDetails');
    var request = http.MultipartRequest('POST', url);

    // Add form data
    request.fields['pan_card'] = '';
    request.fields['account_type'] = 'Individual';
    request.fields['session_pan'] = globle.pancard_dob;
    request.fields['bank_acc_no'] = _acNoController.text;
    request.fields['bank_ac_type'] = _bankAcTypeController.text;
    request.fields['bank_acc_ifsc'] = _bankAccIfscController.text;
    request.fields['name_pancard'] = _namePancardController.text;
    request.fields['phone'] = '8401841185';
    request.fields['email'] = 'arhamshare.flutter.2@gmail.com';
    request.fields['leverage_plan'] = '';
    request.fields['trading_preference'] = 'Cash/Mutual fund';
    request.fields['refferal_code_a'] = '';
    request.fields['introducer_type'] = '';
    request.fields['branch_code'] = '';
    request.fields['rm_code'] = '';
    request.fields['ro_code'] = '';

    // Add the 'aadhar_front' image
    if (_selectedAadharFrontImageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'aadhar_front', // Field name for the image
        _selectedAadharFrontImageFile!.path,
        contentType:
            MediaType('image', 'jpeg'), // Change to the correct image format
      ));
    }
    if (_selectedAadharBackImageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'aadhar_back', // Field name for the image
        _selectedAadharBackImageFile!.path,
        contentType:
            MediaType('image', 'jpeg'), // Change to the correct image format
      ));
    }
    if (_selectedPANCARDFrontImageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'pan_image', // Field name for the image
        _selectedPANCARDFrontImageFile!.path,
        contentType:
            MediaType('image', 'jpeg'), // Change to the correct image format
      ));
    }

    // Send the request
    var response = await request.send();

    if (response.statusCode == 200) {
      // Handle the response as needed
      _hideLoadingDialog();

      var responseDATA = await response.stream.bytesToString();
      var reason = jsonDecode(responseDATA)['reason'];
      var error = jsonDecode(responseDATA)['errorCode'];
      if (error == "200") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
              content: Text(reason.toString()),
              backgroundColor: Colors.green,
            ))
            .closed
            .then((reason) {
          if (reason == SnackBarClosedReason.action) {
            // Handle the action, if any
          } else {
            // Navigate to a new screen after the SnackBar is closed
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return SignaturePage();
            }));
          }
        });
        // Rest of your code to handle different cases
      } else {
        _hideLoadingDialog();
        if (responseDATA == "404") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('does not match')));
        } else if (error == "403") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
              content: Text(reason.toString()),
              backgroundColor: Colors.red,
            ),
          );
        } else if (error == "302") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
                content: Text(reason.toString()),
                backgroundColor: Colors.red,
              ))
              .closed
              .then((reason) {
            if (reason == SnackBarClosedReason.action) {
              // Handle the action, if any
            } else {
              // Navigate to a new screen after the SnackBar is closed
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return manual_upload_bank();
                },
              ));
            }
          });
          //       await Future.delayed(Duration(seconds: 2));
          //       _scrollToOffset(200.0); // Adjust the offset as needed
          //     }
          // Handle the error case here
        }
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                  'Bank Details',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color.fromARGB(255, 4, 78, 73)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 6, top: 10),
                    child: Text("Name (As Per PanCard)",
                        textAlign: TextAlign.start),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 6),
                child: TextFormField(
                  controller: _namePancardController,
                  inputFormatters: [UpperCaseTextFormatter()],
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Name";
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
                    hintText: "Enter Your Name",
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 6, top: 10),
                    child:
                        Text("Bank Account Number", textAlign: TextAlign.start),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 6),
                child: TextFormField(
                  controller: _acNoController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Bank Account Number";
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return "Account number must contain only digits.";
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Enter Your Bank Account Number",
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 6, top: 10),
                    child: Text("Bank IFSC Code", textAlign: TextAlign.start),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 6),
                child: TextFormField(
                  controller: _bankAccIfscController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Bank IFSC Code";
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
                    hintText: "Enter Your Bank IFSC Code",
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, bottom: 8, top: 10),
                    child:
                        Text("Bank Account Type", textAlign: TextAlign.start),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 6),
                child: DropdownButtonFormField<String>(
                  value: _selectedItem,
                  items: _items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedItem = value!;
                      _bankAcTypeController.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    hintText: 'Select Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 10),
                      child: Text("Upload Proof aadhar_front",
                          textAlign: TextAlign.start),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                        text:
                            _selectedAadharFrontImagePath), // Display the path as text.

                    decoration: InputDecoration(
                      labelText: 'Selected File',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.folder_open),
                        onPressed: pickAadharFrontImage,
                      ),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 10),
                      child: Text("Upload Proof aadhar_back",
                          textAlign: TextAlign.start),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                        text:
                            _selectedAadharBackImagePath), // Display the path as text.

                    decoration: InputDecoration(
                      labelText: 'Selected File',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.folder_open),
                        onPressed: pickAadharBackImage,
                      ),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 10),
                      child: Text("Upload Proof PANCARD",
                          textAlign: TextAlign.start),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                        text:
                            _selectedPANCARDFrontImagePath), // Display the path as text.

                    decoration: InputDecoration(
                      labelText: 'Selected File',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.folder_open),
                        onPressed: pickPANCARDImage,
                      ),
                    )),
              ),
              SizedBox(
                height: 55,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, bottom: 8, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // OutlinedButton(
                    //     style: OutlinedButton.styleFrom(
                    //         backgroundColor: Color.fromARGB(255, 4, 78, 73)),
                    //     onPressed: () {
                    //       if (_formKey.currentState!.validate()) {
                    //         print(_acNoController.text);
                    //         print(_bankAccIfscController.text);
                    //         print(_namePancardController.text);
                    //         print(_selectedItem);
                    //         print(_selectedAadharFrontImagePath);
                    //         print(_selectedAadharBackImagePath);
                    //         print(_selectedPANCARDFrontImagePath);
                    //         bankVerify();
                    //         if (_selectedItem == null) {
                    //           _showSnackBar(
                    //             context,
                    //             "Please select Bank Account Type",
                    //           );
                    //         }
                    //         //  else if (_fileController.text.isEmpty) {
                    //         //   _showSnackBar(
                    //         //     context,
                    //         //     "Please upload a file",
                    //         //   );
                    //         // }
                    //       }
                    //     },
                    //     child: Text(
                    //       'Next',
                    //       style: TextStyle(color: Colors.white, fontSize: 18),
                    //     )),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 4, 78, 73),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print(_acNoController.text);
                          print(_bankAccIfscController.text);
                          print(_namePancardController.text);
                          print(_selectedItem);
                          print(_selectedAadharFrontImagePath);
                          print(_selectedAadharBackImagePath);
                          print(_selectedPANCARDFrontImagePath);
                          bankVerify();
                          if (_selectedItem == null) {
                            _showSnackBar(
                                context, "Please select Bank Account Type");
                          } else {
                            if (_selectedAadharFrontImagePath.isEmpty) {
                              _showSnackBar(
                                  context, "Please upload Aadhar Front image");
                            } else if (_selectedAadharBackImagePath.isEmpty) {
                              _showSnackBar(
                                  context, "Please upload Aadhar Back image");
                            } else if (_selectedPANCARDFrontImagePath.isEmpty) {
                              _showSnackBar(
                                  context, "Please upload PAN Card image");
                            }
                          }
                        }
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text!.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
