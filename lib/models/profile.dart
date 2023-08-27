import 'package:equatable/equatable.dart';

//Modelo de datos del perfil
class Profile extends Equatable {
  final Map<String, dynamic> attributes;

  const Profile(this.attributes);
  @override
  List<Object?> get props => [attributes];

  static const empty = Profile({});
}
