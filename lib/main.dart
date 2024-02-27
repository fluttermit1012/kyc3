import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import 'package:new_kyc_3/example.dart';

import 'package:new_kyc_3/first_screen/first_screen.dart';


import 'package:new_kyc_3/newpage.dart';


import 'package:new_kyc_3/personal_page/finall_personal_details.dart';
import 'package:new_kyc_3/personaldetails_.dart';
import 'package:new_kyc_3/signature_selfie/signature___.dart';

import 'package:new_kyc_3/webfile.dart';
import 'package:loading_animations/loading_animations.dart';

final storage = GetStorage();
void main() async {
  await GetStorage.init();
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              theme: ThemeData(
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontFamily: 'Gotham', // Use the font family you specified
                    fontSize: 16.0, // Set the default font size
                    fontWeight:
                        FontWeight.normal, // Set the default font weight
                  ),
                  // Define more text styles as needed
                ),
              ),
              debugShowCheckedModeBanner: false,
              title: '871',
              home: spalsh());
        });
  }
}

class spalsh extends StatefulWidget {
  const spalsh({super.key});

  @override
  State<spalsh> createState() => _spalshState();
}

class _spalshState extends State<spalsh> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (context) =>
          // SignaturePage()
           FirstScreen()

              // fin_personal_details()

              ));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo6.png', width: 250),
            SizedBox(
              height: 50,
            ),
            LoadingFadingLine.circle(
              backgroundColor: Color.fromARGB(195, 4, 78, 73),
              borderColor: Color.fromARGB(195, 4, 78, 73),
              size: 30.0,
            )
          ],
        ),
      ),
    );
  }
}
