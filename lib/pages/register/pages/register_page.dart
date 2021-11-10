import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/pages/register/bloc/registro_bloc.dart';
import 'package:prueba/pages/register/pages/register_form.dart';
import 'package:prueba/pages/utils/style.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(12),
      child: BlocProvider(
        create: (context) {
          return RegistroBloc();
        },
        child: Scaffold(
          appBar: Customs.appBar("Registro"),
          extendBodyBehindAppBar: true,
          body: const RegisterForm(),
        ),
      ),
    ));
  }
}
