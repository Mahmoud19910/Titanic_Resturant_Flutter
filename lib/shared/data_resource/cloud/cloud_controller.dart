import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:resturantapp/modles/meals.dart';

import '../../../modles/category.dart';



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
  
  // API من  Category Meals جلب بيانات
  Future<List<Meals>> getAllMealCategory(String categoryName) async {
    final response=await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryName"));
    if(response.statusCode==200){
      final List<dynamic> jsonList = json.decode(response.body)['meals'];
      final mealsList = jsonList.map((json) => Meals.fromJson(json)).toList();
      return mealsList;
    }else {
      return [];
    }
  }
  



  //FireBase ميثود لتحديث الأقسام في
  void saveFoodCategoryes() async {
    List<Category>? listCategory = await getAllCategory();
    List<Category> listFireBase = await getCategoryFromFireBase();
    try {
      for (Category category in listCategory!) {
        bool isFound = false;
        for (Category firebaseCategory in listFireBase) {
          if (category.id == firebaseCategory.id) {
            isFound = true;
            break;
          }
        }

        if (!isFound) {
          Map<String, dynamic> map = {
            "id": category.id,
            "imageUrl": category.imageUrl,
            "description": category.description,
            "nameCategory": category.nameCategory
          };
          await firestore.collection("Category").add(map);
        }
      }
    } catch (e) {
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


  //Fire Base حفظ جميع الأطعمة من عن طريق تمرير اسم القسم من
  void saveMealsCategory(String categoryName) async {
    List<Meals> listMeals = await getAllMealCategory(categoryName);
    List<Meals> listFireBase = await getMealsFromFireBase(categoryName);
    try{
      for(Meals mealsApi in listMeals){
        bool isFound=false;
        for(Meals mealsFireBase in listFireBase){
          if(mealsApi.idMeals==mealsFireBase.idMeals){
            isFound=true;
            break;
          }
        }

        if(!isFound){
          Map<String , dynamic> map={
            "id":mealsApi.idMeals,
            "nameMeals":mealsApi.nameMeals,
            "imageMeals":mealsApi.imageUrlMeals,
          };
          await firestore.collection(categoryName).add(map);
        }
      }
    }catch(e){
      print(e.toString());
    }



  }

  //Fire Base جلب جميع الأطعمة من عن طريق تمرير اسم القسم من
  Future<List<Meals>> getMealsFromFireBase(String categoryName) async {
    List<Meals> listMeals=[];
    QuerySnapshot querySnapshot= await firestore.collection(categoryName).get();
   List<DocumentSnapshot> list=querySnapshot.docs;

   try{
     for(DocumentSnapshot meals in list){
       Map<String , dynamic>? mapMeals=meals.data() as Map<String, dynamic>?;
       String id=mapMeals!['id'];
       String name=mapMeals!['nameMeals'];
       String image=mapMeals!['imageMeals'];
       listMeals.add(Meals(idMeals: id, nameMeals: name, imageUrlMeals: image));
     }

   }catch(e){
     print(e.toString());
   }
    return listMeals;
  }





}