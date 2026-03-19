import 'package:flutter/material.dart';
import '../../models/recipe.dart';

class RecipeDetailInfo extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailInfo({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBadges(scheme),
        const SizedBox(height: 16),
        _buildTags(scheme),
        const SizedBox(height: 24),
        _buildIngredients(scheme),
        const SizedBox(height: 24),
        _buildInstructions(scheme),
      ],
    );
  }

  Widget _buildBadges(ColorScheme scheme) {
    return Row(
      children: [
        _Badge(
          icon: Icons.category_outlined,
          label: recipe.category,
          color: scheme.primary,
        ),
        const SizedBox(width: 12),
        _Badge(
          icon: Icons.timer_outlined,
          label: '${recipe.prepTimeMinutes} min',
          color: scheme.secondary,
        ),
      ],
    );
  }

  Widget _buildTags(ColorScheme scheme) {
    if (recipe.tags.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: recipe.tags.map((tag) {
        return Chip(
          label: Text(tag, style: const TextStyle(fontSize: 12)),
          backgroundColor: scheme.primary.withAlpha(20),
          side: BorderSide(color: scheme.primary.withAlpha(56)),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      }).toList(),
    );
  }

  Widget _buildIngredients(ColorScheme scheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '📝 Ingredients',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...recipe.ingredients.map((item) => _IngredientItem(text: item)),
      ],
    );
  }

  Widget _buildInstructions(ColorScheme scheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '👩‍🍳 Instructions',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(
            recipe.instructions,
            style: const TextStyle(fontSize: 15, height: 1.6),
          ),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _Badge({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _IngredientItem extends StatelessWidget {
  final String text;

  const _IngredientItem({required this.text});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 8, height: 8,
            decoration: BoxDecoration(color: scheme.primary, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15, height: 1.4))),
        ],
      ),
    );
  }
}
