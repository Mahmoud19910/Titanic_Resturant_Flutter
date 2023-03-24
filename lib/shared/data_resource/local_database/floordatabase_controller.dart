import 'package:get/get.dart';
import 'package:resturantapp/modles/usersinfo.dart';
import 'package:resturantapp/modles/usersinfo_dao.dart';
import 'package:resturantapp/shared/data_resource/local_database/database.dart';

class FloorDataBaseController extends GetxController{

  late UsersInfoDao usersInfoDao;
  late AppDataBase appDataBase;
  final usersList = <UsersInfo>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    createDataBase();

  }

  void createDataBase () async {
   appDataBase= await $FloorAppDataBase.databaseBuilder('app_database.db').build();
   usersInfoDao=appDataBase.usersDao;
   usersInfoDao.getAllUsers().listen((usersData) {
     usersList.value = usersData;
   });
  }


  void addUsers(UsersInfo usersInfo) async {
    await usersInfoDao.insertUsers(usersInfo);
  }
  
  void updateUsers(UsersInfo usersInfo){
    usersInfoDao.updateUsers(usersInfo);
  }





}