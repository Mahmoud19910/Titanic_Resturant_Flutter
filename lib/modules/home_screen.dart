import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:video_player/video_player.dart';
import '../controlers/home_controller.dart';
import '../shared/componenets/componenet.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

   var homeController=Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              //App Bar
              Container(
                height: 56,
                width: MediaQuery.of(context).size.width,
                color: Color.fromRGBO(227, 227, 227, 1),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, left: 5),
                  child: Row(
                    children: [
                      // Notifications
                      Stack(
                        children: [
                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [
                                  Color.fromRGBO(242, 221, 128, 1),
                                  Color.fromRGBO(199, 143, 64, 1)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(bounds);
                            },
                            child: Icon(Icons.notifications,
                                size: 31, color: Colors.white),
                          ),
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.red,
                            child: Text(
                              "1",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      // Title
                      getDefaultText(
                        text: 'Home',
                        fontSize: 20,
                        color: Colors.black,
                        setShadow: true,
                        fontWeight: FontWeight.w500,
                      ),
                      Expanded(child: SizedBox()),
                      // Drawer Layout
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromRGBO(242, 221, 128, 1),
                                  Color.fromRGBO(199, 143, 64, 1)
                                ])),
                        child: Icon(
                          Icons.format_list_bulleted,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Video Player
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: VideoPlayer(homeController.controller)
                      ),

                      // Mute Sounds
                      GetBuilder<HomeController>(
                          builder: (context)=> homeController.isMute?  InkWell(
                              onTap: (){
                                homeController.muteSounds();
                              },
                              child:Icon(Icons.volume_off, color: Colors.white,) )
                              :   InkWell(
                              onTap: (){
                                homeController.muteSounds();
                              },
                              child: Icon(Icons.volume_down_sharp, color: Colors.white,))
                      ),


                    ],
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
