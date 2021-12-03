part of 'training_class_bloc.dart';

class TrainingClassState extends Equatable {
  const TrainingClassState._({this.classes = TrainingClass.empty});
  final TrainingClass classes;
  TrainingClassState copyWith({TrainingClass? classes}) {
    return TrainingClassState._(classes: classes ?? this.classes);
  }

  @override
  List<Object> get props => [classes];
}
