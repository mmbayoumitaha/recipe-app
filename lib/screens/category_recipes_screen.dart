import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/recipe/recipe_cubit.dart';
import '../cubit/recipe/recipe_state.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import '../widgets/common/empty_recipes_state.dart';
import 'recipe_detail_screen.dart';
import 'add_edit_recipe_screen.dart';

class CategoryRecipesScreen extends StatelessWidget {
  final String categoryName;

  const CategoryRecipesScreen({super.key, required this.categoryName});

  void _onEdit(BuildContext context, Recipe recipe) async {
    final updatedRecipe = await Navigator.push<Recipe>(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditRecipeScreen(existingRecipe: recipe),
      ),
    );
    if (updatedRecipe != null && context.mounted) {
      context.read<RecipeCubit>().updateRecipe(updatedRecipe);
    }
  }

  void _onDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Recipe'),
        content: const Text('Are you sure you want to delete this recipe?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<RecipeCubit>().deleteRecipe(id);
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),
      body: BlocBuilder<RecipeCubit, RecipeState>(
        builder: (context, state) {
          final recipes = state.recipes
              .where((r) => r.category == categoryName)
              .toList();

          if (recipes.isEmpty) {
            return EmptyRecipesState(
              title: 'No recipes in $categoryName yet',
              subtitle: 'Start adding your culinary creations!',
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              final heroTag = 'recipe-image-${recipe.id}-cat';
              return RecipeCard(
                recipe: recipe,
                isFavorite: state.favoriteIds.contains(recipe.id),
                onDelete: () => _onDelete(context, recipe.id),
                onFavorite: () => context.read<RecipeCubit>().toggleFavorite(recipe.id),
                heroSuffix: '-cat',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RecipeDetailScreen(
                        recipe: recipe,
                        onEdit: () => _onEdit(context, recipe),
                        heroTag: heroTag,
                      ),
                    ),
                  );
                },
              );
            },
          );

        },
      ),
    );
  }
}
