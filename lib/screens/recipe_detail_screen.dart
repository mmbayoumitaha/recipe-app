import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/recipe.dart';
import '../cubit/recipe/recipe_cubit.dart';
import '../cubit/recipe/recipe_state.dart';
import '../widgets/recipe_detail/recipe_image_sliver.dart';
import '../widgets/recipe_detail/recipe_detail_info.dart';
import 'add_edit_recipe_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;
  final String heroTag;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
    required this.heroTag,
  });

  Future<void> _handleEdit(BuildContext context, Recipe currentRecipe) async {
    final updatedRecipe = await Navigator.push<Recipe>(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditRecipeScreen(existingRecipe: currentRecipe),
      ),
    );

    if (updatedRecipe != null && context.mounted) {
      context.read<RecipeCubit>().updateRecipe(updatedRecipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeCubit, RecipeState>(
      builder: (context, state) {
        // Find the latest version of this recipe in the state
        final currentRecipe = state.recipes.firstWhere(
          (r) => r.id == recipe.id,
          orElse: () => recipe,
        );

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              RecipeImageSliver(
                recipe: currentRecipe,
                onEdit: () => _handleEdit(context, currentRecipe),
                heroTag: heroTag,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: RecipeDetailInfo(recipe: currentRecipe),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
