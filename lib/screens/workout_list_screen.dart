import 'package:fitness_tracker_app/providers/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../enums/workout_type.dart';
import '../widgets/workout_calendar_graph.dart';
import '../widgets/workout_form_dialog.dart';

class WorkoutListScreen extends StatelessWidget {
  const WorkoutListScreen({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const SizedBox.shrink(),
              toolbarHeight: 170,
              flexibleSpace: const SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: 56.0, left: 16.0, right: 16.0),
                    child: WorkoutCalendarGraph(),
                  ),
                ),
              ),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(48),
                child: TabBar(
                  tabs: [
                    Tab(text: 'Upper Body'),
                    Tab(text: 'Lower Body'),
                  ],
                ),
              ),
            ),
            body: Column(
              
              children: [
                TextButton(onPressed: () {
                  ref.read(workoutProvider.notifier).clearCompletedWorkouts();
                }, child: const Text("Clear Completed Workouts")),
                 const Expanded(
                  child: TabBarView(
                    children: [
                      _WorkoutList(type: WorkoutType.upperBody),
                      _WorkoutList(type: WorkoutType.lowerBody),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showAddWorkoutDialog(context),
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }

  void _showAddWorkoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const WorkoutFormDialog(),
    );
  }
}

class _WorkoutList extends ConsumerWidget {
  final WorkoutType type;

  const _WorkoutList({required this.type});

  @override
  Widget build(BuildContext context ,ref) {
    final unfillterworkout = ref.watch(workoutProvider);
    final workouts = unfillterworkout.where((element) => element.type == type,).toList();
    if(workouts.isEmpty){
      return Text("You dont have workout ");
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        final workout = workouts[index];
        return Card(
          child: ListTile(
            enabled: false,
            title: Text(
              workout.name,
              style:   TextStyle(
                decoration: workout.isCompleted ? TextDecoration.lineThrough : null,
                color: workout.isCompleted ? Colors.grey : Colors.white,
              ),
            ),
            subtitle:  Text(
              '${workout.sets} sets',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(value: workout.isCompleted, onChanged: (_) {
                  ref.read(workoutProvider.notifier).toggleWorkoutCompletion(workout.id);
                }),
                IconButton(icon: const Icon(Icons.delete), onPressed: () {
                  ref.read(workoutProvider.notifier).removeWorkout(workout.id);
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
