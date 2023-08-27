import 'dart:async';

import 'package:prueba/repository/training_class_list_repository.dart';
import 'package:prueba/models/training_list_class.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'training_list_class_events.dart';
part 'training_list_class_states.dart';

//implementación de los métodos del controller del listado de clases
class TrainingListClassBloc
    extends Bloc<TrainingListClassEvent, TrainingListClassState> {
  TrainingListClassBloc(
      {required TrainingClassListRepository trainingClassListRepository})
      : _trainingListClassRepository = trainingClassListRepository,
        super(const TrainingListClassState._()) {
    on<TrainingListClassChanged>(_onLoadTrainingClass);
    on<GetTrainingListClasses>(_getTrainingClasses);
    //Listener que se activa cuando se modifican los datos
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

//avisa del cambio de estado cuando se modifica una clase
  void _onLoadTrainingClass(
    TrainingListClassChanged event,
    Emitter<TrainingListClassState> emit,
  ) async {
    emit(state.copyWith(
        trainingClass: TrainingListClass(event.attributes, event.trainers)));
  }

//Hace una petición al repositorio y cuando esté modifica el valor al bloc
  void _getTrainingClasses(GetTrainingListClasses event,
      Emitter<TrainingListClassState> emit) async {
    var response =
        _trainingListClassRepository.getClass(event.token, event.category);
    response.then((value) =>
        value ??
        state.copyWith(
            trainingClass: TrainingListClass(
                (value != null ? value.attributes : []),
                (value != null ? value.trainers : {}))));
  }
}
