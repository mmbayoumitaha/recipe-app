import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/dummy_data.dart';
import '../../models/recipe.dart';
import 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit() : super(RecipeState(recipes: List.from(sampleRecipes)));

  void addRecipe(Recipe recipe) {
    final updatedRecipes = List<Recipe>.from(state.recipes)..add(recipe);
    emit(state.copyWith(recipes: updatedRecipes));
  }

  void updateRecipe(Recipe recipe) {
    final updatedRecipes = List<Recipe>.from(state.recipes);
    final index = updatedRecipes.indexWhere((r) => r.id == recipe.id);
    if (index != -1) {
      updatedRecipes[index] = recipe;
      emit(state.copyWith(recipes: updatedRecipes));
    }
  }

  void deleteRecipe(String id) {
    final updatedRecipes = List<Recipe>.from(state.recipes)
      ..removeWhere((r) => r.id == id);
    emit(state.copyWith(recipes: updatedRecipes));
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }
}
