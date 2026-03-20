import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/repositories/recipe_repository.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/dummy_data.dart';
import '../../models/recipe.dart';
import 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final RecipeRepository _recipeRepository;
  final AuthRepository _authRepository;

  RecipeCubit({
    required RecipeRepository recipeRepository,
    required AuthRepository authRepository,
  })  : _recipeRepository = recipeRepository,
        _authRepository = authRepository,
        super(const RecipeState()) {
    loadUserContent();
  }

  String? get currentUserEmail => _authRepository.getCurrentUserEmail();

  Future<void> loadUserContent() async {
    final userEmail = _authRepository.getCurrentUserEmail();
    if (userEmail == null) {
      emit(const RecipeState());
      return;
    }

    final String populationFlagKey = 'user_${userEmail}_populated';
    final Box settingsBox = Hive.box('settings');
    final bool hasBeenPopulated = settingsBox.get(populationFlagKey, defaultValue: false);

    List<Recipe> recipes = _recipeRepository.getStoredRecipes()
        .where((recipe) => recipe.creatorEmail == userEmail)
        .toList();

    if (!hasBeenPopulated && recipes.isEmpty) {
      recipes = await _initializeNewUserWorkspace(userEmail, settingsBox, populationFlagKey);
    }

    emit(state.copyWith(
      recipes: recipes,
      favoriteIds: _recipeRepository.getFavorites(userEmail),
    ));
  }

  Future<List<Recipe>> _initializeNewUserWorkspace(
    String userEmail, 
    Box settingsBox, 
    String flagKey,
  ) async {
    final List<Recipe> initialRecipes = [];
    for (final sample in sampleRecipes) {
      final perUserSample = sample.copyWith(
        id: '${userEmail}_${sample.id}',
        creatorEmail: userEmail,
      );
      await _recipeRepository.saveRecipe(perUserSample);
      initialRecipes.add(perUserSample);
    }
    await settingsBox.put(flagKey, true);
    return initialRecipes;
  }

  Future<void> refresh() => loadUserContent();

  Future<void> addRecipe(Recipe recipe) async {
    final userEmail = currentUserEmail;
    if (userEmail == null) return;
    
    final Recipe recipeWithEmail = recipe.copyWith(creatorEmail: userEmail);
    await _recipeRepository.saveRecipe(recipeWithEmail);
    await loadUserContent();
  }

  Future<void> updateRecipe(Recipe recipe) async {
    await _recipeRepository.saveRecipe(recipe);
    await loadUserContent();
  }

  Future<void> deleteRecipe(String recipeId) async {
    await _recipeRepository.deleteRecipe(recipeId);
    await loadUserContent();
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  Future<void> toggleFavorite(String recipeId) async {
    final userEmail = currentUserEmail;
    if (userEmail == null) return;

    final Set<String> updatedFavorites = Set<String>.from(state.favoriteIds);
    final bool isAlreadyFavorite = updatedFavorites.contains(recipeId);

    if (isAlreadyFavorite) {
      updatedFavorites.remove(recipeId);
    } else {
      updatedFavorites.add(recipeId);
    }

    await _recipeRepository.saveFavorites(userEmail, updatedFavorites);
    emit(state.copyWith(favoriteIds: updatedFavorites));
  }
}
