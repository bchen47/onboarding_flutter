import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba/pages/private/explore/list_class/training_class/bloc/class_repository.dart';
import 'package:prueba/pages/private/explore/list_class/training_class/models/class.dart';
part 'class_events.dart';
part 'class_states.dart';

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
