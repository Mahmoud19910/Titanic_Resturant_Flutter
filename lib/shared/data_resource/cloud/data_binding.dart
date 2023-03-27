import 'package:get/get.dart';
import 'package:resturantapp/shared/data_resource/cloud/cloud_controller.dart';

class DataBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => CloudController());
  }


}