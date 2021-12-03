import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba/repository/training_class_repository.dart';
import 'package:prueba/models/training_class.dart';
part 'training_class_events.dart';
part 'training_class_states.dart';

class TrainingClassBloc extends Bloc<ClassEvent, TrainingClassState> {
  TrainingClassBloc({required TrainingClassRepository classRepository})
      : _classRepository = classRepository,
        super(const TrainingClassState._()) {
    on<TrainingClassChanged>(_onLoadClass);
    on<TrainingGetClass>(_getClass);
    _classLoadedSuscription = classRepository.status.listen(
      (status) =>
          {add(TrainingClassChanged(status.attributes, status.trainers))},
    );
  }

  final TrainingClassRepository _classRepository;
  late StreamSubscription<TrainingClass> _classLoadedSuscription;

  @override
  Future<void> close() {
    _classLoadedSuscription.cancel();
    _classRepository.dispose();
    return super.close();
  }

  void _onLoadClass(
    TrainingClassChanged event,
    Emitter<TrainingClassState> emit,
  ) async {
    emit(state.copyWith(
        classes: TrainingClass(event.attributes, event.trainers)));
  }

  void _getClass(TrainingGetClass event, Emitter<TrainingClassState> emit) {
    Future<TrainingClass?> response =
        _classRepository.getTrainingClass(event.token, event.id);
    response.then((value) => emit(state.copyWith(
        classes: TrainingClass(value!.attributes, value.trainers))));
  }
}
