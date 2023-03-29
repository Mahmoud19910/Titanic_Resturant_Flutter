import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resturantapp/modles/category.dart';

import '../shared/componenets/componenet.dart';
import '../shared/data_resource/cloud/cloud_controller.dart';

class OrdersScreen extends StatelessWidget {
   OrdersScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [

            //App Bar
            // Container(
            //   height: 56,
            //   width: MediaQuery.of(context).size.width,
            //   color: Color.fromRGBO(227, 227, 227, 1),
            //   child: Padding(
            //     padding: const EdgeInsets.only(right: 5, left: 5),
            //     child: Row(
            //       children: [
            //         // Notifications
            //         Stack(
            //           children: [
            //             ShaderMask(
            //               shaderCallback: (Rect bounds) {
            //                 return LinearGradient(
            //                   colors: [
            //                     Color.fromRGBO(242, 221, 128, 1),
            //                     Color.fromRGBO(199, 143, 64, 1)
            //                   ],
            //                   begin: Alignment.topCenter,
            //                   end: Alignment.bottomCenter,
            //                 ).createShader(bounds);
            //               },
            //               child: Icon(Icons.notifications,
            //                   size: 31, color: Colors.white),
            //             ),
            //             CircleAvatar(
            //               radius: 8,
            //               backgroundColor: Colors.red,
            //               child: Text(
            //                 "1",
            //                 style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 10,
            //                     fontWeight: FontWeight.w700),
            //               ),
            //             ),
            //           ],
            //         ),
            //
            //         Expanded(child: SizedBox()),
            //
            //         // Title
            //         getDefaultText(
            //           text: 'My Orders',
            //           fontSize: 20,
            //           color: Colors.black,
            //           setShadow: true,
            //           fontWeight: FontWeight.w500,
            //         ),
            //
            //         Expanded(child: SizedBox()),
            //
            //         // Drawer Layout
            //         Container(
            //           height: 25,
            //           width: 25,
            //           decoration: BoxDecoration(
            //               gradient: LinearGradient(
            //                   begin: Alignment.topCenter,
            //                   end: Alignment.bottomCenter,
            //                   colors: [
            //                     Color.fromRGBO(242, 221, 128, 1),
            //                     Color.fromRGBO(199, 143, 64, 1)
            //                   ])),
            //           child: Icon(
            //             Icons.format_list_bulleted,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),



          ],
        ),
      ),
    );
  }
}
