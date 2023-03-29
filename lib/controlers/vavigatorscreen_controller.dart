import 'package:get/get.dart';


class NavigatorScreenController extends GetxController{
  String titleBar="Home";

  void onClickAccount(){
    titleBar="My Account";
    update();
  }

  void onClickSearch(){
    titleBar="Search";
    update();
  }

  void onClickFavorite(){
    titleBar="Favorite";
    update();
  }

  void onClickOrders(){
    titleBar="Orders";
    update();
  }
  void onClickHome(){
    titleBar="Home";
    update();
  }
}