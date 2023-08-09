import 'package:floor/floor.dart';
import 'package:resturantapp/modles/usersinfo.dart';

@dao
abstract class UsersInfoDao{
  @Query('SELECT * FROM UsersInfo')
  Stream<List<UsersInfo>> getAllUsers();

  @Query('SELECT * FROM UsersInfo WHERE uid = :uid')
  Future<UsersInfo?> getUsersById(String uid);

  @Query('SELECT * FROM UsersInfo WHERE phone = :phone')
  Future<UsersInfo?> getUsersByPhoneNumber(String phone);

  @insert
  Future<void> insertUsers(UsersInfo user);

  @delete
  Future<void> deleteUsers(UsersInfo user);

  @Query('DELETE FROM UsersInfo WHERE uid = :uid')
  Future<void> deleteUsersById(String uid);

  @update
  Future<void> updateUsers(UsersInfo usersInfo);

}