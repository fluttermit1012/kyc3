import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_kyc_3/common/common.dart';

import 'package:new_kyc_3/trading_prefence/trading_preference.dart';


class manual_upload_bank extends StatefulWidget {
  const manual_upload_bank({super.key});

  @override
  State<manual_upload_bank> createState() => _manual_upload_bankState();
}

class _manual_upload_bankState extends State<manual_upload_bank> {
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // TextEditingController _fileController = TextEditingController(text: '');
    TextEditingController _documentController = TextEditingController(text: 'selected document');
 String? _selectedItem = 'selected document';

   final List<String> _items = ['selected document','Cancle Cheque', 'Bank Passbook / Statment'];
//   Future<void> _pickFile() async {
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
// Future<void> _pickFile() async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//     type: FileType.custom,
//     allowedExtensions: ['pdf'], // Change to 'pdf' for PDF files
//   );

//   if (result != null) {
//     String? fileName = result.files.single.name;
//     setState(() {
//       _fileController.text = fileName ?? '';
//     });
//   }
// }
File? _selected_manual_bank_proof_upload_ImageFile;
String _selected_manual_bank_proof_upload_Path = '';
// Future<void> pickAadharFrontImage() async {
//   final imagePicker = ImagePicker();
//   final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

//   if (pickedFile != null) {
//     setState(() {
//       _selected_manual_bank_proof_upload_ImageFile = File(pickedFile.path);
//       _selected_manual_bank_proof_upload_Path = pickedFile.path; // Set the path.
//     });
//   }
// }
Future<void> pickAadharFrontImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
  );

  if (result != null) {
    String? fileName = result.files.single.name;
    final filePath = result.files.single.path;
    if (filePath != null && filePath.isNotEmpty) {
  setState(() {
    _selected_manual_bank_proof_upload_Path = filePath.split('/').last; // Set the file name only
    _selected_manual_bank_proof_upload_ImageFile = File(filePath);
  });
}

  }
}


// Future<void> _pickFile() async {
//   FilePickerResult? result;

//   if (_selectedItem == 'Cancle Cheque') {
//     // Allow only 'jpg' files for Cancle Cheques
//     result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['jpg'],
//     );
//   } else if (_selectedItem == 'Bank Passbook / Statment') {
//     // Allow only 'pdf' files for Bank Passbook / Statement
//     result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );
//   }

//   if (result != null) {
//     String? fileName = result.files.single.name;
//     setState(() {
//       _fileController.text = fileName ?? '';
//     });
//   }
// }


Future<void> upload_Verify() async {
  _isLoading = true;
  _showLoadingDialog();

  Uri url = Uri.parse('http://connect.arhamshare.com:9090/EAPI/Manual_Upload');
  var request = http.MultipartRequest('POST', url);

  // Add form data
  request.fields['pan_card'] = '';
  request.fields['account_type'] = 'Individual';
  request.fields['session_pan'] = globle.pancard_dob;
  request.fields['manual_upload_type'] = _documentController.text;



  // Add the 'aadhar_front' image
//   if (_selected_manual_bank_proof_upload_ImageFile != null) {
//   request.files.add(await http.MultipartFile.fromPath(
//     'manual_bank_proof_upload', // Field name for the image
//     _selected_manual_bank_proof_upload_ImageFile!.path,
//     contentType: MediaType('image', 'jpeg'), // Change to the correct image format
//   ));
// } 
if (_selected_manual_bank_proof_upload_ImageFile != null) {
  final contentType = _selected_manual_bank_proof_upload_ImageFile!.path.toLowerCase().endsWith('.pdf')
    ? MediaType('application', 'pdf')
    : MediaType('image', 'jpeg');

  request.files.add(await http.MultipartFile.fromPath(
    'manual_bank_proof_upload',
    _selected_manual_bank_proof_upload_ImageFile!.path,
    contentType: contentType,
  ));
}





  // Send the request
  var response = await request.send();

  if (response.statusCode == 200) {
    // Handle the response as needed
    _hideLoadingDialog();

    var responseDATA = await response.stream.bytesToString();
    var error = jsonDecode(responseDATA)['error'];
    var errorcode = jsonDecode(responseDATA)['errorCode'];
print(error);
print(errorcode);
 if (errorcode == "200") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
              content: Text(error.toString()),
              backgroundColor: Colors.green,
            ))
            .closed
            .then((reason) {
          if (reason == SnackBarClosedReason.action) {
              } else {
            // Navigate to a new screen after the SnackBar is closed
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return trading_preference();
              },
            ));
          }
 });
            // Handle the action, if any
 
    // Rest of your code to handle different cases
  } else {
     if (errorcode == "404") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('does not match')));
  }
  }
    _hideLoadingDialog();

    // Handle the error case here
  }
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
              'Manual Upload Bank Proof',
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, bottom: 8, top: 10),
                child: Text("Select Document Type", textAlign: TextAlign.start),
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
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedItem = value;
                   _documentController.text = value!;
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
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25,  top: 10),
                  child: Text(
                      "Upload Proof \n(cancle Cheque / Passbook / Bank Statments)",
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
                controller: TextEditingController(text: _selected_manual_bank_proof_upload_Path),
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
          Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, bottom: 8, top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 4, 78, 73)),
                     onPressed: () {
                             if (_formKey.currentState!.validate()) {
                              print(_documentController.text);
                              print(_selected_manual_bank_proof_upload_Path);
                              // upload_Verify();
                            if (_selected_manual_bank_proof_upload_Path.isNotEmpty) {
              // Check if the selected file is not empty
              upload_Verify();
            
            } else {
              // Show a Snackbar or alert indicating that the file is empty
              _showSnackBar(
                context,
                "Please select a file before proceeding",
              );
            }
          }
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
          )
      )
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
