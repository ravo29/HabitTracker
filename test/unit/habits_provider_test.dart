import 'package:flutter_test/flutter_test.dart';
import 'package:habittracker/features/habits/providers/habits_provider.dart';

void main() {
  group('Habit', () {
    test('should create Habit with required parameters', () {
      final habit = Habit(
        id: '1',
        title: 'Exercise',
        description: 'Daily workout',
        targetDays: 7,
        currentStreak: 3,
        completionRate: 0.75,
      );

      expect(habit.id, '1');
      expect(habit.title, 'Exercise');
      expect(habit.description, 'Daily workout');
      expect(habit.targetDays, 7);
      expect(habit.currentStreak, 3);
      expect(habit.completionRate, 0.75);
    });

    test('should handle optional parameters', () {
      final habit = Habit(
        id: '2',
        title: 'Reading',
        targetDays: 30,
        currentStreak: 5,
        completionRate: 0.5,
      );

      expect(habit.id, '2');
      expect(habit.title, 'Reading');
      expect(habit.description, null);
      expect(habit.targetDays, 30);
      expect(habit.currentStreak, 5);
      expect(habit.completionRate, 0.5);
    });

    test('should calculate isCompleted correctly', () {
      final completedHabit = Habit(
        id: '1',
        title: 'Exercise',
        targetDays: 7,
        currentStreak: 7,
        completionRate: 1.0,
      );

      final incompleteHabit = Habit(
        id: '2',
        title: 'Reading',
        targetDays: 30,
        currentStreak: 5,
        completionRate: 0.5,
      );

      expect(completedHabit.completionRate, 1.0);
      expect(incompleteHabit.completionRate, 0.5);
    });
  });

  group('HabitsNotifier', () {
    late HabitsNotifier habitsNotifier;

    setUp(() {
      habitsNotifier = HabitsNotifier();
    });

    tearDown(() {
      habitsNotifier.dispose();
    });

    test('should initialize with empty habits list', () {
      expect(habitsNotifier.state.habits, isEmpty);
    });

    test('should add habit to state', () {
      final habit = Habit(
        id: '1',
        title: 'Exercise',
        targetDays: 7,
        currentStreak: 0,
        completionRate: 0.0,
      );

      habitsNotifier.addHabit(habit);
      expect(habitsNotifier.state.habits.length, 1);
      expect(habitsNotifier.state.habits.first.title, 'Exercise');
    });

    test('should remove habit from state', () {
      final habit = Habit(
        id: '1',
        title: 'Exercise',
        targetDays: 7,
        currentStreak: 0,
        completionRate: 0.0,
      );

      habitsNotifier.addHabit(habit);
      expect(habitsNotifier.state.habits.length, 1);

      habitsNotifier.removeHabit('1');
      expect(habitsNotifier.state.habits.length, 0);
    });

    test('should update habit in state', () {
      final habit = Habit(
        id: '1',
        title: 'Exercise',
        targetDays: 7,
        currentStreak: 0,
        completionRate: 0.0,
      );

      habitsNotifier.addHabit(habit);
      expect(habitsNotifier.state.habits.first.currentStreak, 0);

      final updatedHabit = Habit(
        id: '1',
        title: 'Exercise',
        targetDays: 7,
        currentStreak: 1,
        completionRate: 0.14,
      );

      habitsNotifier.updateHabit(updatedHabit);
      expect(habitsNotifier.state.habits.first.currentStreak, 1);
    });
  });
}