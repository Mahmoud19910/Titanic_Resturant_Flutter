
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../modules/verify.dart';
import '../modules/home.dart';

class PhoneNumber_Auth{

  static String verifyCode="";
  static String? uid;
  // SignUp_Controller signUp_Controller=SignUp_Controller();


  // ميثود لارسال كود التحقق
  static Future<void> signInWithPhoneNumber(String phoneNumber ,String? pass , String? name, BuildContext context) async{

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {

          if (value.user != null) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
                    (route) => false);
          }

        });
        Navigator.pop(context);

      },

      verificationFailed: (FirebaseAuthException e) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code)));
        Navigator.pop(context);

      },

      codeSent: (String verificationId, int? resendToken) {
        Navigator.pop(context);
        verifyCode=verificationId;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) =>  Verify(name: name,pass: pass,phone: phoneNumber,)),
                (route) => false);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );


  }

 static Future<void> verifyedCode(BuildContext context , String code)async {
    final  FirebaseAuth auth = FirebaseAuth.instance;
    try{
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId:PhoneNumber_Auth.verifyCode, smsCode: code);
      // Sign the user in (or link) with the credential
      uid=auth.currentUser!.uid;
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);



    }
    catch(e){
      // خطأ في العملية
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Can\'t Be Verify !")));
      Navigator.pop(context);

    }

  }


}