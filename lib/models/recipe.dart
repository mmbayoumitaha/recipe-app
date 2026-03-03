class Recipe {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final List<String> ingredients;
  final String instructions;
  final List<String> tags;
  final int prepTimeMinutes;

  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.ingredients,
    required this.instructions,
    this.tags = const [],
    this.prepTimeMinutes = 30,
  });

  Recipe copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? category,
    List<String>? ingredients,
    String? instructions,
    List<String>? tags,
    int? prepTimeMinutes,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      tags: tags ?? this.tags,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
    );
  }
}
