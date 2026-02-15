import 'package:fitness_tracker_app/enums/workout_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../models/workout.dart';

part 'workout_provider.g.dart';

@Riverpod(keepAlive: true)
class WorkoutNotifier extends _$WorkoutNotifier {
  final uuid = const Uuid();
  
  @override
  List<Workout> build() {
    return[];
  }

void addWorkdout(
  String name, 
  double wight,
  double reps,
  double sets,
  WorkoutType type
){
  state = [
    ...state,
    Workout(
      id: uuid.v4(),
      name: name,
      weight: wight,
      reps: reps,
      sets: sets,
      isCompleted: false,
      type: type,
      createdAt: DateTime.now(),
    )
  ];
}
void toggleWorkoutCompletion(String id){
  state = state.map((workout) {
    if(workout.id == id){
      return workout.copyWith(
        isCompleted: !workout.isCompleted,
        completedAt: workout.isCompleted ? null : DateTime.now(),
      );
    }
    return workout;
  }).toList();
}

void removeWorkout(String id){
  state = state.where((workout) => workout.id != id).toList();


}

void clearCompletedWorkouts(){
  state = state.where((workout) => !workout.isCompleted).toList();
}

}