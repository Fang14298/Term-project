import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import 'recipe_detail_screen.dart';

class AllRecipesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipes = Provider.of<RecipeProvider>(context).recipes;

    return Scaffold(
      appBar: AppBar(title: Text('เมนูทั้งหมด')),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (ctx, i) => Card(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Text(recipes[i].name, style: TextStyle(fontSize: 18)),
            subtitle: Text('คลิกเพื่อดูรายละเอียด'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeDetailScreen(recipe: recipes[i]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
