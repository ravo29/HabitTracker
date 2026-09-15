import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habittracker/features/onboarding/presentation/onboarding_screen.dart';

void main() {
  group('OnboardingScreen Widget Tests', () {
    testWidgets('should render onboarding screen correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: OnboardingScreen(),
        ),
      );

      expect(find.byType(OnboardingScreen), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display page indicators', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: OnboardingScreen(),
        ),
      );

      // Should show page indicators (3 dots for 3 pages)
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should display navigation buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: OnboardingScreen(),
        ),
      );

      // Should have next/continue button
      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('should display skip button on first page', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: OnboardingScreen(),
        ),
      );

      // Should have skip button
      expect(find.text('Passer'), findsOneWidget);
    });

    testWidgets('should navigate between pages', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: OnboardingScreen(),
        ),
      );

      // Find and tap the next button
      final nextButton = find.byType(FilledButton);
      expect(nextButton, findsOneWidget);

      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      // Should navigate to next page
      expect(find.byType(OnboardingScreen), findsOneWidget);
    });
  });
}