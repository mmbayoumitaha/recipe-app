import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/recipe/recipe_cubit.dart';
import '../cubit/recipe/recipe_state.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';
import 'add_edit_recipe_screen.dart';

class CategoryRecipesScreen extends StatelessWidget {
  final String categoryName;

  const CategoryRecipesScreen({super.key, required this.categoryName});

  Future<void> _editRecipe(BuildContext context, Recipe recipe) async {
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

  void _deleteRecipe(BuildContext context, String id) {
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          categoryName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
      ),
      body: BlocBuilder<RecipeCubit, RecipeState>(
        builder: (context, state) {
          final recipes = state.recipes
              .where((r) => r.category == categoryName)
              .toList();

          if (recipes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.restaurant,
                    size: 80,
                    color: scheme.onSurface.withValues(alpha: 0.2),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No recipes in $categoryName yet',
                    style: TextStyle(
                      fontSize: 16,
                      color: scheme.onSurface.withValues(alpha: 0.65),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add one from the home screen!',
                    style: TextStyle(
                      fontSize: 14,
                      color: scheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return RecipeCard(
                recipe: recipe,
                onDelete: () => _deleteRecipe(context, recipe.id),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RecipeDetailScreen(
                        recipe: recipe,
                        onEdit: () => _editRecipe(context, recipe),
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
