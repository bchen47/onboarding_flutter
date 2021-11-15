part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState._({this.profile = Profile.empty});
  final Profile profile;

  ProfileState copyWith({Profile? profile}) {
    return ProfileState._(profile: profile ?? this.profile);
  }

  @override
  List<Object> get props => [profile];
}
