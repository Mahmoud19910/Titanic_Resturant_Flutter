import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersInfoCollectionController extends GetxController{
  FirebaseFirestore firestore= FirebaseFirestore.instance;


  // حفظ بيانات المستخدم
  void saveUsersInfo(String uid , String name  , String phoneNumber , String pass , BuildContext context){
    Map<String , dynamic> mapArray = {
      "uid" : uid,
      "name" : name,
      "phoneNumber" : phoneNumber,
      "pass" : pass
    };

    try{
      firestore.collection("UsersInfo").add(mapArray);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

    }

  }

  Future<List<DocumentSnapshot>> getAllUsersInfo() async {
    QuerySnapshot querySnapshot =await firestore.collection("UsersInfo").get();
   List<DocumentSnapshot> list= querySnapshot.docs;
   return list;
  }
}