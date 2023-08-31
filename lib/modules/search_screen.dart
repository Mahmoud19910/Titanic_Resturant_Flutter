import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resturantapp/controlers/search_controller.dart';
import 'package:resturantapp/modles/search_in_meals.dart';
import 'package:resturantapp/shared/data_resource/cloud/cloud_controller.dart';

import '../shared/componenets/componenet.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
   var searchControoler=Get.put(SearchControllers());
   var cloudController = Get.put(CloudController());
   TextEditingController editSearch=TextEditingController();

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Set to false to prevent floating above the keyboard

      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [

                //App Bar
               // getDefaultTextFiled(
               //     text: "Search",
               //     controller: editSearch,
               //     sufixIcon: Icons.search_outlined,
               //     isGradient: true,
               //     isBorder: true,
               //     keyBoardType: TextInputType.name,
               //     inputType: TextInputType.name),
                Container(
                  color: Colors.white60,
                  child: AnimationSearchBar(
                    isBackButtonVisible: false,
                      backIconColor: Colors.black,
                      centerTitle: 'Search By First Character',
                      onChanged: (text) {
                        searchControoler.onChange(text);
                      },
                      horizontalPadding: 5,
                    searchTextEditingController: editSearch,),
                ),

               Obx(() =>  Container(
                 height: MediaQuery.of(context).size.height - 56,
                 width: double.infinity,
                 padding: EdgeInsets.only(right: 10, left: 10,bottom: 80, top:10),
                 child: StreamBuilder<List<SearchInMeals>>(
                   stream: cloudController.getAllMealsByFirstChar(searchControoler.textChange!.value),
                   builder: (context, snapshot) {
                     if (snapshot.hasData) {
                       return ListView.separated(
                           itemBuilder: (context , index)=>
                               InkWell(
                                 onTap: (){
                                   Get.toNamed("/itemDetails", arguments: (snapshot.data!.elementAt(index)));

                                 },
                                 child: getSearch(
                                     photoRadius: 50,
                                     parentWidth: MediaQuery.of(context).size.width,
                                     parentHeight: 63,
                                     netWorkImage: snapshot.data!.elementAt(index).imageUrlMeals,
                                     mealsName: snapshot.data!.elementAt(index).nameMeals,
                                     price: snapshot.data!.elementAt(index).idMeals,
                                     function: (){

                                       print("ID :${snapshot.data!.elementAt(index).imageUrlMeals}");
                                     }),
                               ),
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
                       return Center(child: Column(
                         children: [
                           Icon(Icons.wifi_tethering_error_sharp,size: 50,),
                           Text("Not Found!!!!"),
                         ],
                       ));
                     } if(snapshot==null){
                       return Center(child: Text("Enter The First Charcter "),);
                     }else {
                       return Center(
                         child: Text("Not Found!!"),
                       );
                     }
                   },
                 ),
               ),),




              ],
            ),
          ),
        ),
      ),
    );
  }
}
