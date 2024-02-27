// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors, , avoid_print, unused_field, non_constant_identifier_names, file_names
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:new_kyc_3/common/common.dart';
import 'package:new_kyc_3/signature_selfie/camera___.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'dart:ui';
import 'dart:io';

class SignaturePage extends StatefulWidget {
  const SignaturePage({Key? key});

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  final ImagePicker _picker = ImagePicker();
  File? _upload_Image;
  final String _upload_Sign = "";
  XFile? _image;
  String? _imageFilePath;
  bool _isCapturingSignature = true;
  String? encodedImageText;
  bool isUploading = false;
  String pan = "";
  String acty = "Individual";
  String liveu = "Camera_capture";
  String seccion = "AMUPU4253H";
  String camerad = "";
  String optionss = "tap_signature";
  String signaturm = "";
  String width = "";
  String signImg = "";
  String otpImg = "";
  Color fc =const Color(0xff073935);
  GlobalKey<SfSignaturePadState> signaturePageStatekey = GlobalKey();

  Future<void> uploadSignature(String signaturm) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitCircle(color: fc),
                const SizedBox(height: 10),
                Text(
                  "Please Wait...",
                  
                ),
              ],
            ),
          );
        },
      );
      final response = await http.post(
        Uri.parse(
            'http://connect.arhamshare.com:9090/EAPI/SignatureAndSelfieUpload'),
        body: <String, String>{
          "pan_card": pan,
          "account_type": acty,
          "select_option_live_upload": liveu,
          "session_pan": seccion,
          "Camera_capture_data": camerad,
          "select_option_sign": optionss,
          "base64encodeImageSign": signaturm,
          "WindWidth": width,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data['base64encodeImageSign']);
        print(response.body);
        print(
            "//////////////----------------------------------------------$signaturm");
        print(response.statusCode);
      }
    } catch (e) {
      return;
    }
  }

  Future<void> _signaturedialog() async {
    if (signaturePageStatekey.currentState != null) {
      final signatureImage = await signaturePageStatekey.currentState!.toImage(
        pixelRatio: 3.0,
      );
      final ByteData? byteData =
          await signatureImage.toByteData(format: ImageByteFormat.png);

      if (byteData != null) {
        final buffer = byteData.buffer.asUint8List();

        final compressedBuffer = await FlutterImageCompress.compressWithList(
          buffer,
          minHeight: 800,
          minWidth: 600,
          quality: 70,
        );

        final base64String = base64Encode(compressedBuffer);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                "This is your Signature",
               
              ),
              content: Image.memory(
                Uint8List.fromList(compressedBuffer),
                fit: BoxFit.contain,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Retry"
                   
                  ),
                ),
                TextButton(
                  onPressed: () {
                    uploadSignature(base64String);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CameraPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Save"
                    
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> sendImageAndSignature(String signaturm, String filePath) async {
    if (_imageFilePath == null) {
      print('No image selected');
      return;
    }
    Uri url = Uri.parse(
        'http://connect.arhamshare.com:9090/EAPI/SignatureAndSelfieUpload');
    var request = http.MultipartRequest('POST', url);

    request.fields['pan_card'] = '';
    request.fields['account_type'] = 'Individual';
    request.fields['select_option_live_upload'] = 'Upload_imager';
    request.fields['session_pan'] = 'AMUPU4253H';
    request.fields['Camera_capture_data'] = '';
    request.fields['select_option_sign'] = '';
    request.fields['base64encodeImageSign'] = '';
    request.fields['WindWidth'] = '';
    request.fields['otp_img_upload'] = '';
    request.fields['signature_upload'] = '';

    if (filePath.isNotEmpty) {
      final contentType = _imageFilePath!.toLowerCase().endsWith('.pdf')
          ? MediaType('application', 'pdf')
          : MediaType('image', 'jpeg');

      request.files.add(await http.MultipartFile.fromPath(
        'signature_upload',
        _imageFilePath!,
        contentType: contentType,
      ));
    }

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitCircle(color: fc),
                const SizedBox(height: 10),
                Text(
                  "Please Wait...",
                 
                ),
              ],
            ),
          );
        },
      );
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image and Signature sent successfully');
        var responseDATA = await response.stream.bytesToString();
        var error = jsonDecode(responseDATA)['error'];
        var errorcode = jsonDecode(responseDATA)['errorCode'];
        print(error);
        print(errorcode);
      } else {
        print(
            'Error sending image and signature. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending image and signature: $error');
    }
  }

  Future<void> getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null) {
      final filePath = result.files.single.path;
      if (filePath != null && filePath.isNotEmpty) {
        final compressedImagePath = await compressImage(filePath);
        setState(() {
          _image = XFile(compressedImagePath);
          _imageFilePath = compressedImagePath;
        });
        await sendImageAndSignature(signaturm, compressedImagePath);
        _imagDialog();
      }
    }
  }

  Future<String> compressImage(String inputPath) async {
    final outputPath = '${inputPath}_compressed.jpg';
    final result = await FlutterImageCompress.compressAndGetFile(
      inputPath,
      outputPath,
      quality: 50,
    );

    return result!.path;
  }

  Future<void> _imagDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "This is your Image",
           
          ),
          content: _image != null
              ? Image.file(
                  File(_image!.path),
                  fit: BoxFit.contain,
                )
              : Text(
                  'No image selected',
                 
                ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Retry",
                
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraPage(),
                  )),
              child: Text(
                "Save",
                
              ),
            ),
          ],
        );
      },
    );
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
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Draw your Signature or upload from gallery",
            
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isCapturingSignature = true;
                  });
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: fc,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Signature", style: TextStyle(color: Colors.white),
                    
                  ),
                ),
              ),
              GestureDetector(
                onTap: getImage,
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: fc,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Gallery", style: TextStyle(color: Colors.white)
                    
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.7,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5,
                  )),
              child: _isCapturingSignature
                  ? SfSignaturePad(
                      key: signaturePageStatekey,
                      minimumStrokeWidth: 4,
                      maximumStrokeWidth: 5,
                      strokeColor: Colors.black,
                      backgroundColor: Colors.white,
                    )
                  : (_image != null
                      ? Image.file(
                          File(_image!.path),
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.contain,
                        )
                      : Center(
                          child: Text(
                            'Upload Your Signature or Image',
                            
                          ),
                        )),
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (_isCapturingSignature) {
                signaturePageStatekey.currentState!.clear();
              }
            },
            child: Container(
              margin: const EdgeInsets.only(left: 12, right: 12),
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: fc, width: 1.5)),
              alignment: Alignment.center,
              child: Text(
                "Clear Signature",
                
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                    height: 45,
                    width: 90,
                    decoration: BoxDecoration(
                        color: fc,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    alignment: Alignment.center,
                    child: Text(
                      "Privous", style: TextStyle(color: Colors.white)
                      
                    )),
              ),
              const SizedBox(width: 40),
              GestureDetector(
                onTap: _signaturedialog,
                child: Container(
                  height: 45,
                  width: 90,
                  decoration: BoxDecoration(
                      color: fc,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  alignment: Alignment.center,
                  child: Text(
                    "Next", style: TextStyle(color: Colors.white)
                    
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
