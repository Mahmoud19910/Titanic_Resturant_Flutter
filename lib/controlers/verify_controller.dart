import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturantapp/modles/PhoneNumber_Auth.dart';

class VerifyController extends GetxController{
  static const maxSecound=60;
  int secounds=maxSecound;
  Timer? timer;
  RxString smsCode="".obs;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startTimer();
  }

  void onChageInput(String value){
    smsCode.value=value;
  }

  // ميثود بدء المؤقت
  void startTimer(){
     timer=Timer.periodic(Duration(seconds: 1),(_){

      if(secounds>0){
        secounds--;
        update();
      }else{
        stopTimer();

      }

    });
  }

// ميثود ايقاف المؤقت
  void stopTimer(){
    timer?.cancel();
  }

// عند ادخال رمز التأكيد
  bool onVerifiedCode(BuildContext context ){
    if(smsCode==null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Can\'t Be Verify !")));
      return false;
    }else{
      showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(),));
      PhoneNumber_Auth.verifyedCode(context, smsCode.value!);
      return true;
    }
  }



}