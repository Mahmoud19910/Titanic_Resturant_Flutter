import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:resturantapp/shared/componenets/componenet.dart';




import 'package:flutter/cupertino.dart';

import '../controlers/signup_controller.dart';
import 'SignIn.dart';

class SignUp extends StatelessWidget {
   SignUp({Key? key}) : super(key: key);
var signUpController=Get.put(SignUp_Controoler());
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: WillPopScope(
        onWillPop: () async {
          Get.offAllNamed("/unboarding");
          return true;
        },
        child: Scaffold(
          body: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(199, 143, 64, 1),
                    Color.fromRGBO(242, 221, 128, 1)
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              Get.offAllNamed("/unboarding");
                            },
                              child: Icon(Icons.arrow_back_ios_new , color: Colors.white,))
                        ],
                      ),
                      Image.asset(
                        "assets/images/mainlogo.png",
                        width: 170,
                        height: 170,
                      ),


                      // Sign Up Text
                      getDefaultText(
                          text: "Sign Up",
                          fontSize: 30,
                          color: Colors.white,
                          setShadow: true,
                          fontWeight: FontWeight.w700),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.039,
                      ),

                      // Name Edit Text
                      getDefaultTextFiled(
                          keyBoardType: TextInputType.name,
                          isGradient: false,
                          isBorder: false,
                          text: "Full Name",
                          controller: nameController,
                          validatorFunc: validateInput,
                          sufixIcon: Icons.account_circle_outlined,
                          inputType: TextInputType.name),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),

                      // Phone Edit Text
                      getDefaultTextFiled(
                          keyBoardType: TextInputType.number,
                          isBorder: false,
                          isGradient: false,
                          text: "Phone Number",
                          validatorFunc: validateInput,
                          controller: phoneController,
                          sufixIcon: Icons.phone_android_outlined,
                          inputType: TextInputType.name),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),

                      // Passowrd Edit Text
                      GetBuilder<SignUp_Controoler>(
                          builder: (context)=>getDefaultTextFiled(
                                  keyBoardType: TextInputType.visiblePassword,
                              isBorder: false,
                              text: "Passowrd",
                                  controller: passController,
                                  showPass:signUpController.showPass ,
                              isGradient: false,
                              validatorFunc: validateInput,
                                  showPassFunc: () {
                                   signUpController.showPassFunc();
                                  },

                                  sufixIcon: signUpController.showPass
                                      ? Icons.visibility_off_outlined
                                      : Icons.remove_red_eye_outlined,
                                  inputType: TextInputType.name),

                      ),


                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),

                      GetBuilder<SignUp_Controoler>(
                         builder: (context)=> Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             getUnderLineText(
                                 text:"Terms and Conditions" ,
                                 fontSize: 16,
                                 color: Colors.white,
                                 setShadow: false,
                                 fontWeight: FontWeight.w300),
                             Checkbox(
                               value: signUpController.isChecked,
                               onChanged: (bool? value) {
                                signUpController.isCheckedBox(value!);
                               },
                               activeColor: Colors.white,
                               checkColor: Color.fromRGBO(112, 112, 112, 1),
                               shape: RoundedRectangleBorder(
                                   side: BorderSide(color: Colors.white),
                                   borderRadius: BorderRadius.circular(5)
                               ),
                             ),
                           ],
                         ),),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.010,
                      ),

                      getDefaultButton(
                          text: "Sign Up",
                          textColor: Colors.black,
                          isShadow: true,
                          isGradinent: false,
                          function: (){
                            print("sdfjhskhsfsdg56463gsdgdgdt534354wef");
                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                            }

                          }),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getDefaultText(
                              text: "Already have an account?",
                              fontSize: 16,
                              color: Colors.white,
                              setShadow: false,
                              fontWeight: FontWeight.w300),

                          // Go to Sign In
                          InkWell(
                            onTap: (){
                              Get.offAllNamed("/signIn");
                            },
                            child: getUnderLineText(text: " Sig In",
                                fontSize: 16,
                                color: Color.fromRGBO(112, 112, 112, 1),
                                setShadow: false,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),

                      getDefaultText(text: "OR BY",
                          fontSize: 17,
                          color: Colors.white,
                          setShadow: false,
                          fontWeight: FontWeight.w700),

                      Padding(
                        padding: const EdgeInsets.only(right: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/gmail.png",height: 100,width: 100,),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 7),
                              child: Image.asset("assets/images/facebook.png",height: 50,width: 50,),
                            ),

                          ],
                        ),
                      ),




                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

