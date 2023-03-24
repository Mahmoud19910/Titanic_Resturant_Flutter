import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resturantapp/modles/usersinfo.dart';
import 'package:resturantapp/modules/SignIn.dart';

import '../modles/Google_SignIn.dart';
import '../shared/data_resource/local_database/floordatabase_controller.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);
  var floorController=Get.put(FloorDataBaseController());


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child:Scaffold(body:
      Container(height: double.infinity,width: double.infinity,color: Colors.greenAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: MaterialButton(
              onPressed: (){
GoogleSignInAuth.signOut();
Navigator.push(context, MaterialPageRoute(builder: (context)=> SignIn()));
              },
            child: Text("Sign Out"),
          ),),

          Obx(() => Text("${floorController.usersList[0].uid}")),


        ],
      ),
      )
      )

    );
  }
}
