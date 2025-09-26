class Ingredient {
  final int? id;
  final String name;
  final String expireDate;
  final String? note;

  Ingredient({
    this.id,
    required this.name,
    required this.expireDate,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'expireDate': expireDate, 'note': note};
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'],
      name: map['name'],
      expireDate: map['expireDate'],
      note: map['note'],
    );
  }
}
