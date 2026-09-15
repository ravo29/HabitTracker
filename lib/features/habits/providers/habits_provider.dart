import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/models/habit_model.dart';

final habitsProvider =
    StateNotifierProvider<HabitsNotifier, List<Habit>>((ref) {
  return HabitsNotifier();
});

class HabitsNotifier extends StateNotifier<List<Habit>> {
  HabitsNotifier() : super(const []) {
    _loadHabits();
  }

  final _client = Supabase.instance.client;

  String? get _userId => _client.auth.currentUser?.id;

  Future<void> _loadHabits() async {
    final userId = _userId;
    if (userId == null) return;

    final rows = await _client
        .from('habits')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    state = rows.map((row) => Habit.fromSupabase(row)).toList();
  }

  Future<void> addHabit({
    required String title,
    required String description,
    required HabitFrequency frequency,
  }) async {
    final userId = _requireUser();
    final row = await _client
        .from('habits')
        .insert(
          Habit(
            id: '',
            title: title,
            description: description,
            frequency: frequency,
            createdAt: DateTime.now(),
          ).toSupabaseJson(userId),
        )
        .select()
        .single();
    state = [Habit.fromSupabase(row), ...state];
  }

  Future<void> updateHabit(Habit habit) async {
    _requireUser();
    final row = await _client
        .from('habits')
        .update({
          'title': habit.title,
          'description': habit.description,
          'frequency': habit.frequency.name,
          'completed_dates': habit.completedDates,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', habit.id)
        .select()
        .single();
    state = [
      for (final currentHabit in state)
        if (currentHabit.id == habit.id)
          Habit.fromSupabase(row)
        else
          currentHabit,
    ];
  }

  Future<void> deleteHabit(String id) async {
    _requireUser();
    await _client.from('habits').delete().eq('id', id);
    state = state.where((habit) => habit.id != id).toList();
  }

  Future<void> toggleHabit(String id, DateTime date) async {
    final habit = findById(id);
    if (habit == null) return;
    await updateHabit(habit.toggleCompletedOn(date));
  }

  Habit? findById(String? id) {
    for (final habit in state) {
      if (habit.id == id) return habit;
    }
    return null;
  }

  String _requireUser() {
    final userId = _userId;
    if (userId == null) {
      throw const AuthException(
        'Vous devez être connecté pour gérer vos habitudes.',
      );
    }
    return userId;
  }
}
