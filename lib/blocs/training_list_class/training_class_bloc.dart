import 'dart:async';

import 'package:prueba/providers/training_class_list_repository.dart';
import 'package:prueba/models/list_class/training_class.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'training_class_events.dart';
part 'training_class_states.dart';

class TrainingClassBloc extends Bloc<TrainingClassEvent, TrainingClassState> {
  TrainingClassBloc({required TrainingClassRepository trainingClassRepository})
      : _trainingClassRepository = trainingClassRepository,
        super(const TrainingClassState._()) {
    on<TrainingClassChanged>(_onLoadTrainingClass);

    _trainingClassLoadedSuscription = trainingClassRepository.status.listen(
      (status) =>
          {add(TrainingClassChanged(status.attributes, status.trainers))},
    );
  }

  final TrainingClassRepository _trainingClassRepository;
  late StreamSubscription<TrainingClass> _trainingClassLoadedSuscription;

  @override
  Future<void> close() {
    _trainingClassLoadedSuscription.cancel();
    _trainingClassRepository.dispose();
    return super.close();
  }

  void _onLoadTrainingClass(
    TrainingClassChanged event,
    Emitter<TrainingClassState> emit,
  ) async {
    emit(state.copyWith(
        trainingClass: TrainingClass(event.attributes, event.trainers)));
  }
}
