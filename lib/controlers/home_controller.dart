import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:resturantapp/modules/home_screen.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController{

  late final VideoPlayerController controller;
  RxBool isPlaying = false.obs;
  RxBool isMute=false.obs;

  late List<bool>boolFavorite=List.generate(100, (_) => false);



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = VideoPlayerController.asset('assets/videos/story.mp4');
    controller.initialize().then((_) {
      controller.play();
      isPlaying.value = true;
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

  // كتم صوت الفيديو
  void muteSounds(){
    isMute.value=!isMute.value;
    update();
    if(isMute.value){
      controller.setVolume(0);
    }else{
      controller.setVolume(1);
    }
  }

  // ميثود الاضاقة الى المفضلة
  void onClickAddToFavorite(int index ){
     boolFavorite[index]=!boolFavorite[index];
    update();
  }

}

