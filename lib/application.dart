import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/screens/app_view.dart';
import 'package:prueba/blocs/authentication/authentication_bloc.dart';
import 'package:prueba/blocs/home/home_bloc.dart';
import 'package:prueba/blocs/user/user_bloc.dart';
import 'package:prueba/providers/authentication_repository.dart';
import 'package:prueba/providers/user_repository.dart';

class Application extends StatelessWidget {
  const Application({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
              create: (BuildContext context) => AuthenticationBloc(
                  authenticationRepository: authenticationRepository,
                  userRepository: userRepository)),
          BlocProvider<UserBloc>(
              create: (BuildContext context) =>
                  UserBloc(userRepository: userRepository)),
          BlocProvider<HomeBloc>(
              create: (BuildContext context) =>
                  HomeBloc(userRepository: userRepository)),
        ],
        child: RepositoryProvider<AuthenticationRepository>(
            create: (context) => authenticationRepository,
            child: const AppView()));
  }
}
