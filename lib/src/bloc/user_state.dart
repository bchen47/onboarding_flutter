part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState._({this.user = User.empty});
  final User user;

  UserState copyWith({User? user}) {
    return UserState._(user: user ?? this.user);
  }

  @override
  List<Object> get props => [user];
}
