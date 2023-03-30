import 'package:get/get.dart';

class SearchController extends GetxController{
  RxString textChange="a".obs;

  void onChange(String value){
    textChange.value=value;
  }
}