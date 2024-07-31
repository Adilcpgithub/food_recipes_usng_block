class Recipe {
  final String image;
  final String name;
  final String rating;
  final String cookingTime;

  Recipe({
    required this.image,
    required this.name,
    required this.rating,
    required this.cookingTime,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      image: json['images'] != null && json['images'].isNotEmpty
          ? json['images'][0]['hostedLargeUrl'] ?? ''
          : '',
      name: json['displayName'] ?? '',
      rating: json['rating']?.toString() ?? '',
      cookingTime: json['totalTime'] ?? '',
    );
  }

  static List<Recipe> recipesFromSnapshot(List<dynamic> snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe{name: $name, image: $image, rating: $rating, cookingTime: $cookingTime}';
  }
}
