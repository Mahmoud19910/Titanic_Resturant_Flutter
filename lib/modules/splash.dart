import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resturantapp/modules/home.dart';
import 'package:resturantapp/modules/unboarding.dart';

import '../modles/Google_SignIn.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Timer(const Duration(seconds: 3), ()=>Navigator.pushReplacement(context, PageRouteBuilder(
    //             transitionDuration: Duration(seconds: 1),
    //             pageBuilder: (_, __, ___) => UnBoarding()
    // )
    // )
    // );

    Timer(const Duration(seconds: 2),() {
    // Get.off(duration: Duration(seconds: 1),UnBoarding());
      if(GoogleSignInAuth.auth.currentUser==null){
        print("UserCredential == NULL");
        Get.off(duration: Duration(seconds: 1),UnBoarding());
      }else{
        Get.offAllNamed("/home");
        print("UserCredential != NULL");
        Get.offNamed("/home");
      }

    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [ Color.fromRGBO(242, 221, 128, 1),Color.fromRGBO(199, 143, 64, 1),],

                  )
              ),
              child: Image.asset('assets/images/mainlogo.png'),
            )
        )
    );
  }
}

