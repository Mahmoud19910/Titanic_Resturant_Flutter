import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resturantapp/controlers/signin_controller.dart';
import '../modles/Google_SignIn.dart';
import '../shared/componenets/componenet.dart';
import '../shared/data_resource/firebase_database/users_info_collection_controller.dart';

class SignIn extends StatelessWidget {
   SignIn({Key? key}) : super(key: key);
   var _formKey=GlobalKey<FormState>();
   var signInController=Get.put(SignIn_Controller());
   var usersCollectionController=Get.put(UsersInfoCollectionController());
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: WillPopScope(
        onWillPop: () async {
          Get.offAllNamed("/signup");
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
                                Get.offAllNamed("/signup");
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
                          text: "Sign In",
                          fontSize: 30,
                          color: Colors.white,
                          setShadow: true,
                          fontWeight: FontWeight.w700),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.050,
                      ),



                      // Phone Edit Text
                      getDefaultTextFiled(
                          keyBoardType: TextInputType.number,
                          isBorder: false,
                          text: "Phone Number",
                          isGradient: false,
                          validatorFunc: validateInput,
                          controller: phoneController,
                          sufixIcon: Icons.phone_android_outlined,
                          inputType: TextInputType.name),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),

                      // Passowrd Edit Text
                      GetBuilder<SignIn_Controller>(
                        builder: (context)=>getDefaultTextFiled(
                            keyBoardType: TextInputType.visiblePassword,
                            isBorder: false,
                            text: "Passowrd",
                            isGradient: false,
                            controller: passController,
                            showPass:signInController.showPass ,
                            validatorFunc: validateInput,
                            showPassFunc: () {
                              signInController.showPassFunc();
                            },

                            sufixIcon: signInController.showPass
                                ? Icons.visibility_off_outlined
                                : Icons.remove_red_eye_outlined,
                            inputType: TextInputType.name),

                      ),


                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.050,
                      ),

                      getDefaultButton(
                          text: "Sign In",
                          textColor: Colors.black,
                          isShadow: true,
                          isGradinent: false,
                          function: () async {

                            if(!_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                            }else{
                              List<DocumentSnapshot> list = await usersCollectionController.getAllUsersInfo();
                              
                              for(DocumentSnapshot dataList in list){

                                Map<String, dynamic> data = dataList.data() as Map<String , dynamic>; // Retrieve the map of field names and values for the document
                                String phone=data["phoneNumber"];
                                String pass=data["pass"];

                                if(phoneController.text.toString()==phone && passController.text.toString()==pass){
                                  print("Success");
                                  Get.offAllNamed("/home");

                                }else{
                                  print("Fail");
                                }
                              }
                            }

                          }),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.042,
                      ),

                      InkWell(
                        onTap: (){
                          Get.offAllNamed("/forgetPass");
                        },
                        child: getDefaultText(
                            text: "Forget Passowrd ?",
                            fontSize: 16,
                            color: Colors.white,
                            setShadow: false,
                            fontWeight: FontWeight.w300),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.042,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getDefaultText(
                              text: "Don't have an account ?",
                              fontSize: 16,
                              color: Colors.white,
                              setShadow: false,
                              fontWeight: FontWeight.w300),

                          getUnderLineText(text: " Sign Up",
                              fontSize: 16,
                              color: Color.fromRGBO(112, 112, 112, 1),
                              setShadow: false,
                              fontWeight: FontWeight.w300)
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.042,
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
                            // التسجيل بواسطة جيميل
                            InkWell(
                                onTap:() async {
                                  try{
                                    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(),));
                                    UserCredential? userCreden= await GoogleSignInAuth.signInWithGoogle();
                                    Get.offAllNamed("/home");
                                  }catch(e){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                                    Navigator.pop(context);
                                  }

                                },
                                child: Image.asset("assets/images/gmail.png",height: 100,width: 100,)),

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
