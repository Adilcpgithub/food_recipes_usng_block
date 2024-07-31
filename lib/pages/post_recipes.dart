import 'package:flutter/material.dart';
import 'package:food_recipes_with_bloc/Api/http.dart';

class RecipeFormPage extends StatefulWidget {
  @override
  _RecipeFormPageState createState() => _RecipeFormPageState();
}

class _RecipeFormPageState extends State<RecipeFormPage> {
  final _titleController = TextEditingController();
  final _servingsController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();

  void _submitData() {
    final data = {
      'title': _titleController.text,
      'servings': int.tryParse(_servingsController.text) ?? 1,
      'ingredients': _ingredientsController.text.split(','),
      'instructions': _instructionsController.text,
    };
    RecipeApi.postRecipeData(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text('Submit Recipe'),
      ),
      body: Container(
        color: Colors.grey[200], // Background color for the whole body
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                StylishTextField(
                  controller: _titleController,
                  hintText: 'Title',
                  icon: Icons.title,
                ),
                StylishTextField(
                  controller: _servingsController,
                  hintText: 'Servings',
                  icon: Icons.restaurant,
                  keyboardType: TextInputType.number,
                ),
                StylishTextField(
                  controller: _ingredientsController,
                  hintText: 'Ingredients (comma separated)',
                  icon: Icons.list,
                ),
                StylishTextField(
                  controller: _instructionsController,
                  hintText: 'Instructions',
                  icon: Icons.description,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitData,
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StylishTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;

  StylishTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
