import 'package:equatable/equatable.dart';

class User extends Equatable {
  final Map<String, dynamic> attributes;

  const User(this.attributes);
  @override
  List<Object?> get props => [attributes];
  static const empty = User({});
}
