import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final Map<String, dynamic> attributes;

  const Profile(this.attributes);
  @override
  List<Object?> get props => [attributes];

  static const empty = Profile({});
}
