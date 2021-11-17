part of 'class_bloc.dart';

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
