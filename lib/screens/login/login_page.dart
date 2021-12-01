import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/blocs/login/login_bloc.dart';
import 'package:prueba/providers/authentication_repository.dart';
import 'package:prueba/screens/login/login_form.dart';
import 'package:prueba/utils/style.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(12),
      child: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          );
        },
        child: Scaffold(
          appBar: Customs.appBar("Iniciar sesión"),
          extendBodyBehindAppBar: true,
          body: const LoginForm(),
        ),
      ),
    ));
  }
}
