import 'package:flutter/cupertino.dart';

class ConstantComponenet{


  List<AssetImage> getUnBoardingImage(){
    List<AssetImage> imageList=[];
    imageList.add(AssetImage('assets/images/delivery.png'));
    imageList.add(AssetImage('assets/images/resturant.jpg'));
    imageList.add(AssetImage('assets/images/payment.jpg'));
    return imageList;
  }


}
