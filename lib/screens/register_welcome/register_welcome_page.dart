import 'package:flutter/material.dart';
import 'package:prueba/utils/style.dart';

class RegisterOptions extends StatelessWidget {
  const RegisterOptions({
    Key? key,
  }) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RegisterOptions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Customs.appBar("Registro"),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/login/image_register@3x.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: Customs.button(
                  "REGISTRARME CON EMAIL",
                  () => {Navigator.pushNamed(context, "/register")},
                  MaterialStateProperty.all(Colors.orange))),
        ));
  }
}
