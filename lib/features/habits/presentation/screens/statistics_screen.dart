import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/habits_provider.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitsProvider);
    final today = DateTime.now();
    final completedToday =
        habits.where((habit) => habit.isCompletedOn(today)).length;
    final totalCompletions = habits.fold<int>(
      0,
      (sum, habit) => sum + habit.completedDates.length,
    );
    final completionRate =
        habits.isEmpty ? 0 : ((completedToday / habits.length) * 100).round();

    return Scaffold(
      appBar: AppBar(title: const Text('Progrès')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Vos résultats',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: MediaQuery.sizeOf(context).width > 600 ? 3 : 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.35,
            children: [
              _StatTile(
                icon: Icons.check_circle_outline_rounded,
                label: 'Aujourd’hui',
                value: '$completedToday/${habits.length}',
              ),
              _StatTile(
                icon: Icons.percent_rounded,
                label: 'Taux du jour',
                value: '$completionRate%',
              ),
              _StatTile(
                icon: Icons.local_fire_department_outlined,
                label: 'Complétions',
                value: '$totalCompletions',
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            'Par habitude',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 12),
          ...habits.map(
            (habit) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                child: Icon(
                  habit.isCompletedOn(today)
                      ? Icons.check_rounded
                      : Icons.circle_outlined,
                ),
              ),
              title: Text(habit.title),
              subtitle: Text('${habit.completedDates.length} complétion(s)'),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
