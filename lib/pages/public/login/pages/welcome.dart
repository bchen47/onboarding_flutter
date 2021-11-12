import 'package:flutter/material.dart';
import 'package:prueba/pages/public/login/pages/login_page.dart';
import 'package:prueba/pages/public/login/pages/register_options.dart';
import 'package:prueba/pages/public/register/pages/register_page.dart';
import 'package:prueba/pages/utils/style.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    Key? key,
  }) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const WelcomePage());
  }

  Widget _buildHomeRoute(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login/img-fondo-sonrisa@3x.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [textLogin(), rowButton(context)]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (BuildContext context) => _buildHomeRoute(context),
        "/login": (BuildContext context) => const LoginPage(),
        "/register": (BuildContext context) => const RegisterPage(),
        "/options": (BuildContext context) => const RegisterOptions()
      },
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.black),
    );
  }

  Widget textLogin() {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10),
        child: Text(
            'BESTCYCLING LIFE\n\nENTRENA CUERPO, MENTE Y ALIMENTACIÓN EN UNA ÚNICA APP',
            textAlign: TextAlign.center,
            style: LoginStyle.loginText));
  }

  Widget rowButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              child: Customs.button(
                  "EMPIEZA AHORA",
                  () => {Navigator.pushNamed(context, "/options")},
                  MaterialStateProperty.all(Colors.orange))),
          Expanded(
              child: Customs.button(
                  "INICIAR SESIÓN",
                  () => {Navigator.pushNamed(context, "/login")},
                  MaterialStateProperty.all(Colors.black)))
        ]));
  }
}