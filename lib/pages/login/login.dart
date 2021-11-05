import 'package:flutter/material.dart';
import 'package:prueba/pages/utils/style.dart';
import 'package:prueba/src/bloc/bloc.dart';

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
    return StreamBuilder(
        stream: bloc.email,
        builder: (context, snapshot) {
          return TextField(
              onChanged: bloc.changeEmail,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: const Icon(Icons.email, color: Colors.grey),
                hintStyle: const TextStyle(color: Colors.grey),
                errorText:
                    snapshot.error == null ? null : snapshot.error.toString(),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ));
        });
  }

  Widget passwordField() {
    return StreamBuilder(
        stream: bloc.password,
        builder: (context, snapshot) {
          return TextField(
              obscureText: true,
              onChanged: bloc.changePassword,
              style: const TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                  errorText:
                      snapshot.error == null ? null : snapshot.error.toString(),
                  hintText: "Contraseña",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ) /*,
        suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
               true
               ? Icons.visibility
               : Icons.visibility_off,
               color: Colors.grey,
               ),  
               onPressed: const ()=>{},           
            ),*/
                  ));
        });
  }
}
