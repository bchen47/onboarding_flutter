part of 'training_class_bloc.dart';

abstract class ClassEvent extends Equatable {
  const ClassEvent();

  @override
  List<Object> get props => [];
}

class TrainingClassChanged extends ClassEvent {
  const TrainingClassChanged(this.attributes, this.trainers);

  final Map<String, dynamic> attributes;
  final Map<String, dynamic> trainers;

  @override
  List<Object> get props => [attributes, trainers];
}

class TrainingGetClass extends ClassEvent {
  const TrainingGetClass(this.id, this.token);
  final String id;
  final String token;
  @override
  List<Object> get props => [id, token];
}
