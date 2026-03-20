import 'package:flutter/material.dart';
import '../../models/recipe_category.dart';

const List<RecipeCategory> globalAppCategories = [
  RecipeCategory(name: 'Breakfast', emoji: '🍳', color: Color(0xFFFF9E80)),
  RecipeCategory(name: 'Lunch', emoji: '🥗', color: Color(0xFF81C784)),
  RecipeCategory(name: 'Dinner', emoji: '🍝', color: Color(0xFFFF8A65)),
  RecipeCategory(name: 'Dessert', emoji: '🍰', color: Color(0xFFF06292)),
  RecipeCategory(name: 'Drinks', emoji: '🍹', color: Color(0xFF4FC3F7)),
  RecipeCategory(name: 'Snacks', emoji: '🥨', color: Color(0xFFBA68C8)),
];
