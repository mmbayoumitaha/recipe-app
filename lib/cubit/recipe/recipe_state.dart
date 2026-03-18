import 'package:equatable/equatable.dart';
import '../../models/recipe.dart';

class RecipeState extends Equatable {
  final List<Recipe> recipes;
  final String searchQuery;

  const RecipeState({
    this.recipes = const [],
    this.searchQuery = '',
  });

  List<Recipe> get filteredRecipes {
    if (searchQuery.isEmpty) return recipes;
    return recipes
        .where(
            (r) => r.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  RecipeState copyWith({
    List<Recipe>? recipes,
    String? searchQuery,
  }) {
    return RecipeState(
      recipes: recipes ?? this.recipes,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [recipes, searchQuery];
}
