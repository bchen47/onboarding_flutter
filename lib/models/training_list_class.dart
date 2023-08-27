import 'package:equatable/equatable.dart';

//Modelo del listado de clases
class TrainingListClass extends Equatable {
  final List<Map<String, dynamic>> attributes;
  final Map<String, dynamic> trainers;
  const TrainingListClass(this.attributes, this.trainers);
  @override
  List<Object?> get props => [attributes, trainers];

  static const empty = TrainingListClass([], {});
}
