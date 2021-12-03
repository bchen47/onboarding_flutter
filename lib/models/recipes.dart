import 'package:equatable/equatable.dart';

class Recipes extends Equatable {
  final List<Map<String, dynamic>> attributes;
  const Recipes(this.attributes);
  @override
  List<Object?> get props => [attributes];

  static const empty = Recipes([]);
}
