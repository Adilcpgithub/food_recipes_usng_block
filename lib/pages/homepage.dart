import 'package:flutter/material.dart';
import 'package:food_recipes_with_bloc/Api/http.dart';
import 'package:food_recipes_with_bloc/Cards/Recipecard.dart';
import 'package:food_recipes_with_bloc/model/recipe_model.dart';
import 'package:food_recipes_with_bloc/pages/post_recipes.dart';

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
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          title: Center(
              child: Text(
            '   Food Recipes',
            style: TextStyle(
                fontSize: 22,
                fontFamily: AutofillHints.creditCardExpirationDay,
                fontWeight: FontWeight.w500),
          )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return RecipeFormPage();
                    }));
                  },
                  child: const Icon(
                    size: 30,
                    Icons.send,
                    color: Color.fromARGB(255, 131, 73, 3),
                  )),
            ),
            SizedBox(
              width: 13,
            )
          ],
        ),
        body: isLoading
            ? Center(child: const CircularProgressIndicator())
            : SafeArea(
                child: ListView.builder(
                    itemCount: _recipes.length,
                    itemBuilder: (context, index) {
                      return RecipeCard(
                          title: _recipes[index].name,
                          cookTime: _recipes[index].cookingTime,
                          rating: _recipes[index].rating,
                          thumbnailUrl: _recipes[index].image);
                    }),
              ));
  }
}
