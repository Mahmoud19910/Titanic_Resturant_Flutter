import 'package:get/get.dart';

class SignUp_Controller extends GetxController{
  RxBool showPass = true.obs;
  RxBool isChecked = false.obs;

  void showPassFunc(){
    showPass.value=!showPass.value;

  }

  void isCheckedBox(bool checked){
    isChecked.value=checked;
  }
}