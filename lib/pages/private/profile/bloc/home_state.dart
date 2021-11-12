part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState(
      {
      //   this.status = FormzStatus.pure,
      // this.username = const Username.pure(),
      // this.password = const Password.pure(),
      this.index = 0});

  // final FormzStatus status;
  // final Username username;
  // final Password password;
  final int index;

  HomeState copyWith(
      {
      //   FormzStatus? status,
      // Username? username,
      // Password? password,
      int? index}) {
    return HomeState(
        // status: status ?? this.status,
        // username: username ?? this.username,
        // password: password ?? this.password,
        index: index ?? this.index);
  }

  @override
  List<Object> get props => [index];
}
