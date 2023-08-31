class SearchInMeals{
  late String idMeals;
  late String nameMeals;
  late String imageUrlMeals;

  SearchInMeals({required this.idMeals, required this.nameMeals, required this.imageUrlMeals});

  factory SearchInMeals.fromJson(Map<String, dynamic> json) {
    return SearchInMeals(
      idMeals: json['idMeal'],
      nameMeals: json['strMeal'],
      imageUrlMeals: json['strMealThumb'],
    );
  }
}