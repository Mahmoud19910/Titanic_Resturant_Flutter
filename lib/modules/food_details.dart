import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturantapp/controlers/fooddetails_controller.dart';
import 'package:resturantapp/modles/meals.dart';
import 'package:resturantapp/modles/orders.dart';
import 'package:resturantapp/shared/componenets/componenet.dart';
import 'package:uuid/uuid.dart';

import '../shared/data_resource/cloud/cloud_controller.dart';

class FoodDetails extends StatelessWidget {
  FoodDetails();

FoodDetailscontroller foodcont = Get.put(FoodDetailscontroller());
  CloudController cloudController = Get.find<CloudController>();
  String _numberOfFood="";
  String _notes="";


  @override
  Widget build(BuildContext context) {

    var meals = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(242, 221, 128, 1),
                    Color.fromRGBO(199, 143, 64, 1)
                  ])),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Get.offNamed("home");
          },
            child: Icon(Icons.arrow_back_ios_new)),
        title: Text(meals.nameMeals),
      ),
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: Color.fromRGBO(0, 0, 0, 0.1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meals.imageUrlMeals,
                fit: BoxFit.fill,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.3,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
              ),
              SizedBox(
                height: 34.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                      height: 42,
                      width: 82,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.16)
                                , blurRadius: 6, offset: Offset(0, 3))
                          ]
                      ), child: Center(
                        child:GetBuilder<FoodDetailscontroller>(
                          builder: (context)=> TextFormField(
                            keyboardType:TextInputType.number,
                            onChanged: (input){
                              foodcont.totalPrice(meals.idMeals, input);
                              _numberOfFood=input;
                            },
                            textAlign: TextAlign.center ,
                            decoration:InputDecoration(hintText: "44") ,

                            style: TextStyle(fontSize: 17),
                          ),
                        )
                      )),

                  SizedBox(
                    width: 37,
                  ),

                  getDefaultText(
                      text: "العدد ",
                      fontSize: 22,
                      color: Colors.black,
                      setShadow: false,
                      fontWeight: FontWeight.w400),

                ],
              ),
              SizedBox(
                height: 34.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                      height: 42,
                      width: 82,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.16)
                                , blurRadius: 6, offset: Offset(0, 3))
                          ]
                      ),
                      child: Obx(() => Center(
                        child: getDefaultText(text: "₪ ${foodcont.totalPric.value}",
                            fontSize: 17,
                            color: Colors.black,
                            setShadow: false,
                            fontWeight:FontWeight.w400 ),
                      ),)),

                  SizedBox(
                    width: 37,
                  ),

                  getDefaultText(
                      text: "السعر ",
                      fontSize: 22,
                      color: Colors.black,
                      setShadow: false,
                      fontWeight: FontWeight.w400),

                ],
              ),

              SizedBox(height: 45,),

              getDefaultText(
                  text: "إضافة ملاحظة ",
                  fontSize: 18,
                  color: Colors.black,
                  setShadow: false,
                  fontWeight: FontWeight.w700),

              SizedBox(height: 5,),

              Padding(
                padding: EdgeInsets.only(
                  right: 27,
                  left: 27,
                ),
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.15,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.16)
                            , blurRadius: 6, offset: Offset(0, 3))
                      ]

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (input){
                        _notes=input;
                      },
                      maxLines: 5,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15,),

              InkWell(
                onTap: (){


                  if(!_numberOfFood.isEmpty || _numberOfFood!=""){
                    DateTime dateAttheMoment = DateTime.now();
                    String date = "${dateAttheMoment.day}/${dateAttheMoment.month}/${dateAttheMoment.year}";
                    String orderId = Uuid.NAMESPACE_X500;
                    cloudController.newOrder(OrdersItem(id: orderId , userId: "123", imageUrl:meals.imageUrlMeals, foodName: meals.nameMeals, totalPrice: meals.idMeals , numberOffood: _numberOfFood, notes: _notes , orderStatus: "send" , orderTime: date ));
                    Get.offNamed("/home");
                  }else{

                    final snackBar = SnackBar(
                      content: Center(child: Text(' الرجاء ادخال العدد')),
                      duration: Duration(seconds: 3), // How long the snackBar will be displayed
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  }

                },
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.5,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(242, 221, 128, 1),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.16)
                            , blurRadius: 6, offset: Offset(0, 3))
                      ]
                  ),

                  child: Center(child: getDefaultText(text: "إضافة للطلبات", fontSize: 18, color: Colors.black, setShadow: false, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
