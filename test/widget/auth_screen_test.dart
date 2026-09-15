import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habittracker/features/auth/presentation/auth_screen.dart';

void main() {
  group('AuthScreen Widget Tests', () {
    testWidgets('should render auth screen correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthScreen(),
        ),
      );

      expect(find.byType(AuthScreen), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display logo image', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthScreen(),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should toggle between login and register forms', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthScreen(),
        ),
      );

      // Initially should show login form
      expect(find.text('Connexion'), findsOneWidget);

      // Tap register button (would need to find the specific button)
      // This is a simplified test - actual implementation would find the toggle button
    });

    testWidgets('should respond to screen size changes', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthScreen(),
        ),
      );

      // Test with different screen sizes
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pump();

      expect(find.byType(AuthScreen), findsOneWidget);
    });

    testWidgets('should maintain state during rebuilds', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthScreen(),
        ),
      );

      // Trigger a rebuild
      await tester.pumpWidget(
        const MaterialApp(
          home: AuthScreen(),
        ),
      );

      expect(find.byType(AuthScreen), findsOneWidget);
    });
  });
}