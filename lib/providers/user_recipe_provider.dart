import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/user_recipe.dart';

class UserRecipeProvider with ChangeNotifier {
  List<UserRecipe> _items = [];
  List<UserRecipe> get items => _items;

  Future<void> fetchUserRecipes() async {
    final db = await DatabaseHelper.instance.database;
    final res = await db.query('user_recipes', orderBy: 'id DESC');
    _items = res.map((e) => UserRecipe.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> addUserRecipe(
      String name, String ingredients, String instructions, String? nutrition) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert(
      'user_recipes',
      UserRecipe(
        name: name,
        ingredients: ingredients,
        instructions: instructions,
        nutrition: nutrition,
      ).toMap(),
    );
    await fetchUserRecipes();
  }

  Future<void> deleteUserRecipe(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('user_recipes', where: 'id = ?', whereArgs: [id]);
    await fetchUserRecipes();
  }

  Future<void> updateUserRecipe(
    int id,
    String name,
    String ingredients,
    String instructions,
    String? nutrition,
  ) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'user_recipes',
      {
        'name': name,
        'ingredients': ingredients,
        'instructions': instructions,
        'nutrition': nutrition,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    await fetchUserRecipes();
  }
}
