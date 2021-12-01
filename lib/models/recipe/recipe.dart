import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final Map<String, dynamic> attributes;
  final Map<String, dynamic> author;
  const Recipe(this.attributes, this.author);
  @override
  List<Object?> get props => [attributes, author];

  static const empty = Recipe({}, {});
}
