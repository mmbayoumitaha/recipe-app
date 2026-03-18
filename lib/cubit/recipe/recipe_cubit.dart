import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../data/dummy_data.dart';
import '../../models/recipe.dart';
import 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit() : super(const RecipeState()) {
    _loadRecipes();
  }

  Box<Recipe> get _box => Hive.box<Recipe>('recipes');

  Future<void> _loadRecipes() async {
    if (_box.isEmpty) {
      for (final recipe in sampleRecipes) {
        await _box.put(recipe.id, recipe);
      }
    }
    emit(state.copyWith(recipes: _box.values.toList()));
  }

  void addRecipe(Recipe recipe) {
    _box.put(recipe.id, recipe);
    final updatedRecipes = List<Recipe>.from(state.recipes);
    final index = updatedRecipes.indexWhere((r) => r.id == recipe.id);
    if (index == -1) {
      updatedRecipes.add(recipe);
    } else {
      updatedRecipes[index] = recipe;
    }
    emit(state.copyWith(recipes: updatedRecipes));
  }

  void updateRecipe(Recipe recipe) {
    final updatedRecipes = List<Recipe>.from(state.recipes);
    final index = updatedRecipes.indexWhere((r) => r.id == recipe.id);
    if (index != -1) {
      _box.put(recipe.id, recipe);
      updatedRecipes[index] = recipe;
      emit(state.copyWith(recipes: updatedRecipes));
    }
  }

  void deleteRecipe(String id) {
    _box.delete(id);
    final updatedRecipes = List<Recipe>.from(state.recipes)
      ..removeWhere((r) => r.id == id);
    emit(state.copyWith(recipes: updatedRecipes));
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }
}
