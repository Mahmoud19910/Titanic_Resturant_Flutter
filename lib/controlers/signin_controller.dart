import 'package:get/get.dart';

class SignIn_Controller extends GetxController{


  RxBool showPass =true.obs;

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  void showPassFunc(){
   if(showPass==true){
     showPass.value=false;
   }else{
     showPass.value=true;
   }
  }

}