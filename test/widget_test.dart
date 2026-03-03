import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_app/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const RecipeApp());

    // Verify that the login screen is displayed
    expect(find.text('Recipe App'), findsOneWidget);
  });
}
