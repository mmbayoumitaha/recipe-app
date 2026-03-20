import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/recipe/recipe_cubit.dart';
import '../../cubit/recipe/recipe_state.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeCubit, RecipeState>(
      builder: (context, state) {
        if (recipes.isEmpty) return _buildEmptyState();

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) return _buildSectionHeader();
                
                final recipe = recipes[index - 1];
                final heroTag = 'recipe-image-${recipe.id}-home';
                
                return RecipeCard(
                  recipe: recipe,
                  isFavorite: state.favoriteIds.contains(recipe.id),
                  onDelete: () => _confirmDeletion(context, recipe.id),
                  onFavorite: () => context.read<RecipeCubit>().toggleFavorite(recipe.id),
                  onTap: () => _navigateToDetail(context, recipe, heroTag),
                  heroSuffix: '-home',
                );
              },
              childCount: recipes.length + 1,
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 60),
              Icon(Icons.search_off_rounded, size: 70, color: Colors.grey),
              SizedBox(height: 12),
              Text('No recipes found', style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Text(
        isSearching ? 'Search Results (${recipes.length})' : 'All Recipes',
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _confirmDeletion(BuildContext context, String recipeId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Recipe'),
        content: const Text('Are you sure you want to delete this recipe?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              context.read<RecipeCubit>().deleteRecipe(recipeId);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToDetail(BuildContext context, Recipe recipe, String heroTag) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeDetailScreen(
          recipe: recipe,
          onEdit: () => _navigateToEdit(context, recipe),
          heroTag: heroTag,
        ),
      ),
    );
  }

  Future<void> _navigateToEdit(BuildContext context, Recipe recipe) async {
    final updatedRecipe = await Navigator.push<Recipe>(
      context,
      MaterialPageRoute(builder: (_) => AddEditRecipeScreen(existingRecipe: recipe)),
    );
    
    if (updatedRecipe != null && context.mounted) {
      context.read<RecipeCubit>().updateRecipe(updatedRecipe);
    }
  }
}
