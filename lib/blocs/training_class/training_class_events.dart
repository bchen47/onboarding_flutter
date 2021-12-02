part of 'training_class_bloc.dart';

abstract class ClassEvent extends Equatable {
  const ClassEvent();

  @override
  List<Object> get props => [];
}

class ClassChanged extends ClassEvent {
  const ClassChanged(this.attributes, this.trainers);

  final Map<String, dynamic> attributes;
  final Map<String, dynamic> trainers;

  @override
  List<Object> get props => [attributes, trainers];
}

class GetClass extends ClassEvent {
  const GetClass(this.id, this.token);
  final String id;
  final String token;
  @override
  List<Object> get props => [id, token];
}
