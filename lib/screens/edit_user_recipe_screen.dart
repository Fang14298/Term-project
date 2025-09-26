import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_recipe_provider.dart';
import '../models/user_recipe.dart';

class EditUserRecipeScreen extends StatefulWidget {
  final UserRecipe recipe;

  const EditUserRecipeScreen({Key? key, required this.recipe})
    : super(key: key);

  @override
  _EditUserRecipeScreenState createState() => _EditUserRecipeScreenState();
}

class _EditUserRecipeScreenState extends State<EditUserRecipeScreen> {
  final _nameController = TextEditingController();
  final _ingController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _nutritionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill the form with existing recipe data
    _nameController.text = widget.recipe.name;
    _ingController.text = widget.recipe.ingredients;
    _instructionsController.text = widget.recipe.instructions;
    _nutritionController.text = widget.recipe.nutrition ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ingController.dispose();
    _instructionsController.dispose();
    _nutritionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8E1),
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.edit, size: 24),
            SizedBox(width: 8),
            Text('แก้ไขเมนูอาหาร'),
          ],
        ),
        backgroundColor: Color(0xFFE65100),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildThemedField(
                  _nameController,
                  'ชื่อเมนู',
                  Icons.restaurant,
                ),
                SizedBox(height: 12),
                _buildThemedField(
                  _ingController,
                  'ส่วนผสม (คั่นบรรทัด)',
                  Icons.list,
                  maxLines: 4,
                ),
                SizedBox(height: 12),
                _buildThemedField(
                  _instructionsController,
                  'วิธีทำ',
                  Icons.menu_book,
                  maxLines: 4,
                ),
                SizedBox(height: 12),
                _buildThemedField(
                  _nutritionController,
                  'โภชนาการ (ถ้ามี)',
                  Icons.favorite_border,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (_nameController.text.isEmpty ||
                          _ingController.text.isEmpty ||
                          _instructionsController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
                        );
                        return;
                      }

                      await Provider.of<UserRecipeProvider>(
                        context,
                        listen: false,
                      ).updateUserRecipe(
                        widget.recipe.id!,
                        _nameController.text,
                        _ingController.text,
                        _instructionsController.text,
                        _nutritionController.text.isEmpty
                            ? null
                            : _nutritionController.text,
                      );

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('แก้ไขเมนูเรียบร้อยแล้ว')),
                      );
                    },
                    icon: Icon(Icons.save),
                    label: Text('บันทึกการแก้ไข'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemedField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFFE65100)),
        filled: true,
        fillColor: Colors.orange.withOpacity(0.05),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.orange.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFE65100), width: 2),
        ),
      ),
    );
  }
}
