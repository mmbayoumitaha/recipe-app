import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/recipe/recipe_cubit.dart';
import '../../models/recipe.dart';
import '../../screens/add_edit_recipe_screen.dart';
import '../../screens/recipe_detail_screen.dart';
import '../recipe_card.dart';

class RecipesSection extends StatelessWidget {
  final List<Recipe> recipes;
  final bool isSearching;

  const RecipesSection({
    super.key,
    required this.recipes,
    required this.isSearching,
  });

  void _confirmDeleteRecipe(BuildContext context, String id) {
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

  Future<void> _navigateToEditRecipe(BuildContext context, Recipe recipe) async {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
          child: Text(
            isSearching ? 'Search Results (${recipes.length})' : 'All Recipes',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        if (recipes.isEmpty)
          const Padding(
            padding: EdgeInsets.all(40),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.search_off, size: 60, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    'No recipes found',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return RecipeCard(
                recipe: recipe,
                onDelete: () => _confirmDeleteRecipe(context, recipe.id),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RecipeDetailScreen(
                        recipe: recipe,
                        onEdit: () => _navigateToEditRecipe(context, recipe),
                      ),
                    ),
                  );
                },
              );
            },
          ),
      ],
    );
  }
}
