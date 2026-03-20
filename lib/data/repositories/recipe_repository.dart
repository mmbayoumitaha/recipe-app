import 'package:hive_flutter/hive_flutter.dart';
import '../../models/recipe.dart';

class RecipeRepository {
  final Box<Recipe> _recipeBox = Hive.box<Recipe>('recipes');
  final Box _favoriteBox = Hive.box('favorites');

  List<Recipe> getStoredRecipes() {
    return _recipeBox.values.toList();
  }

  Future<void> saveRecipe(Recipe recipe) async {
    await _recipeBox.put(recipe.id, recipe);
  }

  Future<void> deleteRecipe(String id) async {
    await _recipeBox.delete(id);
  }

  Set<String> getFavorites(String userEmail) {
    if (userEmail.isEmpty) return {};
    final List favorites = _favoriteBox.get(userEmail, defaultValue: []);
    return Set<String>.from(favorites);
  }

  Future<void> saveFavorites(String userEmail, Set<String> favorites) async {
    await _favoriteBox.put(userEmail, favorites.toList());
  }
}
