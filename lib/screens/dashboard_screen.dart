import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ingredient_provider.dart';
import '../providers/recipe_provider.dart';
import '../providers/user_recipe_provider.dart';
import 'recipe_detail_screen.dart';
import 'combined_recipes_screen.dart';
import 'user_recipes_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize user recipes data
    Provider.of<UserRecipeProvider>(context, listen: false).fetchUserRecipes();
  }

  @override
  Widget build(BuildContext context) {
    final ingCount = Provider.of<IngredientProvider>(context).items.length;
    final recipe = Provider.of<RecipeProvider>(context).getRandomRecipe();
    final userRecipes = Provider.of<UserRecipeProvider>(context).items;

    return Scaffold(
      backgroundColor: Color(0xFFFFF8E1), // Light cream background
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.restaurant, size: 28),
            SizedBox(width: 8),
            Text('Kitchen Keeper'),
          ],
        ),
        backgroundColor: Color(0xFFE65100),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Card(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [Color(0xFFE65100), Color(0xFFFF9800)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.kitchen, color: Colors.white, size: 32),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'วัตถุดิบทั้งหมด: $ingCount รายการ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Recommended Recipe Section
            Row(
              children: [
                Icon(Icons.star, color: Color(0xFFE65100), size: 24),
                SizedBox(width: 8),
                Text(
                  'เมนูแนะนำวันนี้',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE65100),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFFE65100),
                  child: Icon(Icons.restaurant_menu, color: Colors.white),
                ),
                title: Text(
                  recipe.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                subtitle: Text('คลิกเพื่อดูรายละเอียด'),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFFE65100),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecipeDetailScreen(recipe: recipe),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),

            // My Recipes Section
            Row(
              children: [
                Icon(Icons.person, color: Color(0xFF4CAF50), size: 24),
                SizedBox(width: 8),
                Text(
                  'เมนูของฉัน',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            _buildMyRecipesSection(userRecipes),
            SizedBox(height: 24),

            // View All Recipes Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CombinedRecipesScreen()),
                  );
                },
                icon: Icon(Icons.restaurant_menu),
                label: Text('ดูเมนูทั้งหมด'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyRecipesSection(List userRecipes) {
    if (userRecipes.isEmpty) {
      return Card(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[50],
            border: Border.all(color: Colors.grey[300]!, width: 1),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.grey[600], size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'ยังไม่มีเมนูที่บันทึกไว้',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Color(0xFF4CAF50),
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text(
            userRecipes.first.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            userRecipes.first.ingredients.split('\n').take(2).join(', '),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF4CAF50)),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => UserRecipesScreen()),
          ),
        ),
      );
    }
  }
}
