import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:resturantapp/modules/home_screen.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController{

  late final VideoPlayerController controller;
  RxBool isPlaying = false.obs;
  RxBool isMute=false.obs;




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }


  @override
  void dispose() {
    controller.pause();
    controller.removeListener(() {});
    controller.dispose();
    super.dispose();
    print("Dispose:  $isPlaying");

  }





}

