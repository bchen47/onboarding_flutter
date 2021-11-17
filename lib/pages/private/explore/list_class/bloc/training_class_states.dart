part of 'training_class_bloc.dart';

class TrainingClassState extends Equatable {
  const TrainingClassState._({this.trainingClass = TrainingClass.empty});
  final TrainingClass trainingClass;
  TrainingClassState copyWith({TrainingClass? trainingClass}) {
    return TrainingClassState._(
        trainingClass: trainingClass ?? this.trainingClass);
  }

  @override
  List<Object> get props => [trainingClass];
}
