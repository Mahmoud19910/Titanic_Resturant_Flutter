class SearchInMeals{
  late String id;
  late String name;
  late String imageUrl;

  SearchInMeals({required this.id, required this.name, required this.imageUrl});

  factory SearchInMeals.fromJson(Map<String, dynamic> json) {
    return SearchInMeals(
      id: json['idMeal'],
      name: json['strMeal'],
      imageUrl: json['strMealThumb'],
    );
  }
}