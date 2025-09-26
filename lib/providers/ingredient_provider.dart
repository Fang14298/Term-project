import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/ingredient.dart';

class IngredientProvider with ChangeNotifier {
  List<Ingredient> _items = [];
  List<Ingredient> get items => _items;

  Future<void> fetchIngredients() async {
    _items = await DatabaseHelper.instance.getIngredients();
    notifyListeners();
  }

  Future<void> addIngredient(
    String name,
    String expireDate, {
    String? note,
  }) async {
    await DatabaseHelper.instance.insertIngredient(
      Ingredient(name: name, expireDate: expireDate, note: note),
    );
    await fetchIngredients();
  }

  Future<void> deleteIngredient(int id) async {
    await DatabaseHelper.instance.deleteIngredient(id);
    await fetchIngredients();
  }

  Future<void> updateIngredient(
    int id,
    String name,
    String expireDate, {
    String? note,
  }) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'ingredients',
      {'name': name, 'expireDate': expireDate, 'note': note},
      where: 'id = ?',
      whereArgs: [id],
    );
    await fetchIngredients();
  }
}
