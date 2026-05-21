class Recipe {
  final String id;
  final String name;
  final String category;
  final int preparationTimeMinutes;
  final String difficulty;
  final bool isVegetarian;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.preparationTimeMinutes,
    required this.difficulty,
    required this.isVegetarian,
  });

  Recipe copyWith({
    String? id,
    String? name,
    String? category,
    int? preparationTimeMinutes,
    String? difficulty,
    bool? isVegetarian,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      preparationTimeMinutes:
          preparationTimeMinutes ?? this.preparationTimeMinutes,
      difficulty: difficulty ?? this.difficulty,
      isVegetarian: isVegetarian ?? this.isVegetarian,
    );
  }
}
