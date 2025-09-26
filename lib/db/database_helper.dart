import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/ingredient.dart';
import '../models/user_recipe.dart'; // ✅ เพิ่ม

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'moodmeal.db');

    return await openDatabase(
      path,
      version: 3, // ✅ อัปเดตเวอร์ชัน
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // เพิ่มคอลัมน์ note ใน ingredients ถ้ายังไม่มี
          await db.execute('ALTER TABLE ingredients ADD COLUMN note TEXT;');
        }
        if (oldVersion < 3) {
          // ✅ สร้างตาราง user_recipes ถ้ายังไม่มี
          await db.execute('''
            CREATE TABLE user_recipes (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              ingredients TEXT,
              instructions TEXT,
              nutrition TEXT
            )
          ''');
        }
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    // ตารางวัตถุดิบ
    await db.execute('''
      CREATE TABLE ingredients (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        expireDate TEXT,
        note TEXT
      )
    ''');

    // ✅ ตารางเมนูอาหารผู้ใช้
    await db.execute('''
      CREATE TABLE user_recipes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        ingredients TEXT,
        instructions TEXT,
        nutrition TEXT
      )
    ''');
  }

  // ---------------- ingredients ----------------
  Future<int> insertIngredient(Ingredient ing) async {
    final db = await database;
    return await db.insert('ingredients', ing.toMap());
  }

  Future<List<Ingredient>> getIngredients() async {
    final db = await database;
    final res = await db.query('ingredients', orderBy: 'expireDate ASC');
    return res.map((e) => Ingredient.fromMap(e)).toList();
  }

  Future<int> deleteIngredient(int id) async {
    final db = await database;
    return await db.delete('ingredients', where: 'id = ?', whereArgs: [id]);
  }

  // ---------------- user_recipes ----------------
  Future<int> insertUserRecipe(UserRecipe recipe) async {
    final db = await database;
    return await db.insert('user_recipes', recipe.toMap());
  }

  Future<List<UserRecipe>> getUserRecipes() async {
    final db = await database;
    final res = await db.query('user_recipes', orderBy: 'id DESC');
    return res.map((e) => UserRecipe.fromMap(e)).toList();
  }

  Future<int> deleteUserRecipe(int id) async {
    final db = await database;
    return await db.delete('user_recipes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateUserRecipe(UserRecipe recipe) async {
    final db = await database;
    return await db.update(
      'user_recipes',
      recipe.toMap(),
      where: 'id = ?',
      whereArgs: [recipe.id],
    );
  }
}
