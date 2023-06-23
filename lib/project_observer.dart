import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:project/core/models/model.dart';

class ProjectObserver extends BlocObserver {
  const ProjectObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    bool isLogging = true;
    // ignore: dead_code
    if (isLogging) {
      if (change.currentState is Model) {
        debugPrint(
            '${bloc.runtimeType} currentState: ${change.currentState.toJson()}');
        debugPrint(
            '-------------------------------------------------------------------');
        debugPrint(
            '${bloc.runtimeType} nextState: ${change.nextState.toJson()}');
        debugPrint('');
      } else {
        debugPrint('${bloc.runtimeType} $change');
      }
    }
  }
}
