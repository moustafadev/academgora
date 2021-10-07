import 'dart:async';

import 'package:academ_gora_release/model/workout.dart';
import 'package:academ_gora_release/screens/account/user_profile/data/firebase_workouts_controller.dart';
import 'package:academ_gora_release/screens/account/user_profile/data/firebase_workouts_controller_impl.dart';
import 'package:academ_gora_release/screens/account/user_profile/data/workouts_keeper.dart';
import 'package:academ_gora_release/screens/account/user_profile/presentation/workouts_view_model.dart';

class WorkoutsViewModelImpl implements WorkoutsViewModel, WorkoutsDataListener{

  final FirebaseWorkoutsController _controller = FirebaseWorkoutsControllerImplementation();
  final _workoutsListController = StreamController<List<Workout>>.broadcast();

  @override
   void getWorkouts(){
     _controller.getWorkoutsAndSubscribeToChanges(this);
   }

  @override
  Stream<List<Workout>> get workoutsList => _workoutsListController.stream;

  @override
  void updateListener(List<Workout> workouts) {
    _workoutsListController.sink.add(workouts);
  }

  void dispose() {
    _workoutsListController.close();
  }

}