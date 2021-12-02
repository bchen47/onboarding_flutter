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

class GetTrainingClasses extends TrainingClassEvent {
  const GetTrainingClasses(this.token, this.category);

  final String token;
  final String category;
  @override
  List<Object> get props => [token, category];
}
