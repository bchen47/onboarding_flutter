part of 'class_bloc.dart';

class ClassState extends Equatable {
  const ClassState._({this.classes = Class.empty});
  final Class classes;
  ClassState copyWith({Class? classes}) {
    return ClassState._(classes: classes ?? this.classes);
  }

  @override
  List<Object> get props => [classes];
}
