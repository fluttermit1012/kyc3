// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';


import 'package:new_kyc_3/common/common.dart';
import 'package:new_kyc_3/signature_selfie/signature___.dart';
import 'package:new_kyc_3/trading_prefence/trading_preference.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  Color fc = const Color(0xff073935);
  final ImagePicker _picker = ImagePicker();
  bool imgpreview = true;
  XFile? _image;
  String? _imageFilePath;
  String? _encodedImageText;

  String signaturm = "";

  Future<void> _sendImageToApi(String imagePath) async {
    try {
      // showDialog(
      //   context: context,
      //   barrierDismissible: false,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       content: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           SpinKitCircle(color: fc),
      //           const SizedBox(height: 10),
      //           const Text(
      //             "Please Wait...",

      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // );
      final response = await http.post(
        Uri.parse(
            'http://connect.arhamshare.com:9090/EAPI/SignatureAndSelfieUpload'),
        body: <String, String>{
          "pan_card": "",
          "account_type": "Individual",
          "select_option_live_upload": "Camera_capture",
          "session_pan": 'AMUPU4253H',
          "Camera_capture_data": imagePath,
          "select_option_sign": "",
          "base64encodeImageSign": "",
          "WindWidth": "",
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data['base64encodeImageSign']);
        print(response.body);
        print('123456789012345678901234567890');
      } else {
        print(
            "----------------------/////////////////////////--------------------------///////////////");
      }
    } catch (e) {
      return;
    }
  }

  Future<void> _cameraImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        final bytes = await image.readAsBytes();
        List<int> compressedBytes = await FlutterImageCompress.compressWithList(
          bytes,
          minHeight: 800,
          minWidth: 600,
          quality: 70,
        );
        final img.Image imag =
            img.decodeImage(Uint8List.fromList(compressedBytes))!;
        final encodedBytes = img.encodeJpg(imag);
        final base64String = base64Encode(encodedBytes);
        setState(() {
          _image = image;
          _encodedImageText = base64String;
          imgpreview = false;
          print(_encodedImageText);
        });
        await _sendImageToApi(_encodedImageText!);
      }
    } catch (e) {
      print('Error in _getImage: $e');
    }
  }

  Future<void> _showImageAlertDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Your Selected Image",
          ),
          content: Image.file(
            File(_image!.path),
            fit: BoxFit.contain,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Retry",
              ),
            ),
            TextButton(
              onPressed: () {
                _sendImageToApi;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => trading_preference()));
              },
              child: const Text(
                "Save",
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> getOTPimage(String signaturm, String filePath) async {
    if (_imageFilePath == null) {
      print('No image selected');
      return;
    }
    Uri url = Uri.parse(
        'http://connect.arhamshare.com:9090/EAPI/SignatureAndSelfieUpload');
    var request = http.MultipartRequest('POST', url);

    request.fields['pan_card'] = '';
    request.fields['account_type'] = 'Individual';
    request.fields['select_option_live_upload'] = 'Upload_image';
    request.fields['session_pan'] = globle.pancard_dob;
    request.fields['Camera_capture_data'] = '';
    request.fields['select_option_sign'] = '';
    request.fields['base64encodeImageSign'] = '';
    request.fields['WindWidth'] = '';
    request.fields['otp_img_upload'] = '';
    request.fields['signature_upload'] = '';

    if (filePath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
        'otp_img_upload',
        _imageFilePath!,
        contentType: MediaType('image', 'jpg'),
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
                const Text(
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
      type: FileType.image,
      // allowedExtensions: ['jpg'],
    );

    if (result != null) {
      final filePath = result.files.single.path;
      if (filePath != null && filePath.isNotEmpty) {
        setState(() {
          _image = XFile(filePath);
          _imageFilePath = filePath;
        });
        await getOTPimage(signaturm, filePath);
        _imagDialog();
      }
    }
  }

  void _imagDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "This is your Image",
          ),
          content: _image != null
              ? Image.file(
                  File(_image!.path),
                  fit: BoxFit.contain,
                )
              : const Text(
                  'No image selected',
                ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Retry",
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const trading_preference(),
                  )),
              child: const Text(
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
    onPressed: () {
    Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => SignaturePage()),
);
  }, icon: Icon(Icons.arrow_back_sharp,color: theme_color,)),
          centerTitle: true,
        //  automaticallyImplyLeading: false,
          title: Image.asset(
            "assets/logo6.png",
            height: 35,
            fit: BoxFit.fill,
          ),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: Stack(
          children: [
            const Align(
              alignment: Alignment(0, -0.92),
              child: Text(
                "Select The Camera Capture Or Upload Image",
              ),
            ),
            Align(
              alignment: const Alignment(0, -0.8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: _cameraImage,
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: fc,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        "Capture Camera",
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
                      child: const Text(
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        "Upload Image",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.2),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.7,
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(6)),
                margin: const EdgeInsets.all(25),
                child: imgpreview
                    ? Image.asset(
                        "assets/logo6.png",
                        fit: BoxFit.contain,
                      )
                    : (_image != null
                        ? Image.file(
                            File(_image!.path),
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            "assets/logo6.png",
                            fit: BoxFit.contain,
                          )),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.9),
              child: Row(
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
                        child: const Text(
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          "Previous",
                        )),
                  ),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: _showImageAlertDialog,
                    child: Container(
                      height: 45,
                      width: 90,
                      decoration: BoxDecoration(
                          color: fc,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                      alignment: Alignment.center,
                      child: const Text(
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        "Next",
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.only(bottom: 14, left: 7, right: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NOTE:",
              ),
              Expanded(
                child: Text(
                  "Please write received Email OTP on a piece of paper and take the selfie with that paper in order to complete in-person Verification",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
