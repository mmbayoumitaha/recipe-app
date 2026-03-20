import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onFavorite;
  final String? heroSuffix;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.isFavorite,
    required this.onTap,
    this.onDelete,
    this.onFavorite,
    this.heroSuffix,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _RecipeImageOverlay(
              recipe: recipe,
              isFavorite: isFavorite,
              onDelete: onDelete,
              onFavorite: onFavorite,
              heroSuffix: heroSuffix,
            ),
            _RecipeInfoSection(recipe: recipe),
          ],
        ),
      ),
    );
  }
}

class _RecipeImageOverlay extends StatelessWidget {
  final Recipe recipe;
  final bool isFavorite;
  final VoidCallback? onDelete;
  final VoidCallback? onFavorite;
  final String? heroSuffix;

  const _RecipeImageOverlay({
    required this.recipe,
    required this.isFavorite,
    this.onDelete,
    this.onFavorite,
    this.heroSuffix,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Hero(
          tag: 'recipe-image-${recipe.id}${heroSuffix ?? ""}',
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Image.network(
              recipe.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildFallbackImage(scheme),
            ),
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: Row(
            children: [
              _Badge(icon: Icons.timer_outlined, label: '${recipe.prepTimeMinutes}m'),
              if (onFavorite != null) ...[
                const SizedBox(width: 8),
                _FavoriteButton(isFavorite: isFavorite, onFavorite: onFavorite!),
              ],
            ],
          ),
        ),
        if (onDelete != null)
          Positioned(
            top: 12,
            left: 12,
            child: _ActionCircle(
              onTap: onDelete!,
              icon: Icons.delete_outline_rounded,
              color: Colors.red,
            ),
          ),
      ],
    );
  }

  Widget _buildFallbackImage(ColorScheme scheme) {
    return Container(
      height: 200,
      width: double.infinity,
      color: scheme.surfaceContainerHighest,
      child: Center(
        child: Icon(Icons.restaurant_rounded, size: 50, color: scheme.primary.withValues(alpha: 0.2)),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onFavorite;

  const _FavoriteButton({required this.isFavorite, required this.onFavorite});

  @override
  Widget build(BuildContext context) {
    return _ActionCircle(
      onTap: onFavorite,
      icon: isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
      color: isFavorite ? Colors.red : Colors.grey,
      isSolid: true,
    );
  }
}

class _ActionCircle extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color color;
  final bool isSolid;

  const _ActionCircle({
    required this.onTap,
    required this.icon,
    required this.color,
    this.isSolid = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}

class _RecipeInfoSection extends StatelessWidget {
  final Recipe recipe;

  const _RecipeInfoSection({required this.recipe});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(recipe.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: scheme.onSurface)),
          const SizedBox(height: 4),
          Text(recipe.category, style: TextStyle(fontSize: 13, color: scheme.onSurface.withValues(alpha: 0.5))),
          const SizedBox(height: 12),
          if (recipe.tags.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: recipe.tags.map((tag) => _TagChip(tag: tag, scheme: scheme)).toList(),
            ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Badge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String tag;
  final ColorScheme scheme;

  const _TagChip({required this.tag, required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.2)),
      ),
      child: Text(tag, style: TextStyle(fontSize: 10, color: scheme.primary, fontWeight: FontWeight.bold)),
    );
  }
}
