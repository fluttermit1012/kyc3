// ignore_for_file: camel_case_types, avoid_print, equal_keys_in_map, prefer_const_constructors,, unused_element, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:new_kyc_3/common/common.dart';
import 'package:new_kyc_3/personal_page/nominee/nm_1.dart';
import 'package:new_kyc_3/personal_page/nominee/nm_2.dart';
import 'package:new_kyc_3/personal_page/nominee/nm_3.dart';




class nomination_page extends StatefulWidget {
  const nomination_page({Key? key}) : super(key: key);
  
  @override
  State<nomination_page> createState() => _nomination_pageState();
}


class _nomination_pageState extends State<nomination_page> {
   bool _checkbox1 = false;
  bool _fornomination = false;
  final List<bool> isSelected = [true, false, false];
  int _currentindex = 0;
  final List<Widget> formgroups = [
    const nominee1(),
    // const nominee2(),
    // const nominee3(),
    // Add more form groups as needed
  ];
//   void addnominee() {
//   if (_currentindex < formgroups.length - 1) {
//     if (_validateCurrentNominee()) {
//       setState(() {
//         _currentindex++;
//         formgroups.add(buildNominee(_currentindex));
//       });
//     }
//   } else {
//     // Handle the case when you have reached the maximum number of nominees.
//   }
// }
 void addnominee() {
    if (_currentindex < 2) {
      setState(() {
        _currentindex++;
        formgroups.add(buildNominee(_currentindex));
      });
    }
  }

   bool _validateCurrentNominee() {
    if (_currentindex == 0) {
      return formkey1.currentState!.validate();
    } else if (_currentindex == 1) {
      return formkey2.currentState!.validate();
    } else if (_currentindex == 2) {
      return formkey3.currentState!.validate();
    }
    return false;
  }

// void removeNominee(int index) {
//   if (index >= 0 && index < formgroups.length) {
//     setState(() {
//       formgroups.removeAt(index);
//       isSelected.removeAt(index);
//       if (_currentindex >= index) {
//         _currentindex--;
//       }
//     });
//   }
// }

 void removeNominee(int index) {
    if (formgroups.length > 1 && index >= 0 && index < formgroups.length) {
      setState(() {
        formgroups.removeAt(index);
        _currentindex--;
      });
    }
  }

   Widget buildNominee(int index) {
    if (index == 0) {
      return const nominee1();
    } else if (index == 1) {
      return const nominee2();
    } else if (index == 2) {
      return const nominee3();
    }
    return Container(); // You can return an empty container or handle this case as needed.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Image.asset(
          'assets/logo6.png',
          height: 80.h,
          width: 190.w,
        ),
           automaticallyImplyLeading: true,
           iconTheme: IconThemeData(
    color: theme_color, // Set the color you desire
  ),
        elevation: 0,
         actions: [
          TextButton.icon(
            onPressed: () {
              // Add More Nominee functionality here
              addnominee();
            },
            icon: Icon(
              Icons.add,
              size: 10.sp,
              color: theme_color,
            ),
            label: Text(
              '    Add\nNominee',
              style: TextStyle(
                color: theme_color,
                fontSize: 10.sp,
              ),
            ),
          ),
        ],

      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Transform.scale(
                  scale: 1.sp,
                  child: Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.all(txt_color2),
                    value: _checkbox1,
                    onChanged: (bool? value) {
                      setState(() {
                        _fornomination = !_fornomination;
                        _checkbox1 = value!;
                      });
                    },
                  ),
                ),
                comman().txt(
                  text: 'Declaration from for opting out of nomination!',
                  size: 12.sp,
                ),
              ],
            ),
            _fornomination
                ? Padding(
                    padding: EdgeInsets.all(12.0.r),
                    child: Container(
                      height: 180.h,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: theme_color),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              globle.forn = false;
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 3.0,
                                  spreadRadius: 3.0,
                                  offset: Offset(
                                    1.0,
                                    2.0,
                                  ),
                                ),
                              ],
                              color: button_color,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(100),
                              ),
                              border: Border.all(width: 1, color: Colors.black),
                            ),
                            child: Center(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: 'Gotham',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TextButton.icon(
                      //   onPressed: () {
                      //     nextPage();
                      //   },
                      //   icon: Icon(
                      //     Icons.add,
                      //     size: 20.sp,
                      //     color: theme_color,
                      //   ),
                      //   label: comman().txt(
                      //     text: 'Add More Nominee',
                      //     size: 12.sp,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                        
                      for (int i = 0; i < formgroups.length; i++) ...[
              if (i > 0) // Only show for nominee 2 and 3
                Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(theme_color),
                      ),
                      onPressed: () {
                        removeNominee(i);
                      },
                      child: Text('Remove Nominee ${i + 1}', style: TextStyle(fontSize: 12, fontFamily: "Gotham"),),
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(
                  top: 8.h,
                  bottom: 8.h,
                  right: 8.w,
                ),
                child: buildNominee(i),
              ),],
                      // for (int i = 0; i <= _currentindex; i++)
                      //   Padding(
                      //     padding: EdgeInsets.only(
                      //       top: 8.h,
                      //       bottom: 8.h,
                      //       right: 8.w,
                      //     ),
                      //     child: formgroups[i],
                      //   ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _currentindex == 0 && errorMessage1 != null
                            ? Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.info,
                                      size: 18.sp,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      errorMessage1!,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : null,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _currentindex == 1 && errorMessage2 != null
                            ? Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.info,
                                      size: 18.sp,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      errorMessage2!,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : null,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _currentindex == 2 && errorMessage3 != null
                            ? Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.info,
                                      size: 18.sp,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      errorMessage3!,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : null,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
              //           if (totalShareExceeds100)
              // Text(
              //   'Total share percentage cannot exceed 100',
              //   style: TextStyle(color: Colors.red),
              // ),
              SizedBox(
                        height: 8.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 50.h,
                          width: 120.w,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(100),
                                    topLeft: Radius.circular(100),
                                  ),
                                ),
                              ),
                              elevation: MaterialStateProperty.all(10),
                              backgroundColor: MaterialStateProperty.all(
                                button_color,
                              ),
                            ),
                            onPressed: () {
                                // double totalSharePercentage = calculateTotalSharePercentage();
                          print(globle.name1);
print(globle.share1);
print(globle.relation1);
print(globle.add1_1);
print(globle.add2_1);
print(globle.add3_1);
print(globle.city1);
print(globle.country1);
print(globle.state1);
print(globle.mobile1);
print(globle.email1);
print(globle.date1);
print(globle.proof1);
print(globle.proofnumber1);
print(globle.nominee_1_ImageFile);
print(globle.name2);
print(globle.share2);
print(globle.relation2);
print(globle.add1_2);
print(globle.add2_2);
print(globle.add3_2);
print(globle.city2);
print(globle.country2);
print(globle.state2);
print(globle.mobile2);
print(globle.email2);
print(globle.date2);
print(globle.proof2);
print(globle.proofnumber2);
print(globle.nominee_2_ImageFile);
print(globle.name3);
print(globle.share3);
print(globle.relation3);
print(globle.add1_3);
print(globle.add2_3);
print(globle.add3_3);
print(globle.city3);
print(globle.country3);
print(globle.state3);
print(globle.mobile3);
print(globle.email3);
print(globle.date3);
print(globle.proof3);
print(globle.proofnumber3);
print(globle.nominee_3_ImageFile);
                              if (_currentindex == 0 &&
                                  formkey1.currentState!.validate()) {
                                print("nominee 1 calling....");
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nominee Details Upload "))).closed.then((value) => Navigator.pop(context));

                              }else  if (_currentindex == 1 && formkey1.currentState!.validate() &&
                                  formkey2.currentState!.validate()) {
                                print("nominee 2 calling....");
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nominee Details Upload "))).closed.then((value) => Navigator.pop(context));
                              
                              }else  if (_currentindex == 2 && formkey1.currentState!.validate() &&formkey2.currentState!.validate() &&
                                  formkey3.currentState !.validate()) {
                                print("nominee 3 calling....");
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nominee Details Upload "))).closed.then((value) => Navigator.pop(context));
                               
                              } else {
                                print('error');
                              }
                            },
                  //            if (_currentindex == 0 && formkey1.currentState!.validate()) {
                  //     if (totalSharePercentage <= 100) {
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //           SnackBar(content: Text("Nominee 1 Details Uploaded")));
                  //     } else {
                  //       totalShareExceeds100 = true;
                  //     }
                  //   } else if (_currentindex == 1 &&
                  //       formkey2.currentState!.validate()) {
                  //     if (totalSharePercentage <= 100) {
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //           SnackBar(content: Text("Nominee 2 Details Uploaded")));
                  //     } else {
                  //       totalShareExceeds100 = true;
                  //     }
                  //   } else if (_currentindex == 2 &&
                  //       formkey3.currentState!.validate()) {
                  //     if (totalSharePercentage <= 100) {
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //           SnackBar(content: Text("Nominee 3 Details Uploaded")));
                  //     } else {
                  //       totalShareExceeds100 = true;
                  //     }
                  //   } else {
                  //     print('error');
                  //   }
                  //   setState(() {});
                  // },
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: 'Gotham',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
 // import 'package:flutter/material.dart';
// import 'package:new_kyc_3/commanwidget.dart';
// import 'package:new_kyc_3/nomination/nominee1.dart';
// import 'package:new_kyc_3/nomination/nominee2.dart';
// import 'package:new_kyc_3/nomination/nominee3.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';

// class nomination_page123 extends StatefulWidget {
//   const nomination_page123({Key? key}) : super(key: key);
  
//   @override
//   State<nomination_page123> createState() => _nomination_page123State();
// }

// class _nomination_page123State extends State<nomination_page123> {
//   bool _checkbox1 = false;
//   bool _fornomination = false;
//   final List<bool> isSelected = [true, false, false];
//   int _currentindex = 0;
//   final List<Widget> formgroups = [
//     const nominee1(),
//     const nominee2(),
//     const nominee3(),
//   ];

// //   void addnominee() {
// //   if (_currentindex < formgroups.length - 1) {
// //     if (_validateCurrentNominee()) {
// //       setState(() {
// //         _currentindex++;
// //         formgroups.add(buildNominee(_currentindex));
// //       });
// //     }
// //   } else {
   
// //   }
// // }
// void addnominee() {
//     if (_currentindex < formgroups.length - 1) {
//       if (_validateCurrentNominee()) {
//         setState(() {
//           _currentindex++;
//         });
//       }
//     } else if (_currentindex < 2) {
//       setState(() {
//         _currentindex++;
//         formgroups.add(buildNominee(_currentindex));
//       });
//     }
//   }
//   void removeNominee(int index) {
//     if (formgroups.length > 1 && index >= 0 && index < formgroups.length) {
//       setState(() {
//         formgroups.removeAt(index);
//         if (_currentindex >= index) {
//           _currentindex--;
//         }
//       });
//     }
//   }
// bool _validateCurrentNominee() {
//     if (_currentindex == 0) {
//       return formkey1.currentState!.validate();
//     } else if (_currentindex == 1) {
//       return formkey2.currentState!.validate();
//     } else if (_currentindex == 2) {
//       return formkey3.currentState!.validate();
//     }
//     return false;
//   }


//   // bool _validateCurrentNominee() {
//   //   if (_currentindex == 0) {
//   //     return formkey1.currentState!.validate();
//   //   } else if (_currentindex == 1) {
//   //     return formkey2.currentState!.validate();
//   //   } else if (_currentindex == 2) {
//   //     return formkey3.currentState!.validate();
//   //   }
//   //   return false;
//   // }

// // void removeNominee(int index) {
// //   if (formgroups.length > 1 && index >= 0 && index < formgroups.length) {
// //     setState(() {
// //       formgroups.removeAt(index);
// //       isSelected.removeAt(index);
// //       if (_currentindex >= index) {
// //         _currentindex--;
// //       }
// //     });
// //   }
// // }

//   Widget buildNominee(int index) {
//     if (index == 0) {
//       return const nominee1();
//     } else if (index == 1) {
//       return const nominee2();
//     } else if (index == 2) {
//       return const nominee3();
//     }
//     return Container(); // You can return an empty container or handle this case as needed.
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
     
//         backgroundColor: Colors.transparent,
//         centerTitle: true,
//         title: Image.asset(
//           'assets/logo6.png',
//           height: 80.h,
//           width: 190.w,
//         ),
//            automaticallyImplyLeading: true,
//            iconTheme: IconThemeData(
//     color: theme_color, // Set the color you desire
//   ),
//         elevation: 0,
//          actions: [
//           SizedBox(
//             height: 80.h,
//             width: 90.w,
//             child: TextButton.icon(
//               onPressed: () {
//                 // Add More Nominee functionality here
//                 addnominee();
//               },
//               icon: Icon(
//                 Icons.add,
//                 size: 17.sp,
//                 color: theme_color,
//               ),
//               label: Text(
//                 'Add More Nominee',
//                 style: TextStyle(
//                   color: theme_color,
//                   fontSize: 10.sp,
//                 ),
//               ),
//             ),
//           ),
//         ],

//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 20.h,
//             ),
//             Row(
//               children: [
//                 Transform.scale(
//                   scale: 1.sp,
//                   child: Checkbox(
//                     checkColor: Colors.white,
//                     fillColor: MaterialStateProperty.all(txt_color2),
//                     value: _checkbox1,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         _fornomination = !_fornomination;
//                         _checkbox1 = value!;
//                       });
//                     },
//                   ),
//                 ),
//                 comman().txt(
//                   text: 'Declaration from for opting out of nomination!',
//                   size: 12.sp,
//                 ),
//               ],
//             ),
//             _fornomination
//                 ? Padding(
//                     padding: EdgeInsets.all(12.0.r),
//                     child: Container(
//                       height: 180.h,
//                       decoration: BoxDecoration(
//                         border: Border.all(width: 1, color: theme_color),
//                       ),
//                       child: Center(
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             height: 50.h,
//                             width: 120.w,
//                             decoration: BoxDecoration(
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: Colors.black54,
//                                   blurRadius: 3.0,
//                                   spreadRadius: 3.0,
//                                   offset: Offset(
//                                     1.0,
//                                     2.0,
//                                   ),
//                                 ),
//                               ],
//                               color: button_color,
//                               borderRadius: const BorderRadius.all(
//                                 Radius.circular(100),
//                               ),
//                               border: Border.all(width: 1, color: Colors.black),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 'Next',
//                                 style: TextStyle(
//                                   fontSize: 18.sp,
//                                   fontFamily: 'Gotham',
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 : Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
                   
//                       // for (int i = 0; i <= _currentindex; i++) ...[
//                         for (int i = 0; i < formgroups.length; i++) ...[
//               if (i > 0) // Only show for nominee 2 and 3
//                 Padding(
//                   padding: EdgeInsets.all(8.0.r),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(theme_color),
//                       ),
//                       onPressed: () {
//                         removeNominee(i);
//                       },
//                       child: Text('Remove Nominee ${i + 1}', style: TextStyle(fontSize: 12, fontFamily: "Gotham"),),
//                     ),
//                   ),
//                 ),
//               Padding(
//                 padding: EdgeInsets.only(
//                   top: 8.h,
//                   bottom: 8.h,
//                   right: 8.w,
//                 ),
//                 child: buildNominee(i),
//               ),
//                       // for (int i = 0; i <= _currentindex; i++)
//                       //   Padding(
//                       //     padding: EdgeInsets.only(
//                       //       top: 8.h,
//                       //       bottom: 8.h,
//                       //       right: 8.w,
//                       //     ),
//                       //     child: formgroups[i],
//                       //   ),
//                       SizedBox(
//                         height: 12.h,
//                       ),
//                       // Align(
//                       //   alignment: Alignment.centerRight,
//                       //   child: _currentindex == 0 && errorMessage1 != null
//                       //       ? Padding(
//                       //           padding: const EdgeInsets.only(left: 5.0),
//                       //           child: Row(
//                       //             children: [
//                       //               Icon(
//                       //                 Icons.info,
//                       //                 size: 18.sp,
//                       //                 color: Colors.red,
//                       //               ),
//                       //               SizedBox(
//                       //                 width: 5.w,
//                       //               ),
//                       //               Text(
//                       //                 errorMessage1!,
//                       //                 style: TextStyle(
//                       //                   color: Colors.red,
//                       //                   fontSize: 13.sp,
//                       //                 ),
//                       //               ),
//                       //             ],
//                       //           ),
//                       //         )
//                       //       : null,
//                       // ),
//                       // Align(
//                       //   alignment: Alignment.centerRight,
//                       //   child: _currentindex == 1 && errorMessage2 != null
//                       //       ? Padding(
//                       //           padding: const EdgeInsets.only(left: 5.0),
//                       //           child: Row(
//                       //             children: [
//                       //               Icon(
//                       //                 Icons.info,
//                       //                 size: 18.sp,
//                       //                 color: Colors.red,
//                       //               ),
//                       //               SizedBox(
//                       //                 width: 5.w,
//                       //               ),
//                       //               Text(
//                       //                 errorMessage2!,
//                       //                 style: TextStyle(
//                       //                   color: Colors.red,
//                       //                   fontSize: 13.sp,
//                       //                 ),
//                       //               ),
//                       //             ],
//                       //           ),
//                       //         )
//                       //       : null,
//                       // ),
//                       // Align(
//                       //   alignment: Alignment.centerRight,
//                       //   child: _currentindex == 2 && errorMessage3 != null
//                       //       ? Padding(
//                       //           padding: const EdgeInsets.only(left: 5.0),
//                       //           child: Row(
//                       //             children: [
//                       //               Icon(
//                       //                 Icons.info,
//                       //                 size: 18.sp,
//                       //                 color: Colors.red,
//                       //               ),
//                       //               SizedBox(
//                       //                 width: 5.w,
//                       //               ),
//                       //               Text(
//                       //                 errorMessage3!,
//                       //                 style: TextStyle(
//                       //                   color: Colors.red,
//                       //                   fontSize: 13.sp,
//                       //                 ),
//                       //               ),
//                       //             ],
//                       //           ),
//                       //         )
//                       //       : null,
//                       // ),
//                       // SizedBox(
//                       //   height: 8.h,
//                       // ),
//               //           if (totalShareExceeds100)
//               // Text(
//               //   'Total share percentage cannot exceed 100',
//               //   style: TextStyle(color: Colors.red),
//               // ),
//                  ],
//                     ]
//                   ),
//               SizedBox(
//                         height: 8.h,
//                       ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: SizedBox(
//                           height: 50.h,
//                           width: 120.w,
//                           child: ElevatedButton(
//                             style: ButtonStyle(
//                               shape: MaterialStateProperty.all(
//                                 const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular(100),
//                                     topLeft: Radius.circular(100),
//                                   ),
//                                 ),
//                               ),
//                               elevation: MaterialStateProperty.all(10),
//                               backgroundColor: MaterialStateProperty.all(
//                                 button_color,
//                               ),
//                             ),
//                             onPressed: () {
//                                 // double totalSharePercentage = calculateTotalSharePercentage();
//                           print(globle.name1);
// print(globle.share1);
// print(globle.relation1);
// print(globle.add1_1);
// print(globle.add2_1);
// print(globle.add3_1);
// print(globle.city1);
// print(globle.country1);
// print(globle.state1);
// print(globle.mobile1);
// print(globle.email1);
// print(globle.date1);
// print(globle.proof1);
// print(globle.proofnumber1);
// print(globle.nominee_1_ImageFile);
// print(globle.name2);
// print(globle.share2);
// print(globle.relation2);
// print(globle.add1_2);
// print(globle.add2_2);
// print(globle.add3_2);
// print(globle.city2);
// print(globle.country2);
// print(globle.state2);
// print(globle.mobile2);
// print(globle.email2);
// print(globle.date2);
// print(globle.proof2);
// print(globle.proofnumber2);
// print(globle.nominee_2_ImageFile);
// print(globle.name3);
// print(globle.share3);
// print(globle.relation3);
// print(globle.add1_3);
// print(globle.add2_3);
// print(globle.add3_3);
// print(globle.city3);
// print(globle.country3);
// print(globle.state3);
// print(globle.mobile3);
// print(globle.email3);
// print(globle.date3);
// print(globle.proof3);
// print(globle.proofnumber3);
// print(globle.nominee_3_ImageFile);
//                               if (_currentindex == 0 &&
//                                   formkey1.currentState!.validate()) {
//                                 print("nominee 1 calling....");
//                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nominee Details Upload "))).closed.then((value) => Navigator.pop(context));

//                               }else  if (_currentindex == 1 &&
//                                   formkey2.currentState!.validate()) {
//                                 print("nominee 2 calling....");
//                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nominee Details Upload "))).closed.then((value) => Navigator.pop(context));
                              
//                               }else  if (_currentindex == 2 &&
//                                   formkey3.currentState !.validate()) {
//                                 print("nominee 3 calling....");
//                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nominee Details Upload "))).closed.then((value) => Navigator.pop(context));
                               
//                               } else {
//                                 print('error');
//                               }
//                             },
//                   //            if (_currentindex == 0 && formkey1.currentState!.validate()) {
//                   //     if (totalSharePercentage <= 100) {
//                   //       ScaffoldMessenger.of(context).showSnackBar(
//                   //           SnackBar(content: Text("Nominee 1 Details Uploaded")));
//                   //     } else {
//                   //       totalShareExceeds100 = true;
//                   //     }
//                   //   } else if (_currentindex == 1 &&
//                   //       formkey2.currentState!.validate()) {
//                   //     if (totalSharePercentage <= 100) {
//                   //       ScaffoldMessenger.of(context).showSnackBar(
//                   //           SnackBar(content: Text("Nominee 2 Details Uploaded")));
//                   //     } else {
//                   //       totalShareExceeds100 = true;
//                   //     }
//                   //   } else if (_currentindex == 2 &&
//                   //       formkey3.currentState!.validate()) {
//                   //     if (totalSharePercentage <= 100) {
//                   //       ScaffoldMessenger.of(context).showSnackBar(
//                   //           SnackBar(content: Text("Nominee 3 Details Uploaded")));
//                   //     } else {
//                   //       totalShareExceeds100 = true;
//                   //     }
//                   //   } else {
//                   //     print('error');
//                   //   }
//                   //   setState(() {});
//                   // },
//                             child: Text(
//                               'ADD',
//                               style: TextStyle(
//                                 fontSize: 15.sp,
//                                 fontFamily: 'Gotham',
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 8.h,
//                       ),
                 
//           ],
//         ),
//       ),
//     );
//   }
// }
  