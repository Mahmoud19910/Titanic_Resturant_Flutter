import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resturantapp/modles/category.dart';
import 'package:resturantapp/modles/orders.dart';

import '../shared/componenets/componenet.dart';
import '../shared/data_resource/cloud/cloud_controller.dart';

class OrdersScreen extends StatelessWidget {
   OrdersScreen({Key? key}) : super(key: key);

   CloudController cloudController = Get.put(CloudController());
   String _date='';

  @override
  Widget build(BuildContext context) {

    DateTime dateTime = DateTime.now();
    _date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";

    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height - 110,
          padding: EdgeInsets.only(right: 10, left: 10, bottom:20 ,top:10),
          child:StreamBuilder<List<OrdersItem>>(
              stream: cloudController.getOrders("send", _date),
              builder: (context , snapshot){

                if(snapshot.hasData && snapshot.data!.length>0){
                  print("null 4");
                  return ListView.separated(
                      itemBuilder: (context , index)=> getFavoriteItemBuilder(
                          parentWidth: double.infinity,
                          parentHeight: 63,
                          netWorkImage: snapshot.data!.elementAt(index).imageUrl,
                          mealsName: snapshot.data!.elementAt(index).foodName,
                          price: snapshot.data!.elementAt(index).totalPrice,
                          function: (){
                            cloudController.deleteOrder(snapshot.data!.elementAt(index).id);
                          }),
                      separatorBuilder: (context , index)=> SizedBox(height: 20,),
                      itemCount: snapshot.data!.length);
                }
                else
                if(snapshot.connectionState == ConnectionState.waiting){
                  print("null 3");

                  return Center(child: CircularProgressIndicator(),);
                }else
                if(snapshot.connectionState == ConnectionState.none){
                  return Center(child: Container(
                      height: 100,
                      width: 200,
                      color: Colors.green,
                      child: Text("Not Found" , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w700),)),);
                }else{
                  print("null 2");
                  return Center(child: Image.asset("assets/images/notfound.jpg"));
                }
              })
      ),


    );
  }
}
