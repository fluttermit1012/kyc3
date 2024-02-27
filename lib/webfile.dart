// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// class MyInAppWebView extends StatefulWidget {
//   const MyInAppWebView({super.key});

//   @override
//   _MyInAppWebViewState createState() => _MyInAppWebViewState();
// }

// class _MyInAppWebViewState extends State<MyInAppWebView> {
//   bool isLoading = true;
//   InAppWebViewController? webViewController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
     
//       body:
//       // isLoading
//       //       ? Center(
//       //           child: SpinKitSquareCircle(
//       //               color: Color.fromARGB(194, 4, 78, 73), size: 30.0)):
//        InAppWebView(
//         initialUrlRequest: URLRequest(url: Uri.parse('http://connect.arhamshare.com:9090/EAPI/esign')), // Replace with your URL
//         onWebViewCreated: (controller) {
//           webViewController = controller;
//         },
//       )
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyInAppWebView extends StatefulWidget {
  const MyInAppWebView({Key? key}) : super(key: key);

  @override
  _MyInAppWebViewState createState() => _MyInAppWebViewState();
}

class _MyInAppWebViewState extends State<MyInAppWebView> {
  bool isLoading = true;
  InAppWebViewController? webViewController;

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
      body: Stack(
        children: [
          SizedBox(height: 50,),
          InAppWebView(
            initialUrlRequest: URLRequest(
              
              // url: Uri.parse('http://connect.arhamshare.com:9090/EAPI/esign'),
              url:Uri.parse('https://patiyalashop.com/')
             
            ),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              print('WebView is loading: $url');
            },
            onLoadStop: (controller, url) {
              print('WebView has finished loading: $url');
              setState(() {
                isLoading = false;
              });
            },
            onLoadError: (controller, url, code, message) {
              print('WebView error - Code: $code, Message: $message');
              setState(() {
                isLoading = false;
              });
            },
          ),
          if (isLoading)
            Center(
              child: SpinKitSquareCircle(
                color: Color.fromARGB(194, 4, 78, 73),
                size: 30.0,
              ),
            ),
        ],
      ),
    );
  }
}
