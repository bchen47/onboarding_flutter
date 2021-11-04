import 'package:flutter/material.dart';
import 'package:prueba/utils/style.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({
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
            children: [textLogin(), rowButton()]),
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

  Widget rowButton() {
    return Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              child: loginRowButton("EMPIEZA AHORA", () => {},
                  MaterialStateProperty.all(Colors.orange))),
          Expanded(
              child: loginRowButton("INICIAR SESIÓN", () => {},
                  MaterialStateProperty.all(Colors.black)))
        ]));
  }

  Widget loginRowButton(
      String text, dynamic onClick, MaterialStateProperty<Color> color) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: color,
          foregroundColor: MaterialStateProperty.all(Colors.white)),
      onPressed: onClick,
      child: Padding(padding: const EdgeInsets.all(8), child: Text(text)),
    );
  }
}
