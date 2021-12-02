import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:prueba/utils/style.dart';
import 'package:prueba/blocs/login/login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginForm());
  }

  @override
  Widget build(BuildContext context) {
    context.read<LoginBloc>();
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Error en el login')),
              );
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 60, left: 10, right: 10),
          child: Column(children: [
            emailField(),
            passwordField(),
            Container(margin: const EdgeInsets.only(top: 20)),
            _LoginButton(),
          ]),
        ));
  }

  Widget emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_usernameInput_textField'),
            onChanged: (username) => {
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
            },
            style: const TextStyle(color: Colors.grey),
            decoration: InputDecoration(
                errorText: state.username.invalid
                    ? 'Nombre de usuario no válido'
                    : null,
                hintText: "Email",
                prefixIcon: const Icon(Icons.email, color: Colors.grey),
                hintStyle: const TextStyle(color: Colors.grey),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                )),
          );
        });
  }

  Widget passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.visible != current.visible,
      builder: (context, state) {
        return TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)),
            obscureText: state.visible,
            style: const TextStyle(color: Colors.grey),
            decoration: InputDecoration(
                errorText:
                    state.password.invalid ? 'Contraseña inválida' : null,
                hintText: "Contraseña",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      state.visible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      context
                          .read<LoginBloc>()
                          .add(LoginVisibilityChanged(!state.visible));
                    })));
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.index == FormzStatus.submissionInProgress.index
            ? const CircularProgressIndicator()
            : Customs.button(
                "INICIAR SESIÓN",
                () => {
                      context.read<LoginBloc>().add(const LoginSubmitted()),
                    },
                MaterialStateProperty.all(Colors.orange));
      },
    );
  }
}
