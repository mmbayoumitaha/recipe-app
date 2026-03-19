import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/login/login_cubit.dart';
import '../cubit/recipe/recipe_cubit.dart';
import '../cubit/recipe/recipe_state.dart';
import '../models/recipe.dart';
import '../widgets/home/home_search_bar.dart';
import '../widgets/home/categories_section.dart';
import '../widgets/home/recipes_section.dart';
import 'add_edit_recipe_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    await context.read<LoginCubit>().logout();
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  Future<void> _navigateToAddRecipe(BuildContext context) async {
    final newRecipe = await Navigator.push<Recipe>(
      context,
      MaterialPageRoute(builder: (_) => const AddEditRecipeScreen()),
    );
    if (newRecipe != null && context.mounted) {
      context.read<RecipeCubit>().addRecipe(newRecipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          '🍳 CookCraft',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _handleLogout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<RecipeCubit, RecipeState>(
        builder: (context, state) {
          final isSearching = state.searchQuery.isNotEmpty;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeSearchBar(),
                if (!isSearching) const CategoriesSection(),
                RecipesSection(
                  recipes: state.filteredRecipes,
                  isSearching: isSearching,
                ),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToAddRecipe(context),
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        icon: const Icon(Icons.add),
        label: const Text('Add Recipe'),
      ),
    );
  }
}
