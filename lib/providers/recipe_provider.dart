import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeProvider with ChangeNotifier {
  final List<Recipe> _recipes = [
    Recipe(
      name: 'สลัดผักสด',
      ingredients: ['ผักสลัด', 'น้ำสลัด'],
      instructions: 'ล้างผัก คลุกกับน้ำสลัด',
      nutrition: 'พลังงาน 150 kcal',
    ),
    Recipe(
      name: 'ข้าวผัดไข่',
      ingredients: ['ข้าวสวย', 'ไข่ไก่', 'น้ำมันพืช', 'ซอสปรุงรส'],
      instructions: 'ตั้งกระทะ ใส่น้ำมัน ใส่ไข่และข้าว ผัดให้เข้ากัน ปรุงรส',
      nutrition: 'พลังงาน 420 kcal โปรตีน 14 g',
    ),
    Recipe(
      name: 'สปาเกตตีผัดพริกแห้ง',
      ingredients: ['เส้นสปาเกตตี', 'กระเทียม', 'พริกแห้ง', 'น้ำมันมะกอก'],
      instructions:
          'ต้มเส้นสปาเกตตี ผัดกระเทียมและพริกแห้ง ใส่เส้น คลุกให้เข้ากัน',
      nutrition: 'พลังงาน 350 kcal คาร์โบไฮเดรต 55 g',
    ),
    Recipe(
      name: 'ไก่อบสมุนไพร',
      ingredients: ['อกไก่', 'โรสแมรี', 'เกลือ', 'พริกไทย', 'น้ำมันมะกอก'],
      instructions: 'หมักไก่กับเครื่องปรุง อบไฟ 180°C ประมาณ 25 นาที',
      nutrition: 'พลังงาน 280 kcal โปรตีน 30 g',
    ),
    Recipe(
      name: 'ต้มจืดเต้าหู้หมูสับ',
      ingredients: ['หมูสับ', 'เต้าหู้ไข่', 'น้ำซุป', 'ต้นหอม'],
      instructions: 'ต้มหมูสับในน้ำซุป ใส่เต้าหู้ ปรุงรส โรยต้นหอม',
      nutrition: 'พลังงาน 200 kcal โปรตีน 18 g',
    ),
    Recipe(
      name: 'ผัดกะเพราไก่',
      ingredients: ['เนื้อไก่', 'ใบกะเพรา', 'พริก', 'กระเทียม', 'ซอสปรุงรส'],
      instructions: 'ผัดพริกกับกระเทียม ใส่ไก่ ปรุงรส ใส่ใบกะเพราก่อนยกลง',
      nutrition: 'พลังงาน 320 kcal โปรตีน 25 g',
    ),
  ];

  List<Recipe> get recipes => _recipes;

  Recipe getRandomRecipe() {
    _recipes.shuffle();
    return _recipes.first;
  }
}
