import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/pages/utils/style.dart';
import 'package:prueba/src/bloc/authentication_repository.dart';
import 'package:prueba/pages/login/bloc/login_bloc.dart';

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
            child: BlocProvider(
              create: (context) {
                return LoginBloc(
                  authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository>(context),
                );
              },
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
            )));
  }

  Widget emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_usernameInput_textField'),
            onChanged: (username) =>
                context.read<LoginBloc>().add(LoginUsernameChanged(username)),
            style: const TextStyle(color: Colors.grey),
            decoration: InputDecoration(
                errorText: state.username.invalid ? 'invalid username' : null,
                hintText: "Email",
                prefixIcon: const Icon(Icons.email, color: Colors.grey),
                hintStyle: const TextStyle(color: Colors.grey),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                )),
          );
        });
    /*return StreamBuilder(
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
        });*/
  }

  Widget passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, snapshot) {
          return BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) =>
                previous.username != current.username,
            builder: (context, state) {
              return TextField(
                  key: const Key('loginForm_passwordInput_textField'),
                  onChanged: (username) => context
                      .read<LoginBloc>()
                      .add(LoginUsernameChanged(username)),
                  obscureText: true,
                  decoration: InputDecoration(
                    errorText:
                        state.password.invalid ? 'invalid password' : null,
                    hintText: "Contraseña",
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                  ));
            },
            /*return TextField(
              obscureText: true,
              //onChanged: bloc.changePassword,
              style: const TextStyle(color: Colors.grey),
              onChanged: (username) =>
                  context.read<LoginBloc>().add(LoginUsernameChanged(username)),
              decoration: InputDecoration(
                  errorText:
                      snapshot.error == null ? null : snapshot.error.toString(),
                  hintText: "Contraseña",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ) */ /*,
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
          );
        });
  }
}
