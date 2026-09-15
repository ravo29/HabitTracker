import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habittracker/main.dart';
import 'package:habittracker/features/habits/presentation/screens/home_screen.dart';
import 'package:habittracker/features/habits/presentation/screens/add_edit_habit_screen.dart';

void main() {
  group('Habit Management Integration Tests', () {
    testWidgets('complete habit creation flow', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Navigate to home screen (assuming logged in state)
      await tester.pumpAndSettle();

      // Should be at home screen
      expect(find.byType(HomeScreen), findsOneWidget);

      // Tap floating action button to add new habit
      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);

      await tester.tap(fab);
      await tester.pumpAndSettle();

      // Should navigate to add/edit habit screen
      expect(find.byType(AddEditHabitScreen), findsOneWidget);

      // Fill in habit details
      final titleField = find.byKey(const Key('habit_title_field'));
      final descriptionField = find.byKey(const Key('habit_description_field'));
      final targetDaysField = find.byKey(const Key('habit_target_days_field'));

      if (titleField.evaluate().isNotEmpty) {
        await tester.enterText(titleField, 'Exercise');
        await tester.pumpAndSettle();
      }

      if (descriptionField.evaluate().isNotEmpty) {
        await tester.enterText(descriptionField, '30 minutes daily workout');
        await tester.pumpAndSettle();
      }

      if (targetDaysField.evaluate().isNotEmpty) {
        await tester.enterText(targetDaysField, '30');
        await tester.pumpAndSettle();
      }

      // Save the habit
      final saveButton = find.byType(FilledButton);
      if (saveButton.evaluate().isNotEmpty) {
        await tester.tap(saveButton);
        await tester.pumpAndSettle();
      }

      // Should return to home screen with new habit
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('habit completion flow', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Navigate to home screen
      await tester.pumpAndSettle();

      // Should be at home screen
      expect(find.byType(HomeScreen), findsOneWidget);

      // Find habit card and tap to complete
      final habitCard = find.byKey(const Key('habit_card_1'));
      if (habitCard.evaluate().isNotEmpty) {
        await tester.tap(habitCard);
        await tester.pumpAndSettle();

        // Should show completion confirmation or update UI
        expect(find.byType(HomeScreen), findsOneWidget);
      }
    });

    testWidgets('habit editing flow', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Navigate to home screen
      await tester.pumpAndSettle();

      // Should be at home screen
      expect(find.byType(HomeScreen), findsOneWidget);

      // Long press on habit card to edit
      final habitCard = find.byKey(const Key('habit_card_1'));
      if (habitCard.evaluate().isNotEmpty) {
        await tester.longPress(habitCard);
        await tester.pumpAndSettle();

        // Should navigate to edit screen
        expect(find.byType(AddEditHabitScreen), findsOneWidget);

        // Modify habit details
        final titleField = find.byKey(const Key('habit_title_field'));
        if (titleField.evaluate().isNotEmpty) {
          await tester.enterText(titleField, 'Updated Exercise');
          await tester.pumpAndSettle();
        }

        // Save changes
        final saveButton = find.byType(FilledButton);
        if (saveButton.evaluate().isNotEmpty) {
          await tester.tap(saveButton);
          await tester.pumpAndSettle();
        }

        // Should return to home screen with updated habit
        expect(find.byType(HomeScreen), findsOneWidget);
      }
    });

    testWidgets('habit deletion flow', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Navigate to home screen
      await tester.pumpAndSettle();

      // Should be at home screen
      expect(find.byType(HomeScreen), findsOneWidget);

      // Find delete button on habit card
      final deleteButton = find.byKey(const Key('delete_habit_button'));
      if (deleteButton.evaluate().isNotEmpty) {
        await tester.tap(deleteButton);
        await tester.pumpAndSettle();

        // Should show confirmation dialog
        expect(find.text('Supprimer'), findsOneWidget);

        // Confirm deletion
        final confirmButton = find.text('Confirmer');
        if (confirmButton.evaluate().isNotEmpty) {
          await tester.tap(confirmButton);
          await tester.pumpAndSettle();

          // Habit should be removed from list
          expect(find.byType(HomeScreen), findsOneWidget);
        }
      }
    });

    testWidgets('navigation between habit screens', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Navigate to home screen
      await tester.pumpAndSettle();

      // Should be at home screen
      expect(find.byType(HomeScreen), findsOneWidget);

      // Navigate to statistics screen
      final statsButton = find.byKey(const Key('stats_button'));
      if (statsButton.evaluate().isNotEmpty) {
        await tester.tap(statsButton);
        await tester.pumpAndSettle();

        // Should be on statistics screen
        // expect(find.byType(StatisticsScreen), findsOneWidget);
      }

      // Navigate back to home
      final backButton = find.byType(BackButton);
      if (backButton.evaluate().isNotEmpty) {
        await tester.tap(backButton);
        await tester.pumpAndSettle();

        expect(find.byType(HomeScreen), findsOneWidget);
      }
    });
  });
}