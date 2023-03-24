import 'dart:typed_data';
import 'package:floor/floor.dart';
@entity
class UsersInfo{
  @primaryKey
  late String uid;
  String? name;
  String? pass;
  String? phone;
  Uint8List? photo;

  UsersInfo({required this.uid, this.name, this.pass, this.phone, this.photo});
}