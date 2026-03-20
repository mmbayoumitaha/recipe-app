import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/data/repositories/auth_repository.dart';
import 'package:recipe_app/data/repositories/recipe_repository.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final authRepo = AuthRepository();
    final recipeRepo = RecipeRepository();

    await tester.pumpWidget(RecipeApp(
      startScreen: const Scaffold(),
      authRepository: authRepo,
      recipeRepository: recipeRepo,
    ));

    expect(find.text('CookCraft'), findsOneWidget);
  });
}
