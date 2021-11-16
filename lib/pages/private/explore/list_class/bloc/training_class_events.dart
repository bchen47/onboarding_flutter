part of 'training_class_bloc.dart';

abstract class TrainingClassEvent extends Equatable {
  const TrainingClassEvent();

  @override
  List<Object> get props => [];
}

class TrainingClassChanged extends TrainingClassEvent {
  const TrainingClassChanged(this.attributes);

  final Map<String, dynamic> attributes;

  @override
  List<Object> get props => [attributes];
}
