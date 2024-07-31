import 'dart:convert';

class Recipe {
  final String image;
  final String name;
  final String rating;
  final String cookingTime;

  Recipe(
      {required this.image,
      required this.name,
      required this.rating,
      required this.cookingTime});
  factory Recipe.formJson(dynamic json) {
    return Recipe(
        image: json['images'][0]['hostesdLargeUrl'] as String,
        name: json['name'] as String,
        rating: json['rating'] as String,
        cookingTime: json['totalTime'] as String);
  }
  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.formJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe{name:$name,image: $image, tating :$rating, totaltime: $cookingTime}';
  }
}
