import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_recipe_provider.dart';

class AddUserRecipeScreen extends StatefulWidget {
  @override
  _AddUserRecipeScreenState createState() => _AddUserRecipeScreenState();
}

class _AddUserRecipeScreenState extends State<AddUserRecipeScreen> {
  final _nameController = TextEditingController();
  final _ingController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _nutritionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8E1),
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add_circle_outline, size: 24),
            SizedBox(width: 8),
            Text('เพิ่มเมนูอาหาร'),
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          _instructionsController.text.isEmpty)
                        return;
                      await Provider.of<UserRecipeProvider>(
                        context,
                        listen: false,
                      ).addUserRecipe(
                        _nameController.text,
                        _ingController.text,
                        _instructionsController.text,
                        _nutritionController.text.isEmpty
                            ? null
                            : _nutritionController.text,
                      );
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.save),
                    label: Text('บันทึกเมนู'),
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
