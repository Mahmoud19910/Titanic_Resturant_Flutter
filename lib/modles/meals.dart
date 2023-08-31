class Meals{
  late String idMeals;
  late String nameMeals;
  late String imageUrlMeals;
  late bool isAddTofav;

  Meals({required this.idMeals, required this.nameMeals, required this.imageUrlMeals ,  this.isAddTofav=false});

  factory Meals.fromJson(Map<String, dynamic> json) {
    return Meals(
      idMeals: json['idMeal'],
      nameMeals: json['strMeal'],
      imageUrlMeals: json['strMealThumb'],
    );
  }


}