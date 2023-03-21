import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturantapp/controlers/unboad_controller.dart';
import 'package:resturantapp/modles/PhoneNumber_Auth.dart';
import 'package:resturantapp/modules/ForgetPass.dart';
import 'package:resturantapp/modules/SignIn.dart';
import 'package:resturantapp/modules/SignUp.dart';
import 'package:resturantapp/modules/home.dart';
import 'package:resturantapp/modules/splash.dart';
import 'package:resturantapp/modules/verify.dart';

import 'modules/unboarding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      GetMaterialApp(
        initialRoute: '/splash',
          getPages: [
            GetPage(name: '/splash', page: ()=>Splash()),
            GetPage(name: "/unboarding", page: () => UnBoarding(),),
            GetPage(name: '/home', page: ()=> Home()),
            GetPage(name: "/signup", page: ()=>SignUp()),
            GetPage(name: "/signIn", page:()=>SignIn() ),
            GetPage(name: "/forgetPass", page: ()=>ForgetPass()),
            GetPage(name: "/verify", page: ()=> Verify()),

          ],


      )
  );
}

