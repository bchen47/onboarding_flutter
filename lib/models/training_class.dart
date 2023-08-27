import 'package:equatable/equatable.dart';

//Modelo del listado de clases
class TrainingClass extends Equatable {
  final Map<String, dynamic> attributes;
  final Map<String, dynamic> trainers;
  const TrainingClass(this.attributes, this.trainers);
  @override
  List<Object?> get props => [attributes, trainers];

  static const empty = TrainingClass({}, {});
}
