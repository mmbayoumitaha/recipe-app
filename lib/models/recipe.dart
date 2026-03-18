import 'package:hive/hive.dart';

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

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 0;

  @override
  Recipe read(BinaryReader reader) {
    final id = reader.readString();
    final name = reader.readString();
    final imageUrl = reader.readString();
    final category = reader.readString();
    final ingredients = (reader.readList()).cast<String>();
    final instructions = reader.readString();
    final tags = (reader.readList()).cast<String>();
    final prepTimeMinutes = reader.readInt();

    return Recipe(
      id: id,
      name: name,
      imageUrl: imageUrl,
      category: category,
      ingredients: ingredients,
      instructions: instructions,
      tags: tags,
      prepTimeMinutes: prepTimeMinutes,
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.imageUrl);
    writer.writeString(obj.category);
    writer.writeList(obj.ingredients);
    writer.writeString(obj.instructions);
    writer.writeList(obj.tags);
    writer.writeInt(obj.prepTimeMinutes);
  }
}
