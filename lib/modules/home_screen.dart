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
                  child: StreamBuilder<List<Category>>(
                    stream: cloudController.getCategoryFromFireBaseStream(),
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
                              return StreamBuilder<List<Meals>>(
                                stream: cloudController.getMealsFromFireBaseStream(snapshot.data!.elementAt(index).nameCategory),
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
                                              return  GetBuilder<HomeController>(
                                                  builder: (contex)=> Padding(
                                                      padding: const EdgeInsets.only(bottom:5,top: 10),
                                                      child: (index%2==0)?


                                                      getMealsItemBuilder(
                                                          parentWidth: MediaQuery.of(context).size.width * 0.5 - 16,
                                                          parentHeight: 63,
                                                          netWorkImage: snapshot.data!.elementAt(index).imageUrlMeals,
                                                          mealsName: snapshot.data!.elementAt(index).nameMeals,
                                                          price: snapshot.data!.elementAt(index).idMeals,
                                                          borderRadiusDirection: true,
                                                          addToFavorite: homeController.boolFavorite,
                                                          clickedItemIndex: index,
                                                          function: (){
                                                            homeController.onClickAddToFavorite(index);
                                                            cloudController.saveMealsToFavorite(snapshot.data!.elementAt(index));

                                                          })
                                                          :
                                                      getMealsItemBuilder(
                                                          parentWidth: MediaQuery.of(context).size.width * 0.5 - 16,
                                                          parentHeight: 63,
                                                          netWorkImage: snapshot.data!.elementAt(index).imageUrlMeals,
                                                          mealsName: snapshot.data!.elementAt(index).nameMeals,
                                                          price: snapshot.data!.elementAt(index).idMeals,
                                                          borderRadiusDirection: false,
                                                          addToFavorite: homeController.boolFavorite,
                                                          clickedItemIndex: index,
                                                          function: (){
                                                            homeController.onClickAddToFavorite(index);
                                                            cloudController.saveMealsToFavorite(snapshot.data!.elementAt(index));

                                                          })

                                                  ),);
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
