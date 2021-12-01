part of 'training_class_bloc.dart';

abstract class TrainingClassEvent extends Equatable {
  const TrainingClassEvent();

  @override
  List<Object> get props => [];
}

class TrainingClassChanged extends TrainingClassEvent {
  const TrainingClassChanged(this.attributes, this.trainers);

  final List<Map<String, dynamic>> attributes;
  final Map<String, dynamic> trainers;

  @override
  List<Object> get props => [attributes, trainers];
}
