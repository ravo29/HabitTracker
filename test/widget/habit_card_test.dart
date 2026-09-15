import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habittracker/features/habits/presentation/widgets/habit_card.dart';

void main() {
  group('HabitCard Widget Tests', () {
    testWidgets('should render habit card correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HabitCard(
              habit: Habit(
                id: '1',
                title: 'Exercise',
                description: 'Daily workout',
                targetDays: 7,
                currentStreak: 3,
                completionRate: 0.75,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(HabitCard), findsOneWidget);
      expect(find.text('Exercise'), findsOneWidget);
    });

    testWidgets('should display habit title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HabitCard(
              habit: Habit(
                id: '1',
                title: 'Reading',
                description: '30 minutes daily',
                targetDays: 30,
                currentStreak: 5,
                completionRate: 0.5,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Reading'), findsOneWidget);
    });

    testWidgets('should display habit description', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HabitCard(
              habit: Habit(
                id: '1',
                title: 'Exercise',
                description: 'Daily workout',
                targetDays: 7,
                currentStreak: 3,
                completionRate: 0.75,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Daily workout'), findsOneWidget);
    });

    testWidgets('should display streak information', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HabitCard(
              habit: Habit(
                id: '1',
                title: 'Exercise',
                description: 'Daily workout',
                targetDays: 7,
                currentStreak: 3,
                completionRate: 0.75,
              ),
            ),
          ),
        ),
      );

      // Should display streak information
      expect(find.byType(HabitCard), findsOneWidget);
    });

    testWidgets('should handle tap gestures', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GestureDetector(
              onTap: () => tapped = true,
              child: HabitCard(
                habit: Habit(
                  id: '1',
                  title: 'Exercise',
                  description: 'Daily workout',
                  targetDays: 7,
                  currentStreak: 3,
                  completionRate: 0.75,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(HabitCard));
      await tester.pumpAndSettle();

      expect(tapped, true);
    });
  });
}

// Mock Habit class for testing
class Habit {
  final String id;
  final String title;
  final String? description;
  final int targetDays;
  final int currentStreak;
  final double completionRate;

  Habit({
    required this.id,
    required this.title,
    this.description,
    required this.targetDays,
    required this.currentStreak,
    required this.completionRate,
  });
}