import 'package:get/get.dart';

class ForgetPassController extends GetxController{
  RxBool showPass = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  void showPassFunc(){
    showPass.value=!showPass.value;
  }
}