import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_tab_view/infinite_scroll_tab_view.dart';
import 'package:resturantapp/modles/category.dart';
import 'package:resturantapp/modles/meals.dart';
import 'package:resturantapp/shared/data_resource/cloud/cloud_controller.dart';
import 'package:video_player/video_player.dart';
import '../controlers/home_controller.dart';
import '../shared/componenets/componenet.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  var homeController = Get.put(HomeController());
  var cloudController = Get.put(CloudController());
  static String? nameCategory;
  static String? tempNameCategory;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
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
                            child: VideoPlayer(homeController.controller)),

                        // Mute Sounds
                        GetBuilder<HomeController>(
                            builder: (context) => homeController.isMute
                                ? InkWell(
                                    onTap: () {
                                      homeController.muteSounds();
                                    },
                                    child: Icon(
                                      Icons.volume_off,
                                      color: Colors.white,
                                    ))
                                : InkWell(
                                    onTap: () {
                                      homeController.muteSounds();
                                    },
                                    child: Icon(
                                      Icons.volume_down_sharp,
                                      color: Colors.white,
                                    ))),
                      ],
                    ),
                  ),
                ),

                // Tab Bar View
                Container(
                  height: MediaQuery.of(context).size.height - 256,
                  width: double.infinity,
                  child: FutureBuilder<List<Category>>(
                    future: cloudController.getCategoryFromFireBase(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: InfiniteScrollTabView(
                            contentLength: snapshot.data!.length,
                            onTabTap: (index) {
                              debugPrint('tapped $index');
                            },
                            tabBuilder: (index, isSelected) {
                              nameCategory=snapshot.data!.elementAt(index).nameCategory;

                              return Text(
                                nameCategory!,
                                style: TextStyle(
                                  color: isSelected ? Color.fromRGBO(237, 48, 48, 1)
                                      : Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              );
                            },
                            separator: BorderSide(color: Colors.black12, width: 2.0),
                            onPageChanged: (index) {
                              print("Index  :$index");
                              //Tab Buttonعند الضغط على  Fire Base حفظ وجبات الطعام في
                              cloudController.saveMealsCategory(snapshot.data!.elementAt(index).nameCategory);

                            },
                            indicatorColor: Color.fromRGBO(237, 48, 48, 1),
                            pageBuilder: (context, index, _) {
                              return FutureBuilder<List<Meals>>(
                                future: cloudController.getMealsFromFireBase(snapshot.data!.elementAt(index).nameCategory),
                                  builder: (context , snapshot){
                                    if(snapshot.hasData){
                                      return Container(
                                        padding: EdgeInsets.only(left: 10,right: 10,bottom: 120),
                                        child:GridView.builder(
                                            itemCount:snapshot.data!.length,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 8.0,
                                              mainAxisSpacing: 8.0,
                                              childAspectRatio: 2.2,
                                            ),
                                            itemBuilder: (context, index){
                                              return Padding(
                                                padding: const EdgeInsets.only(bottom:5,top: 10),
                                                child: (index%2==0)?
                                                Container(
                                                  height: 63,
                                                  width: MediaQuery.of(context).size.width * 0.5 - 16,
                                                  decoration: BoxDecoration(color: Colors.white,
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                                                      boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.30),
                                                          blurRadius: 6,
                                                          offset: Offset(0, 6))
                                                      ]),
                                                  child: Padding(padding: const EdgeInsets.all(5.0),
                                                    child: Row( children: [
                                                        // صورة الوجبة
                                                        Container(decoration: BoxDecoration(shape: BoxShape.circle,
                                                              boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25),
                                                                    blurRadius: 6,
                                                                  offset: Offset(0, 3)),
                                                              ]),
                                                          child: CircleAvatar(
                                                            radius: 25,
                                                            // Image radius
                                                            backgroundImage:
                                                            NetworkImage(snapshot.data!.elementAt(index).imageUrlMeals),
                                                          ),
                                                        ),
                                                        // اسم الوجبة
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(right: 5.0 , left: 5.0),
                                                            child: Column(mainAxisAlignment:MainAxisAlignment.center,
                                                              children: [Text(snapshot.data!.elementAt(index).nameMeals,
                                                                  maxLines: 2,
                                                                  style: TextStyle(fontSize: 14,
                                                                      fontWeight: FontWeight.w500,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                ),
                                                                Text("2",
                                                                  style: TextStyle(fontSize: 14,
                                                                      fontWeight: FontWeight.w500),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),

                                                        // الاضافة الى المفضلة
                                                        Container(
                                                          width: 35,
                                                          height: 35,
                                                          decoration: BoxDecoration(shape: BoxShape.circle,
                                                              gradient: LinearGradient(
                                                                  colors: [Color.fromRGBO(242, 221, 128, 1),
                                                                    Color.fromRGBO(199, 143, 64, 1)
                                                                  ]),
                                                              boxShadow: [BoxShadow(
                                                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                                                    blurRadius: 6,
                                                                    offset: Offset(0, 3)),
                                                              ]),
                                                          child: Padding(padding: const EdgeInsets.all(3.0),
                                                            child: Container(width: 35,
                                                              height: 35,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: Colors.white),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(2.0),
                                                                child: Container(
                                                                  width: 35,
                                                                  height: 35,
                                                                  decoration: BoxDecoration(shape: BoxShape.circle,
                                                                      gradient: LinearGradient(
                                                                          colors: [
                                                                            Color.fromRGBO(242, 221, 128, 1),
                                                                            Color.fromRGBO(199, 143, 64, 1)
                                                                          ])),
                                                                  child: Icon(Icons.favorite,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                    :
                                                Container(
                                                  height: 63,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.5 -
                                                      16,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.only(
                                                          topRight: Radius.circular(30),
                                                          bottomLeft: Radius.circular(30)),
                                                      boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.30),
                                                          blurRadius: 6,
                                                          offset: Offset(0, 6))
                                                      ]),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        5.0),
                                                    child: Row(
                                                      children: [
                                                        // صورة الوجبة
                                                        Container(
                                                          decoration:
                                                          BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0.25),
                                                                    blurRadius:
                                                                    6,
                                                                    offset:
                                                                    Offset(
                                                                        0,
                                                                        3)),
                                                              ]),
                                                          child: CircleAvatar(
                                                            radius: 25,
                                                            // Image radius
                                                            backgroundImage:
                                                            NetworkImage(snapshot.data!.elementAt(index).imageUrlMeals),
                                                          ),
                                                        ),
                                                        // اسم الوجبة
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5,right: 5),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Text(
                                                                  snapshot.data!.elementAt(index).nameMeals,
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w500,
                                                                  overflow: TextOverflow.ellipsis),
                                                                ),
                                                                Text(
                                                                  "2",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      14,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),

                                                        // الاضافة الى المفضلة
                                                        Container(
                                                          width: 35,
                                                          height: 35,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              gradient:
                                                              LinearGradient(
                                                                  colors: [
                                                                    Color
                                                                        .fromRGBO(
                                                                        242,
                                                                        221,
                                                                        128,
                                                                        1),
                                                                    Color
                                                                        .fromRGBO(
                                                                        199,
                                                                        143,
                                                                        64,
                                                                        1)
                                                                  ]),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0.25),
                                                                    blurRadius:
                                                                    6,
                                                                    offset:
                                                                    Offset(
                                                                        0,
                                                                        3)),
                                                              ]),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                            child: Container(
                                                              width: 35,
                                                              height: 35,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .white),
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    2.0),
                                                                child:
                                                                Container(
                                                                  width: 35,
                                                                  height: 35,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      gradient:
                                                                      LinearGradient(
                                                                          colors: [
                                                                            Color.fromRGBO(
                                                                                242,
                                                                                221,
                                                                                128,
                                                                                1),
                                                                            Color.fromRGBO(
                                                                                199,
                                                                                143,
                                                                                64,
                                                                                1)
                                                                          ])),
                                                                  child: Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }) ,);
                                    }else if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(child: CircularProgressIndicator());
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.none) {
                                      return Center(
                                        child: Column(
                                          children: [
                                            Icon(Icons.network_check),
                                            Text('Net Work Error!!')
                                          ],
                                        ),
                                      );
                                    } else if (snapshot.hasError || snapshot.data!.isEmpty) {
                                      return Center(child: Text("Error!!"));
                                    } else {
                                      return Center(
                                        child: Text("Not Found!!"),
                                      );
                                    }
                                  });

                            },
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                          ConnectionState.none) {
                        return Center(
                          child: Column(
                            children: [
                              Icon(Icons.network_check),
                              Text('Net Work Error!!')
                            ],
                          ),
                        );
                      } else if (snapshot.hasError || snapshot.data!.isEmpty) {
                        return Center(child: Text("Error!!"));
                      } else {
                        return Center(
                          child: Text("Not Found!!"),
                        );
                      }
                    },
                  ),
                ),

           


              ],
            ),
          ),
        ),
      ),
    );
  }
}
