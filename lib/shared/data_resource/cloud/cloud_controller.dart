import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'category.dart';



class CloudController extends GetxController{

  FirebaseFirestore firestore= FirebaseFirestore.instance;

  @override
  void onInit() {
    saveFoodCategoryes();
    // TODO: implement onInit
    super.onInit();
  }

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

  // جلب جميع بيانات المستخدمين
  Future<List<DocumentSnapshot>> getAllUsersInfo() async {
    QuerySnapshot querySnapshot =await firestore.collection("UsersInfo").get();
   List<DocumentSnapshot> list= querySnapshot.docs;
   return list;
  }


  //API من  Category جلب بيانات
  Future<List<Category>>? getAllCategory() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['categories'];
      final categoryList = jsonList.map((json) => Category.fromJson(json)).toList();
      return categoryList;
    } else {
      return [];
    }
  }
  

  //Fire Base و حفظها في  API جلب البيانات من
  void saveFoodCategoryes() async {
    List<Category>? listCategory=await getAllCategory();
List<Category> litFireBase = await getCategoryFromFireBase();
// Nested Loop to refresh data
try{
  for(int i=0 ; i<=listCategory!.length ; i++ ){
    for(int t=i+1 ; t<litFireBase.length ; t++){
      if(listCategory.elementAt(i)!= litFireBase.elementAt(t)){
        Map<String , dynamic> map ={
          "id":listCategory.elementAt(i).id,
          "imageUrl":listCategory.elementAt(i).imageUrl,
          "description":listCategory.elementAt(i).description,
          "nameCategory":listCategory.elementAt(i).nameCategory
        };
      }

    }
  }
}catch(e){
  print(e.toString());
}
  }

  //Fire Base من  Category جلب بيانات
  Future<List<Category>> getCategoryFromFireBase() async {
    List<Category> list=[];
    QuerySnapshot querySnapshot=await firestore.collection("Category").get() ;

    // Array List حفظ البيانات في
   List<DocumentSnapshot> listCategory= querySnapshot.docs;

     try{
       for(DocumentSnapshot category in listCategory){
         Map<String , dynamic > mapCategory=category.data() as Map<String, dynamic>;
         String? id=mapCategory!["id"];
         String? imageUrl=mapCategory!["imageUrl"];
         String? description=mapCategory!["description"];
         String? nameCategory=mapCategory!["nameCategory"];
         list.add(Category(id: id!, imageUrl: imageUrl!, description: description!, nameCategory: nameCategory!));


       }
     }catch(e){

     }

    return list;
  }





}