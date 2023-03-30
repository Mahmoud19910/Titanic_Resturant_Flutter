import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:resturantapp/controlers/verify_controller.dart';
import 'package:resturantapp/modles/favorite.dart';
import 'package:resturantapp/modles/meals.dart';
import 'package:resturantapp/modles/search_in_meals.dart';

import '../../../modles/category.dart';



class CloudController extends GetxController{

  FirebaseFirestore firestore= FirebaseFirestore.instance;

  var verifyController = Get.find<VerifyController>();
  var form = GlobalKey<FormState>();

  RxString name = 'abed'.obs;

  @override
  void onInit() {
    saveFoodCategoryes();
    // TODO: implement onInit
    super.onInit();
  }

  // حفظ بيانات المستخدم
  void saveUsersInfo(String uid , String name  , String phoneNumber , String pass , BuildContext context) async {


    try{
      Map<String , dynamic> mapArray = {
        "uid" : uid,
        "name" : name,
        "phoneNumber" : phoneNumber,
        "pass" : pass
      };
      await firestore.collection("UsersInfo").add(mapArray);
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

  updateName(String newValue){
    name.value = newValue;
  }
  
 
  // جلب بيانات عن طريق الحرف الاول 
  Stream<List<SearchInMeals>> getAllMealsByFirstChar(String charcter) async* {
    try{
      final response= await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?f=${charcter}"));
      if(response.statusCode==200){
        final List<dynamic> jsonList = json.decode(response.body)['meals'];
        final mealsList = jsonList.map((json) => SearchInMeals.fromJson(json)).toList();
        yield  mealsList;
      }else {
        yield  [];
      }
    }catch(e){

    }

  }


  //FireBase ميثود لتحديث الأقسام في
  void saveFoodCategoryes() async {
    Stream<List<Category>> fireBaseStream = getCategoryFromFireBaseStream();
    List<Category>? listCategory = await getAllCategory();

    try {
      await for (List<Category> listFireBase in fireBaseStream) {
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
      }
    } catch (e) {
      print(e.toString());
    }
  }


  //Fire Base حفظ جميع الأطعمة من عن طريق تمرير اسم القسم من
  void saveMealsCategory(String categoryName) async {
    List<Meals> listMeals = await getAllMealCategory(categoryName);
    Stream<List<Meals>> mealsStream = getMealsFromFireBaseStream(categoryName);
    mealsStream.listen((listFireBase) {
      try {
        for (Meals mealsApi in listMeals) {
          bool isFound = false;
          for (Meals mealsFireBase in listFireBase) {
            if (mealsApi.idMeals == mealsFireBase.idMeals) {
              isFound = true;
              break;
            }
          }

          if (!isFound) {
            Map<String, dynamic> map = {
              "id": mealsApi.idMeals,
              "nameMeals": mealsApi.nameMeals,
              "imageMeals": mealsApi.imageUrlMeals,
            };
            firestore.collection(categoryName).add(map);
          }
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }
  // Fire Base اضافة الى المفضلة في
  void saveMealsToFavorite(Meals meals) async {
    // Check if the meals object already exists in Firebase
    QuerySnapshot querySnapshot = await firestore
        .collection("Favorite")
        .where("id", isEqualTo: meals.idMeals)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Meals object already exists in Firebase
      return;
    }

    // Meals object doesn't exist in Firebase, add it
    Map<String, dynamic> mapFavorite = {
      "id": meals.idMeals,
      "nameMeals": meals.nameMeals,
      "imageUrlMeals": meals.imageUrlMeals,
    };
    await firestore.collection("Favorite").doc().set(mapFavorite);
  }

  //Fire Base من  Category جلب بيانات
  Stream<List<Category>> getCategoryFromFireBaseStream() async* {
    try {
      // Stream of QuerySnapshot
      Stream<QuerySnapshot> stream =
      firestore.collection("Category").snapshots();

      await for (QuerySnapshot querySnapshot in stream) {
        List<Category> list = [];

        // Array List حفظ البيانات في
        List<DocumentSnapshot> listCategory = querySnapshot.docs;

        for (DocumentSnapshot category in listCategory) {
          Map<String, dynamic> mapCategory =
          category.data() as Map<String, dynamic>;
          String? id = mapCategory!["id"];
          String? imageUrl = mapCategory!["imageUrl"];
          String? description = mapCategory!["description"];
          String? nameCategory = mapCategory!["nameCategory"];

          list.add(Category(
              id: id!,
              imageUrl: imageUrl!,
              description: description!,
              nameCategory: nameCategory!));
        }
        yield list;
      }
    } catch (e) {
      // Handle error
    }
  }

  //Fire Base جلب جميع الأطعمة من عن طريق تمرير اسم القسم من
  Stream<List<Meals>> getMealsFromFireBaseStream(String categoryName) {
    return firestore.collection(categoryName).snapshots().map((querySnapshot) {
      List<Meals> listMeals = [];

      querySnapshot.docs.forEach((documentSnapshot) {
        Map<String, dynamic> mapMeals = documentSnapshot.data() as Map<String, dynamic>;
        String id = mapMeals['id'];
        String name = mapMeals['nameMeals'];
        String image = mapMeals['imageMeals'];
        listMeals.add(Meals(idMeals: id, nameMeals: name, imageUrlMeals: image));
      });

      return listMeals;
    });
  }

  // جلب قائمة المفضلة
  Stream<List<Favorite>> getFavoriteMealsStreamFromFirebase() {
    return FirebaseFirestore.instance
        .collection('Favorite')
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
        .map((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> mapMeals = documentSnapshot.data() as Map<String, dynamic>;
      String id = mapMeals['id'];
      String imageUrlMeals = mapMeals['imageUrlMeals'];
      String nameMeals = mapMeals['nameMeals'];
      Meals meals =
      Meals(idMeals: id, nameMeals: nameMeals, imageUrlMeals: imageUrlMeals);
      Favorite favorite = Favorite(meals);
      return favorite;
    })
        .toList());
  }

  Future<void> deleteFavoriteMealFromFirebaseByName(String name) async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('Favorite').where('id', isEqualTo: name).get();

    querySnapshot.docs.forEach((documentSnapshot) async {
      if (documentSnapshot.exists) {
        await documentSnapshot.reference.delete();
      }
    });
  }







}