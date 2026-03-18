import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/recipe/recipe_cubit.dart';
import '../cubit/recipe/recipe_state.dart';
import '../data/dummy_data.dart';
import '../models/recipe.dart';
import '../widgets/category_card.dart';
import '../widgets/recipe_card.dart';
import 'category_recipes_screen.dart';
import 'recipe_detail_screen.dart';
import 'add_edit_recipe_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

  Future<void> _addRecipe(BuildContext context) async {
    final newRecipe = await Navigator.push<Recipe>(
      context,
      MaterialPageRoute(builder: (_) => const AddEditRecipeScreen()),
    );
    if (newRecipe != null && context.mounted) {
      context.read<RecipeCubit>().addRecipe(newRecipe);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          '🍳 Recipe App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange.shade600,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<RecipeCubit, RecipeState>(
        builder: (context, state) {
          final filteredRecipes = state.filteredRecipes;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.orange.shade600,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: TextField(
                    onChanged: (value) {
                      context.read<RecipeCubit>().updateSearchQuery(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search recipes...',
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),
                if (state.searchQuery.isEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6),
                          child: SizedBox(
                            width: 110,
                            child: CategoryCard(
                              category: cat,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        BlocProvider.value(
                                      value: context
                                          .read<RecipeCubit>(),
                                      child:
                                          CategoryRecipesScreen(
                                        categoryName: cat.name,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(16, 20, 16, 10),
                  child: Text(
                    state.searchQuery.isEmpty
                        ? 'All Recipes'
                        : 'Search Results (${filteredRecipes.length})',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                if (filteredRecipes.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.search_off,
                              size: 60, color: Colors.grey),
                          SizedBox(height: 10),
                          Text(
                            'No recipes found',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredRecipes.length,
                    itemBuilder: (context, index) {
                      final recipe = filteredRecipes[index];
                      return RecipeCard(
                        recipe: recipe,
                        onDelete: () =>
                            _deleteRecipe(context, recipe.id),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RecipeDetailScreen(
                                recipe: recipe,
                                onEdit: () =>
                                    _editRecipe(context, recipe),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addRecipe(context),
        backgroundColor: Colors.orange.shade600,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Recipe'),
      ),
    );
  }
}
