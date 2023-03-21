import 'package:get/get.dart';

class SignUp_Controoler extends GetxController{


  bool showPass = true;
  bool isChecked = false;

   void showPassFunc(){
     showPass=!showPass;
    update();
  }

  void isCheckedBox(bool checked){
     isChecked=checked;
     update();
  }


}
