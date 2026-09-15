import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/habit_model.dart';
import '../../providers/habits_provider.dart';

class AddEditHabitScreen extends ConsumerStatefulWidget {
  final String? habitId;

  const AddEditHabitScreen({super.key, this.habitId});

  @override
  ConsumerState<AddEditHabitScreen> createState() => _AddEditHabitScreenState();
}

class _AddEditHabitScreenState extends ConsumerState<AddEditHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  HabitFrequency _frequency = HabitFrequency.daily;

  Habit? get _habit =>
      ref.read(habitsProvider.notifier).findById(widget.habitId);

  @override
  void initState() {
    super.initState();
    final habit = _habit;
    _titleController = TextEditingController(text: habit?.title);
    _descriptionController = TextEditingController(text: habit?.description);
    _frequency = habit?.frequency ?? HabitFrequency.daily;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final notifier = ref.read(habitsProvider.notifier);
    final existingHabit = _habit;

    if (existingHabit == null) {
      await notifier.addHabit(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        frequency: _frequency,
      );
    } else {
      await notifier.updateHabit(
        existingHabit.copyWith(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          frequency: _frequency,
        ),
      );
    }

    if (mounted) context.pop();
  }

  Future<void> _delete() async {
    final habit = _habit;
    if (habit == null) return;
    await ref.read(habitsProvider.notifier).deleteHabit(habit.id);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.habitId != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Modifier l’habitude' : 'Nouvelle habitude'),
        actions: [
          if (editing)
            IconButton(
              tooltip: 'Supprimer',
              onPressed: _delete,
              icon: const Icon(Icons.delete_outline_rounded),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _titleController,
              autofocus: !editing,
              decoration: const InputDecoration(
                labelText: 'Titre',
                hintText: 'Ex. Boire 2 litres d’eau',
                prefixIcon: Icon(Icons.edit_rounded),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Le titre est requis'
                  : null,
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description (facultatif)',
                prefixIcon: Icon(Icons.notes_rounded),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 18),
            DropdownButtonFormField<HabitFrequency>(
              initialValue: _frequency,
              decoration: const InputDecoration(
                labelText: 'Fréquence',
                prefixIcon: Icon(Icons.repeat_rounded),
              ),
              items: const [
                DropdownMenuItem(
                  value: HabitFrequency.daily,
                  child: Text('Tous les jours'),
                ),
                DropdownMenuItem(
                  value: HabitFrequency.weekly,
                  child: Text('Chaque semaine'),
                ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _frequency = value);
              },
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 54,
              child: FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.check_rounded),
                label: Text(editing ? 'Enregistrer' : 'Créer l’habitude'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
