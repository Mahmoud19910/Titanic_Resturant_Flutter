import 'dart:async';

import 'package:get/get.dart';

class VerifyController extends GetxController{
  static const maxSecound=60;
  int secounds=maxSecound;
  Timer? timer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startTimer();
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


}