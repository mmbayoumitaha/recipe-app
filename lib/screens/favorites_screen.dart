import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/recipe/recipe_cubit.dart';
import '../cubit/recipe/recipe_state.dart';
import '../models/recipe.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('My Favorites'),
        elevation: 0,
        backgroundColor: theme.brightness == Brightness.light ? scheme.primary : theme.scaffoldBackgroundColor,
        foregroundColor: theme.brightness == Brightness.light ? Colors.white : scheme.onSurface,
      ),
      body: BlocBuilder<RecipeCubit, RecipeState>(
        builder: (context, state) {
          final favoriteRecipes = state.favoritedRecipes;

          if (favoriteRecipes.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => context.read<RecipeCubit>().refresh(),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_rounded,
                          size: 80,
                          color: scheme.primary.withValues(alpha: 0.1),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No favorites yet',
                          style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        const Text('Save your favorite recipes here', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => context.read<RecipeCubit>().refresh(),
            color: scheme.primary,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoriteRecipes.length,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final recipe = favoriteRecipes[index];
                final heroTag = 'recipe-image-${recipe.id}-fav';
                
                return RecipeCard(
                  recipe: recipe,
                  isFavorite: true,
                  onFavorite: () => context.read<RecipeCubit>().toggleFavorite(recipe.id),
                  heroSuffix: '-fav',
                  onTap: () => _navigateToDetail(context, recipe, heroTag),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _navigateToDetail(BuildContext context, Recipe recipe, String heroTag) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeDetailScreen(
          recipe: recipe,
          heroTag: heroTag,
        ),
      ),
    );
  }
}
