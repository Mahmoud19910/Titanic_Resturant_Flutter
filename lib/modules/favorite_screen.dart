import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_tab_view/infinite_scroll_tab_view.dart';
import 'package:resturantapp/controlers/home_controller.dart';
import 'package:resturantapp/modles/category.dart';
import 'package:resturantapp/modles/favorite.dart';
import 'package:resturantapp/shared/data_resource/cloud/cloud_controller.dart';

import '../shared/componenets/componenet.dart';


class FavoriteScreen extends StatelessWidget{
  var cloudController = Get.put(CloudController());
  var homeController = Get.put(HomeController());

  String? nameCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // //App Bar
              // Container(
              //   height: 56,
              //   width: MediaQuery.of(context).size.width,
              //   color: Color.fromRGBO(227, 227, 227, 1),
              //   child: Padding(
              //     padding: const EdgeInsets.only(right: 5, left: 5),
              //     child: Row(
              //       children: [
              //         // Notifications
              //         Stack(
              //           children: [
              //             ShaderMask(
              //               shaderCallback: (Rect bounds) {
              //                 return LinearGradient(
              //                   colors: [
              //                     Color.fromRGBO(242, 221, 128, 1),
              //                     Color.fromRGBO(199, 143, 64, 1)
              //                   ],
              //                   begin: Alignment.topCenter,
              //                   end: Alignment.bottomCenter,
              //                 ).createShader(bounds);
              //               },
              //               child: Icon(Icons.notifications,
              //                   size: 31, color: Colors.white),
              //             ),
              //             CircleAvatar(
              //               radius: 8,
              //               backgroundColor: Colors.red,
              //               child: Text(
              //                 "1",
              //                 style: TextStyle(
              //                     color: Colors.white,
              //                     fontSize: 10,
              //                     fontWeight: FontWeight.w700),
              //               ),
              //             ),
              //           ],
              //         ),
              //         Expanded(child: SizedBox()),
              //         // Title
              //         getDefaultText(
              //           text: 'My Favorite',
              //           fontSize: 20,
              //           color: Colors.black,
              //           setShadow: true,
              //           fontWeight: FontWeight.w500,
              //         ),
              //         Expanded(child: SizedBox()),
              //         // Drawer Layout
              //         Container(
              //           height: 25,
              //           width: 25,
              //           decoration: BoxDecoration(
              //               gradient: LinearGradient(
              //                   begin: Alignment.topCenter,
              //                   end: Alignment.bottomCenter,
              //                   colors: [
              //                     Color.fromRGBO(242, 221, 128, 1),
              //                     Color.fromRGBO(199, 143, 64, 1)
              //                   ])),
              //           child: Icon(
              //             Icons.format_list_bulleted,
              //             color: Colors.white,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // Tab Bar View
              Container(
                height: MediaQuery.of(context).size.height - 56,
                width: double.infinity,
                padding: EdgeInsets.only(right: 10, left: 10,bottom: 80, top:10),
                child: StreamBuilder<List<Favorite>>(
                  stream: cloudController.getFavoriteMealsStreamFromFirebase(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                          itemBuilder: (context , index)=>
                          getFavoriteItemBuilder(
                              photoRadius: 50,
                              parentWidth: MediaQuery.of(context).size.width,
                              parentHeight: 63,
                              netWorkImage: snapshot.data!.elementAt(index).meals.imageUrlMeals,
                              mealsName: snapshot.data!.elementAt(index).meals.nameMeals,
                              price: snapshot.data!.elementAt(index).meals.idMeals,
                              function: (){
                                cloudController.deleteFavoriteMealFromFirebaseByName(snapshot.data!.elementAt(index).meals.idMeals);
                                print("ID :${snapshot.data!.elementAt(index).meals.idMeals}");
                              }),
                          separatorBuilder: (context , index)=>SizedBox(height: 20,),
                          itemCount: snapshot.data!.length);

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
    );
  }
}























