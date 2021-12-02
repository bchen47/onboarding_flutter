import 'package:flutter/material.dart';
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
        child: SafeArea(
          child: Scaffold(
            appBar: Customs.appBar("Iniciar sesión"),
            extendBodyBehindAppBar: true,
            body: const LoginForm(),
          ),
        ),
      ),
    );
  }
}
