enum HabitFrequency {
  daily,
  weekly,
}

class Habit {
  final String id;
  final String title;
  final String description;
  final HabitFrequency frequency;
  final DateTime createdAt;
  final List<String> completedDates;

  const Habit({
    required this.id,
    required this.title,
    this.description = '',
    this.frequency = HabitFrequency.daily,
    required this.createdAt,
    this.completedDates = const [],
  });

  bool isCompletedOn(DateTime date) {
    return completedDates.contains(_dateKey(date));
  }

  Habit toggleCompletedOn(DateTime date) {
    final key = _dateKey(date);
    final updatedDates = [...completedDates];
    if (updatedDates.contains(key)) {
      updatedDates.remove(key);
    } else {
      updatedDates.add(key);
    }
    return copyWith(completedDates: updatedDates);
  }

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    HabitFrequency? frequency,
    DateTime? createdAt,
    List<String>? completedDates,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      frequency: frequency ?? this.frequency,
      createdAt: createdAt ?? this.createdAt,
      completedDates: completedDates ?? this.completedDates,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'frequency': frequency.name,
      'createdAt': createdAt.toIso8601String(),
      'completedDates': completedDates,
    };
  }

  Map<String, dynamic> toSupabaseJson(String userId) {
    return {
      'user_id': userId,
      'title': title,
      'description': description,
      'frequency': frequency.name,
      'completed_dates': completedDates,
    };
  }

  factory Habit.fromSupabase(Map<String, dynamic> row) {
    return Habit(
      id: row['id'] as String,
      title: row['title'] as String,
      description: row['description'] as String? ?? '',
      frequency: HabitFrequency.values.firstWhere(
        (value) => value.name == row['frequency'],
        orElse: () => HabitFrequency.daily,
      ),
      createdAt: DateTime.parse(row['created_at'] as String),
      completedDates: (row['completed_dates'] as List<dynamic>? ?? [])
          .map((value) => value as String)
          .toList(),
    );
  }

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      frequency: HabitFrequency.values.firstWhere(
        (value) => value.name == json['frequency'],
        orElse: () => HabitFrequency.daily,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedDates: (json['completedDates'] as List<dynamic>? ?? [])
          .map((value) => value as String)
          .toList(),
    );
  }

  static String _dateKey(DateTime date) {
    final localDate = DateTime(date.year, date.month, date.day);
    return localDate.toIso8601String().split('T').first;
  }
}
