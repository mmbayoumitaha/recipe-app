import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/recipe_detail/recipe_image_sliver.dart';
import '../widgets/recipe_detail/recipe_detail_info.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onEdit;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          RecipeImageSliver(recipe: recipe, onEdit: onEdit),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: RecipeDetailInfo(recipe: recipe),
            ),
          ),
        ],
      ),
    );
  }
}
