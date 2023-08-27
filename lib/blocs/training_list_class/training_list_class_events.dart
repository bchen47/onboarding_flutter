part of 'training_list_class_bloc.dart';

//Clase que contiene los eventos del listado de clases
abstract class TrainingListClassEvent extends Equatable {
  const TrainingListClassEvent();

  @override
  List<Object> get props => [];
}

class TrainingListClassChanged extends TrainingListClassEvent {
  const TrainingListClassChanged(this.attributes, this.trainers);

  final List<Map<String, dynamic>> attributes;
  final Map<String, dynamic> trainers;

  @override
  List<Object> get props => [attributes, trainers];
}

class GetTrainingListClasses extends TrainingListClassEvent {
  const GetTrainingListClasses(this.token, this.category);

  final String token;
  final String category;
  @override
  List<Object> get props => [token, category];
}
