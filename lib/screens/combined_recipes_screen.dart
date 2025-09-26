import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../providers/user_recipe_provider.dart';
import 'recipe_detail_screen.dart';
import 'user_recipes_screen.dart';

class CombinedRecipesScreen extends StatefulWidget {
  @override
  _CombinedRecipesScreenState createState() => _CombinedRecipesScreenState();
}

class _CombinedRecipesScreenState extends State<CombinedRecipesScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize user recipes data
    Provider.of<UserRecipeProvider>(context, listen: false).fetchUserRecipes();
  }

  @override
  Widget build(BuildContext context) {
    final systemRecipes = Provider.of<RecipeProvider>(context).recipes;
    final userRecipes = Provider.of<UserRecipeProvider>(context).items;

    return Scaffold(
      backgroundColor: Color(0xFFFFF8E1),
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.restaurant_menu, size: 24),
            SizedBox(width: 8),
            Text('เมนูทั้งหมด'),
          ],
        ),
        backgroundColor: Color(0xFFE65100),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // System Recipes Section
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'เมนูแนะนำจากระบบ (${systemRecipes.length} รายการ)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: systemRecipes.length,
              itemBuilder: (ctx, i) => Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: Icon(Icons.restaurant_menu, color: Colors.blue),
                  title: Text(
                    systemRecipes[i].name,
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Text('เมนูแนะนำจากระบบ'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            RecipeDetailScreen(recipe: systemRecipes[i]),
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 20),

            // User Recipes Section
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'เมนูของฉัน (${userRecipes.length} รายการ)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ),
            if (userRecipes.isEmpty)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'ยังไม่มีเมนูที่บันทึกไว้',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: userRecipes.length,
                itemBuilder: (ctx, i) => Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Icon(Icons.person, color: Colors.green),
                    title: Text(
                      userRecipes[i].name,
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      userRecipes[i].ingredients.split('\n').take(2).join(', '),
                    ),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => UserRecipesScreen()),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
