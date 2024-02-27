import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:new_kyc_3/common/common.dart';
import 'package:new_kyc_3/global.dart';

class Esignpage extends StatefulWidget {
  final int? accset;
  final TextEditingController brokname;
  final int? pastaction;

  const Esignpage({
    Key? key,
    required this.accset,
    required this.brokname,
    required this.pastaction,
  }) : super(key: key);

  @override
  State<Esignpage> createState() => _EsignpageState();
}

class _EsignpageState extends State<Esignpage> {
  late Uint8List requestBody;

  InAppWebView _loadWebView() {
    requestBody = Uint8List.fromList(utf8.encode(jsonEncode({
      "pan_card": "",
      "account_type": "Individual",
      "session_pan": globle.pancard_dob,
      "past_action": widget.pastaction == 0 ? "Yes" : "No",
      "broker_name": widget.brokname.text,
      "runnning_account_settelment":
          widget.accset == 0 ? "quarterly" : "monthly",
      "geo_latitude": "21.185890",
      "geo_longitude": "72.810287",
      "download_pdf_type": "",
      "mobile": "Yes"
    })));

    final webView = InAppWebView(
      initialUrlRequest: URLRequest(
        url: Uri.parse("http://connect.arhamshare.com:9090/EAPI/esign_pdf"),
        method: 'POST',
        body: requestBody,
      ),
      onReceivedServerTrustAuthRequest: (controller, challenge) async {
        return ServerTrustAuthResponse(
          action: ServerTrustAuthResponseAction.PROCEED,
        );
      },
      onLoadStop: (controller, url) async {
        if (url.toString() ==
            "http://connect.arhamshare.com:9090/EAPI/esign_pdf") {}
      },
    );

    return webView;
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  Widget _buildScaffold() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Image.asset(
          "assets/logo6.png",
          height: 35,
          fit: BoxFit.fill,
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          const Text("Enter Your Aadhar To eSign and Verify"),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.25,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Global.fc, width: 1.5),
              ),
              child: _loadWebView(),
            ),
          ),
        ],
      ),
    );
  }
}
