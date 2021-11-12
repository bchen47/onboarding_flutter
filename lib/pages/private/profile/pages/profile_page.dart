import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/src/bloc/authentication_bloc.dart';
import 'package:prueba/src/bloc/user_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: home());
  }

  Widget home() {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return Container(
          color: Colors.grey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: const [Text("Perfil")]),
                Image.network("https://bestcycling.com/" +
                    state.user.attributes["avatar_url"]),
                const Text("Bestcycling S.L."),
                Row(children: const [
                  Icon(Icons.location_pin),
                  Text("Alboraya, España")
                ]),
              ]));
    });
  }
}
