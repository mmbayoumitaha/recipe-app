import 'package:flutter/material.dart';
import '../../models/recipe.dart';

class RecipeImageSliver extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onEdit;

  const RecipeImageSliver({
    super.key,
    required this.recipe,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: scheme.primary,
      foregroundColor: scheme.onPrimary,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          recipe.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.black54, blurRadius: 10)],
          ),
        ),
        background: Hero(
          tag: 'recipe-image-${recipe.id}',
          child: Image.network(
            recipe.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: scheme.primary.withAlpha(30),
                child: const Center(
                  child: Icon(
                    Icons.restaurant,
                    size: 80,
                    color: Colors.orange,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: onEdit,
          icon: const Icon(Icons.edit),
          tooltip: 'Edit Recipe',
        ),
      ],
    );
  }
}
