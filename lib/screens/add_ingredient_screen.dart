import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ingredient_provider.dart';

class AddIngredientScreen extends StatefulWidget {
  const AddIngredientScreen({super.key});

  @override
  _AddIngredientScreenState createState() => _AddIngredientScreenState();
}

class _AddIngredientScreenState extends State<AddIngredientScreen> {
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _noteController = TextEditingController();

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
            Text('เพิ่มวัตถุดิบ'),
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
                  'ชื่อวัตถุดิบ',
                  Icons.local_grocery_store,
                ),
                SizedBox(height: 12),
                _buildThemedField(
                  _dateController,
                  'วันหมดอายุ (yyyy-mm-dd)',
                  Icons.schedule,
                ),
                SizedBox(height: 12),
                _buildThemedField(_noteController, 'หมายเหตุ', Icons.note),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (_nameController.text.isEmpty ||
                          _dateController.text.isEmpty)
                        return;
                      await Provider.of<IngredientProvider>(
                        context,
                        listen: false,
                      ).addIngredient(
                        _nameController.text,
                        _dateController.text,
                        note: _noteController.text.isEmpty
                            ? null
                            : _noteController.text,
                      );
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.save),
                    label: Text('บันทึกวัตถุดิบ'),
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
