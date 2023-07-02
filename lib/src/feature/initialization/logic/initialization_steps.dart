import 'dart:async';
import 'package:holeo/src/feature/initialization/model/dependencies.dart';
import 'package:holeo/src/feature/initialization/model/initialization_progress.dart';
import 'package:holeo/src/feature/sample/repositoris/camera_repository.dart';
import 'package:l/l.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef StepAction = FutureOr<void>? Function(InitializationProgress progress);

/// The initialization steps, which are executed in the order they are defined.
///
/// The [Dependencies] object is passed to each step, which allows the step to
/// set the dependency, and the next step to use it.
mixin InitializationSteps {
  final initializationSteps = <String, StepAction>{
    'Init env': (progress) => l.d(progress.environmentStore.environment),
    'Shared Preferences': (progress) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      progress.dependencies.sharedPreferences = sharedPreferences;
    },
    'Camera repository': (progress) =>
        progress.dependencies.cameraRepository = CameraRepository(),
  };
}
