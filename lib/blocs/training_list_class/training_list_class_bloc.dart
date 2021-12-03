import 'dart:async';

import 'package:prueba/repository/training_class_list_repository.dart';
import 'package:prueba/models/training_list_class.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'training_list_class_events.dart';
part 'training_list_class_states.dart';

class TrainingListClassBloc
    extends Bloc<TrainingListClassEvent, TrainingListClassState> {
  TrainingListClassBloc(
      {required TrainingClassListRepository trainingClassListRepository})
      : _trainingListClassRepository = trainingClassListRepository,
        super(const TrainingListClassState._()) {
    on<TrainingListClassChanged>(_onLoadTrainingClass);
    on<GetTrainingListClasses>(_getTrainingClasses);

    _trainingListClassLoadedSuscription =
        trainingClassListRepository.status.listen(
      (status) =>
          {add(TrainingListClassChanged(status.attributes, status.trainers))},
    );
  }

  final TrainingClassListRepository _trainingListClassRepository;
  late StreamSubscription<TrainingListClass>
      _trainingListClassLoadedSuscription;

  @override
  Future<void> close() {
    _trainingListClassLoadedSuscription.cancel();
    _trainingListClassRepository.dispose();
    return super.close();
  }

  void _onLoadTrainingClass(
    TrainingListClassChanged event,
    Emitter<TrainingListClassState> emit,
  ) async {
    emit(state.copyWith(
        trainingClass: TrainingListClass(event.attributes, event.trainers)));
  }

  void _getTrainingClasses(GetTrainingListClasses event,
      Emitter<TrainingListClassState> emit) async {
    var response =
        _trainingListClassRepository.getClass(event.token, event.category);
    response.then((value) => state.copyWith(
        trainingClass: TrainingListClass(value!.attributes, value.trainers)));
  }
}
