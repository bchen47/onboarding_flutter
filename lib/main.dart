//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// © Cosmos Software | Ali Yigit Bireroglu                                                                                                           /
// All material used in the making of this code, project, program, application, software et cetera (the "Intellectual Property")                     /
// belongs completely and solely to Ali Yigit Bireroglu. This includes but is not limited to the source code, the multimedia and                     /
// other asset files. If you were granted this Intellectual Property for personal use, you are obligated to include this copyright                   /
// text at all times.                                                                                                                                /
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//@formatter:off

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/pages/private/explore/list_class/bloc/training_class_bloc.dart';
import 'package:prueba/pages/private/explore/list_class/bloc/training_class_repository.dart';
import 'package:prueba/pages/private/explore/list_class/training_class/bloc/class_bloc.dart';
import 'package:prueba/pages/private/explore/list_class/training_class/bloc/class_repository.dart';
import 'package:prueba/pages/private/explore/recipes_class/bloc/recipes_bloc.dart';
import 'package:prueba/pages/private/explore/recipes_class/bloc/recipes_repository.dart';
import 'package:prueba/pages/private/home/pages/home_page.dart';
import 'package:prueba/pages/private/profile/bloc/profile_bloc.dart';
import 'package:prueba/pages/private/profile/bloc/profile_repository.dart';
import 'package:prueba/pages/public/login/pages/welcome.dart';
import 'package:prueba/src/bloc/authentication_bloc.dart';
import 'package:prueba/src/bloc/authentication_repository.dart';
import 'package:prueba/src/bloc/user_bloc.dart';
import 'package:prueba/src/bloc/user_repository.dart';
import 'pages/splash/splash.dart';

void main() => runApp(App(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
      profileRepository: ProfileRepository(),
      trainingClassRepository: TrainingClassRepository(),
      recipesRepository: RecipesRepository(),
      classRepository: ClassRepository(),
    ));
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class App extends StatelessWidget {
  const App(
      {Key? key,
      required this.authenticationRepository,
      required this.userRepository,
      required this.profileRepository,
      required this.trainingClassRepository,
      required this.recipesRepository,
      required this.classRepository})
      : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final ProfileRepository profileRepository;
  final TrainingClassRepository trainingClassRepository;
  final RecipesRepository recipesRepository;
  final ClassRepository classRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: authenticationRepository,
        child: BlocProvider(
            create: (_) => AuthenticationBloc(
                authenticationRepository: authenticationRepository,
                userRepository: userRepository,
                profileRepository: profileRepository,
                trainingClassRepository: trainingClassRepository,
                recipesRepository: recipesRepository,
                classRepository: classRepository),
            child: RepositoryProvider.value(
                value: userRepository,
                child: BlocProvider(
                    create: (_) => UserBloc(userRepository: userRepository),
                    child: RepositoryProvider.value(
                        value: profileRepository,
                        child: BlocProvider(
                            create: (_) => ProfileBloc(
                                profileRepository: profileRepository),
                            child: BlocProvider(
                                create: (_) => TrainingClassBloc(
                                    trainingClassRepository:
                                        trainingClassRepository),
                                child: BlocProvider(
                                    create: (_) => RecipesBloc(
                                        recipesRepository: recipesRepository),
                                    child: BlocProvider(
                                      create: (_) => ClassBloc(
                                          classRepository: classRepository),
                                      child: const AppView(),
                                    )))))))));
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
    // context.read<AuthenticationBloc>().add(AuthenticationCheckAuthenticated());
    return MaterialApp(
      key: _scaffoldKey,
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.black),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  WelcomePage.route(),
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
/*void main() => runApp(MyApp(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository()));

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
          create: (_) =>
           AuthenticationBloc(
                authenticationRepository: authenticationRepository,
                userRepository: userRepository,
              ),
          child: MaterialApp(
            title: 'Image Sequence Animator Demo',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.black),
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashPage(),
              '/welcome': (context) => const WelcomePage(),
              '/registerOptions': (context) => const RegisterOptions(),
              '/login': (context) => const LoginPage()
            },
          )),
    );
  }
}*/


