
import 'package:get/get.dart';

class UnboardingController extends GetxController{


  int indexPagerView=0;

  String title='Express delivery service';
  String decription='The application provides its users with a service Delivery by location by Google Maps';

  void setChanged(int index){
    indexPagerView=index;
    update();
  }

  void setTilteAndDesc(){
    switch(indexPagerView){
      case 0:
        title='Express delivery service';
        decription='The application provides its users with a service Delivery by location by Google Maps';
        update();

        break;
      case 1:
        title='Reservation service';
        decription='There is a section in the application that you canThrough it book the best places as appropriate your happy occasions';
        update();

        break;
      case 2:
        title='Online payment service';
        decription='The application allows users to easily Pay by one of the electronic payment methods(Jul Pay _ Visa Card _ Bank of Palestine)';
        update();
        break;

    }

  }


}