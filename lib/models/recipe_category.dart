import 'package:flutter/material.dart';

class RecipeCategory {
  final String name;
  final String emoji;
  final Color color;

  const RecipeCategory({
    required this.name,
    required this.emoji,
    this.color = Colors.orange,
  });
}
