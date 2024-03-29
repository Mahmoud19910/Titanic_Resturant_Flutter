import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_tab_view/infinite_scroll_tab_view.dart';
import 'package:resturantapp/modles/category.dart';
import 'package:resturantapp/modles/meals.dart';
import 'package:resturantapp/modles/search_in_meals.dart';
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

    List<String> images = ["assets/images/imag1.jpg" , "assets/images/imag2.jpg" , "assets/images/imag3.jpg"];
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [


                // Slider Images
                CarouselSlider(
                  options: CarouselOptions(height: MediaQuery.of(context).size.height * 0.25 , autoPlay: true ),
                  items:images.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.amber
                            ),
                            child: Image.asset("${i}" , fit: BoxFit.fill,)
                        );
                      },
                    );
                  }).toList(),
                ),
                // Tab Bar View
                Container(
                  height: MediaQuery.of(context).size.height ,
                  width: double.infinity,
                  child: FutureBuilder<List<Category>>(
                    future: cloudController.getAllCategory(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: MediaQuery.of(context).size.height,
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
                              tempNameCategory = snapshot.data!.elementAt(index).nameCategory;
                              //Tab Buttonعند الضغط على  Fire Base حفظ وجبات الطعام في
                              // cloudController.saveMealsCategory(snapshot.data!.elementAt(index).nameCategory);

                            },
                            indicatorColor: Color.fromRGBO(237, 48, 48, 1),
                            pageBuilder: (context, index, _) {
                              return StreamBuilder<List<Meals>>(
                                stream: cloudController.getMealsFromFireBaseStream(snapshot.data!.elementAt(index).nameCategory),
                                  builder: (context , snapshot){
                                    if(snapshot.hasData){
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 230),
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
                                                      padding:   EdgeInsets.only(bottom:5,top: 5)  ,
                                                      child: (index%2==0)?


                                                      getMealsItemBuilder(
                                                          parentWidth: MediaQuery.of(context).size.width * 0.5 - 16,
                                                          parentHeight: 63,
                                                          netWorkImage: snapshot.data!.elementAt(index).imageUrlMeals,
                                                          mealsName: snapshot.data!.elementAt(index).nameMeals,
                                                          price: snapshot.data!.elementAt(index).idMeals,
                                                          borderRadiusDirection: true,
                                                          addToFavorite: snapshot.data!.elementAt(index),
                                                          clickedItemIndex: index,
                                                          onClickItem: (){
                                                            Get.toNamed("/itemDetails", arguments: (snapshot.data!.elementAt(index)));
                                                          },
                                                          function: () async {

                                                             cloudController.updateDocument(tempNameCategory! , snapshot.data!.elementAt(index).idMeals , snapshot.data!.elementAt(index));
                                                            print("favoriye item : ${snapshot.data!.elementAt(index).isAddTofav} the name ${snapshot.data!.elementAt(index).nameMeals}");
                                                            // homeController.onClickAddToFavorite(index);
                                                             if(!snapshot.data!.elementAt(index).isAddTofav){
                                                               cloudController.saveMealsToFavorite(snapshot.data!.elementAt(index));

                                                             }else{
                                                               await cloudController.deleteFavoriteMealFromFirebaseByName(snapshot.data!.elementAt(index).idMeals);
                                                             }

                                                          })
                                                          :
                                                      getMealsItemBuilder(
                                                          parentWidth: MediaQuery.of(context).size.width * 0.5 - 16,
                                                          parentHeight: 63,
                                                          netWorkImage: snapshot.data!.elementAt(index).imageUrlMeals,
                                                          mealsName: snapshot.data!.elementAt(index).nameMeals,
                                                          price: snapshot.data!.elementAt(index).idMeals,
                                                          borderRadiusDirection: false,
                                                          addToFavorite: snapshot.data!.elementAt(index),
                                                          clickedItemIndex: index,
                                                          onClickItem: (){
                                                            Get.toNamed("/itemDetails" , arguments: (snapshot.data!.elementAt(index)));
                                                          },
                                                          function: () async{
                                                            cloudController.updateDocument(tempNameCategory! , snapshot.data!.elementAt(index).idMeals , snapshot.data!.elementAt(index));
                                                            if(!snapshot.data!.elementAt(index).isAddTofav){
                                                              cloudController.saveMealsToFavorite(snapshot.data!.elementAt(index));

                                                            }else{
                                                              await cloudController.deleteFavoriteMealFromFirebaseByName(snapshot.data!.elementAt(index).idMeals);
                                                            }
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
                                      print("The error" +snapshot.error.toString());
                                      return Center(child: Text("Error!!"));
                                    } else {
                                    print("null 2");
                                    return Center(child: Image.asset("assets/images/notfound.jpg"));
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
