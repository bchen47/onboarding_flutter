import 'package:flutter/material.dart';
import 'package:prueba/utils/style.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customs.appBar("Iniciar sesión"),
      extendBodyBehindAppBar: true,
      body: Center(
          child: Customs.button(
              "INICIAR SESIÓN",
              () => {Navigator.pushNamed(context, "/login")},
              MaterialStateProperty.all(Colors.orange))),
    );
  }
}
