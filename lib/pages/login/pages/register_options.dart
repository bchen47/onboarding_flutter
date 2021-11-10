import 'package:flutter/material.dart';
import 'package:prueba/pages/register/pages/register_page.dart';
import 'package:prueba/pages/utils/style.dart';

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
                  () => {Navigator.push(context, RegisterPage.route())},
                  MaterialStateProperty.all(Colors.orange))),
        ));
  }
}
