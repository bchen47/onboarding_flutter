part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileChanged extends ProfileEvent {
  const ProfileChanged(this.attributes);

  final Map<String, dynamic> attributes;

  @override
  List<Object> get props => [attributes];
}
