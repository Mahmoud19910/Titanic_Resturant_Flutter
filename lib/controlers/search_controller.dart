import 'package:get/get.dart';

class SearchController extends GetxController{
  String textChange="a";

  void onChange(String value){
    textChange=value;
    update();
  }
}