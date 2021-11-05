import 'package:flutter/material.dart';
import 'package:prueba/pages/utils/style.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Customs.appBar("Iniciar sesión"),
        extendBodyBehindAppBar: true,
        body: Container(
          margin: const EdgeInsets.only(top: 60, left: 10, right: 10),
          child: Column(children: [
            emailField(),
            passwordField(),
            Container(margin: const EdgeInsets.only(top: 20)),
            Container(
                child: Customs.button(
                    "INICIAR SESIÓN",
                    () => {Navigator.pushNamed(context, "/login")},
                    MaterialStateProperty.all(Colors.orange)))
          ]),
        ));
  }

  Widget emailField() {
    return const TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.grey),
        decoration: InputDecoration(
          hintText: "Email",
          prefixIcon: Icon(Icons.email, color: Colors.grey),
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ));
  }

  Widget passwordField() {
    return const TextField(
      obscureText: true,
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        hintText: "Contraseña",
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(Icons.lock, color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan),
        ),
      ),
    );
  }
}
