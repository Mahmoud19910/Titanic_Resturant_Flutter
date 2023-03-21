import 'package:get/get.dart';

class SignIn_Controller extends GetxController{


  bool showPass = true;

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  void showPassFunc(){
    showPass=!showPass;
    update();
  }

}