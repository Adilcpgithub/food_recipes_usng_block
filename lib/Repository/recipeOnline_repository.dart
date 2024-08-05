import 'dart:convert';
import 'package:food_recipes_with_bloc/model/recipe_model.dart';
import 'package:http/http.dart' as http;

class RecipeyOnlie {
  static Future<List<Recipe>> getRecipe() async {
    print('Fetching recipes...');
    final url = 'https://yummly2.p.rapidapi.com/feeds/list?limit=24&start=0';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'x-rapidapi-host': 'yummly2.p.rapidapi.com',
        'x-rapidapi-key': '59baf28425msh7a46bb827b3ca52p1a8e55jsn0d748c22963c'
      },
    );

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
    } else {
      print('Failed to load data');
      return [];
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    List<dynamic> feed = data['feed'] ?? [];

    List<Recipe> recipes = [];
    for (var item in feed) {
      var details = item['content']['details'] ?? {};
      String imageUrl =
          details['images'] != null && details['images'].isNotEmpty
              ? details['images'][0]['hostedLargeUrl'] ?? ''
              : '';
      recipes.add(
        Recipe(
          image: imageUrl,
          name: details['displayName'] ?? '',
          rating: details['rating']?.toString() ?? '',
          cookingTime: details['totalTime'] ?? '',
        ),
      );
    }

    return recipes;
  }
/////////////////////////////

  static Future<void> postRecipeData(Map<String, dynamic> data) async {
    final url =
        'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/analyze?language=en&includeNutrition=false&includeTaste=false';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'x-rapidapi-host':
            'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com',
        'x-rapidapi-key': '59baf28425msh7a46bb827b3ca52p1a8e55jsn0d748c22963c',
      },
      body: jsonEncode(data),
    );
    print('Response: ${response.body}');
    if (response.statusCode == 201) {
      print('Response: ${response.body}');
    } else {
      // Handle error
      print('Failed to post data: ${response.statusCode}');
    }
  }
}
