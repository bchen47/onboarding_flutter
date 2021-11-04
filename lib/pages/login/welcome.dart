import 'package:flutter/material.dart';
import 'package:prueba/pages/utils/style.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                  () => {Navigator.pushNamed(context, "/registerOptions")},
                  MaterialStateProperty.all(Colors.orange))),
          Expanded(
              child: Customs.button(
                  "INICIAR SESIÓN",
                  () => {Navigator.pushNamed(context, "/login")},
                  MaterialStateProperty.all(Colors.black)))
        ]));
  }
}
