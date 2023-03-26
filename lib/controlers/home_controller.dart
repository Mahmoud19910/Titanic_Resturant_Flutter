import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController{

  late final VideoPlayerController controller;
  bool isPlaying = false;
  bool isMute=false;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = VideoPlayerController.asset('assets/videos/story.mp4');
    controller.initialize().then((_) {
      controller.play();
      isPlaying = true;
      print("Initialize:  $isPlaying");
    });
    // Add listener to the video player controller to check when the video has completed playing
    controller.addListener(() {
      if (controller.value.isInitialized &&
          !controller.value.isPlaying &&
          controller.value.duration == controller.value.position) {
        // Video has finished playing, replay it
        controller.seekTo(Duration.zero);
        controller.play();

      }
    });

  }


  @override
  void dispose() {
    controller.pause();
    controller.removeListener(() {});
    controller.dispose();
    super.dispose();
    print("Dispose:  $isPlaying");

  }

  void muteSounds(){
    isMute=!isMute;
    update();
    if(isMute){
      controller.setVolume(0);
    }else{
      controller.setVolume(1);
    }
  }

}

