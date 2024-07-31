import 'package:flutter/material.dart';
import 'package:food_recipes_with_bloc/Cards/Recipecard.dart';
import 'package:food_recipes_with_bloc/http.dart';
import 'package:food_recipes_with_bloc/model/recipe_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getRecipes();
    print(_recipes);
    super.initState();
  }

  List<Recipe> _recipes = [];

  bool isLoading = true;
  Future<void> getRecipes() async {
    try {
      _recipes = await RecipeApi.getRecipe();
      print('Recipes fetched: ${_recipes.length}');
    } catch (e) {
      print('Error fetching recipes: $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(child: const CircularProgressIndicator())
            : ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                      title: _recipes[index].name,
                      cookTime: _recipes[index].cookingTime,
                      rating: _recipes[index].rating,
                      thumbnailUrl: _recipes[index].image);
                }));
  }
}
