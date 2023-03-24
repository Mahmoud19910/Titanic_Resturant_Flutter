import 'dart:typed_data';

import 'package:floor/floor.dart';
import 'package:resturantapp/modles/usersinfo.dart';
import 'package:resturantapp/modles/usersinfo_dao.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart'; // the generated code will be there

@Database(version: 3, entities: [UsersInfo])
abstract class AppDataBase extends FloorDatabase{
  UsersInfoDao get usersDao;

}