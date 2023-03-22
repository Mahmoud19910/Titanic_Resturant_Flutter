
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/home.dart';

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
