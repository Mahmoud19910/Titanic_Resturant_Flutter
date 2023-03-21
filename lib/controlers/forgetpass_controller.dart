import 'package:get/get.dart';

class ForgetPassController extends GetxController{
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