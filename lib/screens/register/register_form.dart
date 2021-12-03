import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:prueba/blocs/register/register_bloc.dart';
import 'package:prueba/screens/login/login_page.dart';
import 'package:prueba/utils/style.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RegisterForm());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Error en el Registro')),
              );
          }
          if (state.status.isSubmissionSuccess) {
            Navigator.push(context, LoginPage.route());
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 60, left: 10, right: 10),
          child: Column(children: [
            userNameField(),
            emailField(),
            passwordField(),
            Container(margin: const EdgeInsets.only(top: 20)),
            _RegistroButton(),
          ]),
        ));
  }

  Widget userNameField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, state) {
          return TextField(
            key: const Key('RegistroForm_usernameInput_textField'),
            onChanged: (username) => {
              context
                  .read<RegisterBloc>()
                  .add(RegisterUsernameChanged(username)),
            },
            style: const TextStyle(color: Colors.grey),
            decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                errorText: state.username.invalid
                    ? 'Nombre de usuario no válido'
                    : null,
                hintText: "Nombre y apellidos",
                prefixIcon: const Icon(Icons.person, color: Colors.grey),
                hintStyle: const TextStyle(color: Colors.grey),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                )),
          );
        });
  }

  Widget emailField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextField(
            key: const Key('RegistroForm_emailInput_textField'),
            onChanged: (email) => {
              context.read<RegisterBloc>().add(RegisterEmailChanged(email)),
            },
            style: const TextStyle(color: Colors.grey),
            decoration: InputDecoration(
                errorText: state.email.invalid ? 'Correo no válido' : null,
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
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.visible != current.visible,
      builder: (context, state) {
        return TextField(
            key: const Key('RegistroForm_passwordInput_textField'),
            onChanged: (password) => context
                .read<RegisterBloc>()
                .add(RegisterPasswordChanged(password)),
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
                          .read<RegisterBloc>()
                          .add(RegisterVisibilityChanged(!state.visible));
                    })));
      },
    );
  }
}

class _RegistroButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.index == FormzStatus.submissionInProgress.index
            ? const CircularProgressIndicator()
            : Customs.button(
                "REGISTRARME",
                () => {
                      context
                          .read<RegisterBloc>()
                          .add(const RegisterSubmitted()),
                    },
                MaterialStateProperty.all(Colors.orange));
      },
    );
  }
}
