import 'package:equatable/equatable.dart';
import '../../models/recipe.dart';

class RecipeState extends Equatable {
  final List<Recipe> recipes;
  final Set<String> favoriteIds;
  final String searchQuery;

  const RecipeState({
    this.recipes = const [],
    this.favoriteIds = const {},
    this.searchQuery = '',
  });

  List<Recipe> get filteredRecipes {
    if (searchQuery.isEmpty) return recipes;
    return recipes
        .where(
            (r) => r.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  List<Recipe> get favoritedRecipes {
    return recipes.where((r) => favoriteIds.contains(r.id)).toList();
  }

  RecipeState copyWith({
    List<Recipe>? recipes,
    Set<String>? favoriteIds,
    String? searchQuery,
  }) {
    return RecipeState(
      recipes: recipes ?? this.recipes,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [recipes, favoriteIds, searchQuery];
}
