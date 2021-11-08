import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id, this.token);

  final String id;
  final String token;

  @override
  List<Object> get props => [id, token];

  static const empty = User('-', '-');
}
