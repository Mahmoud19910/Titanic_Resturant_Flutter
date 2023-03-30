import 'package:get/get.dart';


class NavigatorScreenController extends GetxController{
  RxString titleBar="Home".obs;

  void onClickAccount(){
    titleBar.value="My Account";
  }

  void onClickSearch(){
    titleBar.value="Search";
  }

  void onClickFavorite(){
    titleBar.value="Favorite";
  }

  void onClickOrders(){
    titleBar.value="Orders";
  }
  void onClickHome(){
    titleBar.value="Home";
  }
}