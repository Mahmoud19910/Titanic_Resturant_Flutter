import 'package:get/get.dart';
import 'package:resturantapp/shared/data_resource/firebase_database/users_info_collection_controller.dart';

class FireBaseBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => UsersInfoCollectionController());
  }


}