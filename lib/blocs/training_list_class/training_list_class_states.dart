part of 'training_list_class_bloc.dart';

class TrainingListClassState extends Equatable {
  const TrainingListClassState._(
      {this.trainingListClass = TrainingListClass.empty});
  final TrainingListClass trainingListClass;
  TrainingListClassState copyWith({TrainingListClass? trainingClass}) {
    return TrainingListClassState._(
        trainingListClass: trainingClass ?? trainingListClass);
  }

  @override
  List<Object> get props => [trainingListClass];
}
