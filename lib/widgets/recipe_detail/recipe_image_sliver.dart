import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/recipe.dart';

class RecipeImageSliver extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onEdit;
  final String heroTag;

  const RecipeImageSliver({
    super.key,
    required this.recipe,
    required this.onEdit,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return SliverAppBar(
      expandedHeight: 350,
      pinned: true,
      backgroundColor: scheme.primary,
      foregroundColor: Colors.white,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          recipe.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            shadows: [
              Shadow(
                color: Colors.black45,
                blurRadius: 12,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: heroTag,
              child: recipe.imageUrl.startsWith('http')
                  ? CachedNetworkImage(
                      imageUrl: recipe.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.black12,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => _buildFallback(context, scheme),
                    )
                  : Image.file(
                      File(recipe.imageUrl),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _buildFallback(context, scheme),
                    ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black26,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black87,
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        _buildActionIcon(
          onTap: onEdit,
          icon: Icons.edit_rounded,
          tooltip: 'Edit Recipe',
          scheme: scheme,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildFallback(BuildContext context, ColorScheme scheme) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Icon(Icons.restaurant_menu_rounded, size: 80, color: scheme.primary.withValues(alpha: 0.3)),
      ),
    );
  }

  Widget _buildActionIcon({
    required VoidCallback onTap,
    required IconData icon,
    required String tooltip,
    required ColorScheme scheme,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: const BoxDecoration(
        color: Colors.black26,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white, size: 20),
        tooltip: tooltip,
      ),
    );
  }
}
