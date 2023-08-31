import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FoodDetailscontroller extends GetxController{
  RxDouble totalPric=0.0.obs;


  void totalPrice(String price , String count){

    double priceItem = double.parse(price);
    double countItem = double.parse(count);

    totalPric.value = priceItem*countItem;

  }

}