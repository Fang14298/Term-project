import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;
  RecipeDetailScreen({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ส่วนผสม', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...recipe.ingredients.map((i) => Text('- $i')),
            SizedBox(height: 20),
            Text('วิธีทำ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(recipe.instructions),
            SizedBox(height: 20),
            Text('โภชนาการ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(recipe.nutrition),
          ],
        ),
      ),
    );
  }
}
