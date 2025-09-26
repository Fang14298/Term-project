class UserRecipe {
  final int? id;
  final String name;
  final String ingredients;   // เก็บเป็นข้อความยาว (คั่นบรรทัด)
  final String instructions;
  final String? nutrition;

  UserRecipe({
    this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    this.nutrition,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'instructions': instructions,
      'nutrition': nutrition,
    };
  }

  factory UserRecipe.fromMap(Map<String, dynamic> map) {
    return UserRecipe(
      id: map['id'],
      name: map['name'],
      ingredients: map['ingredients'],
      instructions: map['instructions'],
      nutrition: map['nutrition'],
    );
  }
}
