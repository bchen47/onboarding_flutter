import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/pages/public/login/bloc/login_bloc.dart';
import 'package:prueba/pages/public/login/pages/login_form.dart';
import 'package:prueba/pages/utils/style.dart';
import 'package:prueba/src/bloc/authentication_bloc.dart';
import 'package:prueba/src/bloc/authentication_repository.dart';

class TrainingClassListPage extends StatelessWidget {
  final String category;
  const TrainingClassListPage({Key? key, category})
      : category = category ?? "",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(12),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        context
            .read<AuthenticationBloc>()
            .add(GetTrainingClasses(state.token.accessToken, category));
        return Scaffold(
            appBar: Customs.appBar("Elige un entrenamiento"),
            body: home(context));
      }),
    ));
  }
}

Widget home(context) {
  return Text("asd");
}
