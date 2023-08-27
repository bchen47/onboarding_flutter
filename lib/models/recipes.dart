import 'package:equatable/equatable.dart';

//Modelo para gestionar el listado de recetas
class Recipes extends Equatable {
  final List<Map<String, dynamic>> attributes;
  const Recipes(this.attributes);
  @override
  List<Object?> get props => [attributes];

  static const empty = Recipes([]);
}
