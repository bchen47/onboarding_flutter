import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/blocs/authentication/authentication_bloc.dart';
import 'package:prueba/blocs/home/home_bloc.dart';
import 'package:prueba/blocs/user/user_bloc.dart';
import 'package:prueba/repository/authentication_repository.dart';
import 'package:prueba/repository/user_repository.dart';
import 'package:prueba/screens/home/home_page.dart';
import 'package:prueba/screens/splash/splash_page.dart';
import 'package:prueba/screens/welcome/welcome_page.dart';

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

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/welcomepage": (BuildContext context) => const WelcomePage(),
        "/homepage": (BuildContext context) => const HomePage()
      },
      key: _scaffoldKey,
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.black),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushNamedAndRemoveUntil<void>(
                  "/homepage",
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushNamedAndRemoveUntil<void>(
                  "/welcomepage",
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
