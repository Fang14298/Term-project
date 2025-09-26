import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ingredient_provider.dart';
import 'add_ingredient_screen.dart';

class FridgeItemsScreen extends StatefulWidget {
  @override
  _FridgeItemsScreenState createState() => _FridgeItemsScreenState();
}

class _FridgeItemsScreenState extends State<FridgeItemsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<IngredientProvider>(context, listen: false).fetchIngredients();
  }

  // Small reusable themed input
  // Placed inside this file to avoid creating extra files
  // Uses food-themed icons and rounded borders
  Widget _ThemedField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
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

  // ✅ เพิ่มพารามิเตอร์ oldNote
  void _editItem(
    BuildContext context,
    int id,
    String oldName,
    String oldDate,
    String? oldNote,
  ) {
    final nameController = TextEditingController(text: oldName);
    final dateController = TextEditingController(text: oldDate);
    final noteController = TextEditingController(
      text: oldNote ?? '',
    ); // ✅ ช่องหมายเหตุ

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.kitchen, color: Color(0xFFE65100)),
            SizedBox(width: 8),
            Text('แก้ไขวัตถุดิบ'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ThemedField(
                controller: nameController,
                label: 'ชื่อวัตถุดิบ',
                icon: Icons.local_grocery_store,
              ),
              SizedBox(height: 12),
              _ThemedField(
                controller: dateController,
                label: 'วันหมดอายุ',
                icon: Icons.schedule,
              ),
              SizedBox(height: 12),
              _ThemedField(
                controller: noteController,
                label: 'หมายเหตุ',
                icon: Icons.note,
              ),
            ],
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.grey[500],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () async {
              await Provider.of<IngredientProvider>(
                context,
                listen: false,
              ).updateIngredient(
                id,
                nameController.text,
                dateController.text,
                note: noteController.text.isEmpty ? null : noteController.text,
              );
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFFE65100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('บันทึก'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ingredients = Provider.of<IngredientProvider>(context).items;
    return Scaffold(
      backgroundColor: Color(0xFFFFF8E1),
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.kitchen, size: 24),
            SizedBox(width: 8),
            Text('ตู้เย็น'),
          ],
        ),
        backgroundColor: Color(0xFFE65100),
        foregroundColor: Colors.white,
      ),
      body: ingredients.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.kitchen_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'ตู้เย็นยังว่างเปล่า',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'เพิ่มวัตถุดิบเพื่อเริ่มต้น',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Header Card
                Card(
                  margin: EdgeInsets.all(16),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.inventory_2, color: Colors.white, size: 32),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'วัตถุดิบทั้งหมด',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              Text(
                                '${ingredients.length} รายการ',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Ingredients List
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: ingredients.length,
                    itemBuilder: (ctx, i) => Card(
                      margin: EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getExpiryColor(
                            ingredients[i].expireDate,
                          ),
                          child: Icon(
                            Icons.local_grocery_store,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          ingredients[i].name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'หมดอายุ: ${ingredients[i].expireDate}',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            if (ingredients[i].note != null &&
                                ingredients[i].note!.isNotEmpty) ...[
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Icon(
                                    Icons.note,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      'หมายเหตุ: ${ingredients[i].note}',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Color(0xFFE65100)),
                              onPressed: () => _editItem(
                                context,
                                ingredients[i].id!,
                                ingredients[i].name,
                                ingredients[i].expireDate,
                                ingredients[i].note,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red[600]),
                              onPressed: () {
                                Provider.of<IngredientProvider>(
                                  context,
                                  listen: false,
                                ).deleteIngredient(ingredients[i].id!);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AddIngredientScreen()),
        ),
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFE65100),
      ),
    );
  }

  Color _getExpiryColor(String expireDate) {
    // Simple logic to determine color based on expiry date
    // You can enhance this with actual date parsing
    if (expireDate.contains('ใกล้หมด') || expireDate.contains('วันนี้')) {
      return Colors.red[600]!;
    } else if (expireDate.contains('พรุ่งนี้') ||
        expireDate.contains('2-3 วัน')) {
      return Colors.orange[600]!;
    } else {
      return Color(0xFF4CAF50);
    }
  }
}
