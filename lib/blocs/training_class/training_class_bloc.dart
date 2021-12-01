import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba/providers/training_class_repository.dart';
import 'package:prueba/models/training_class/class.dart';
part 'training_class_events.dart';
part 'training_class_states.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassBloc({required ClassRepository classRepository})
      : _classRepository = classRepository,
        super(const ClassState._()) {
    on<ClassChanged>(_onLoadClass);

    _classLoadedSuscription = classRepository.status.listen(
      (status) => {add(ClassChanged(status.attributes, status.trainers))},
    );
  }

  final ClassRepository _classRepository;
  late StreamSubscription<Class> _classLoadedSuscription;

  @override
  Future<void> close() {
    _classLoadedSuscription.cancel();
    _classRepository.dispose();
    return super.close();
  }

  void _onLoadClass(
    ClassChanged event,
    Emitter<ClassState> emit,
  ) async {
    emit(state.copyWith(classes: Class(event.attributes, event.trainers)));
  }
}
