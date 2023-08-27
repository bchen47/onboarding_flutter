import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/blocs/profile/profile_bloc.dart';
import 'package:prueba/blocs/authentication/authentication_bloc.dart';
import 'package:prueba/blocs/user/user_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: home()));
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  static const TextStyle optionStyleImageCardText =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);

  Widget home() {
    return SingleChildScrollView(
        child: Column(children: [
      profileInfo(),
      Container(
          color: Colors.black,
          margin: const EdgeInsets.only(top: 30),
          child: Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(right: 40.0, left: 40.0)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.orange, width: 1),
                                  borderRadius: BorderRadius.circular(30.0))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent)),
                      onPressed: () => {
                            context
                                .read<AuthenticationBloc>()
                                .add(AuthenticationLogoutRequested())
                          },
                      child: const Text("CERRAR SESIÓN"));
                },
              )))
    ]));
  }

  Widget profileInfo() {
    return Container(
        color: Colors.grey[850],
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const Text(
                    "Perfil",
                    style: optionStyle,
                  ))
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
          ),
          BlocBuilder<UserBloc, UserState>(builder: (context, state) {
            if (state.user.attributes.isEmpty) {
              return const CircularProgressIndicator();
            }
            return Image.network(state.user.attributes.isNotEmpty
                ?   state.user.attributes["avatar_url"]
                : "https://images-na.ssl-images-amazon.com/images/I/41mgseqmd0L.png");
          }),
          Container(
              margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                "Bestcycling S.L.",
                style: TextStyle(fontSize: 20, color: Colors.grey[500]),
              )),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.location_pin, color: Colors.grey[500]),
            Text(
              "Alboraya, España",
              style: TextStyle(color: Colors.grey[500]),
            )
          ]),
          Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.only(right: 40.0, left: 40.0)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.orange, width: 1),
                          borderRadius: BorderRadius.circular(30.0))),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent)),
                  onPressed: () => {},
                  child: const Text("Editar"))),
          middleStatsItemRow(),
          bottomStatsRow()
        ]));
  }

  Widget middleStatsItemRow() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return Container(
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.grey),
                  bottom: BorderSide(color: Colors.grey))),
          padding: const EdgeInsets.only(
              top: 10.0, right: 30.0, left: 30.0, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              middleStatsItem(
                  state.profile.attributes["level"].toString(), "NIVEL"),
              middleStatsItem(
                  state.profile.attributes["perseverance"].toString(),
                  "CONSTANCIA"),
              middleStatsItem(
                  state.profile.attributes["points"].toString(), "PUNTOS")
            ],
          ));
    });
  }

  Widget middleStatsItem(String level, String label) {
    return Column(children: [
      Text(
        level,
        style: optionStyle,
      ),
      Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey))
    ]);
  }

  Widget bottomStatsRow() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return Container(
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          padding: const EdgeInsets.only(
              top: 10.0, right: 30.0, left: 30.0, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bottomStatsItem(
                  state.profile.attributes["resistance_points"].toString(),
                  "Resistencia",
                  Colors.yellow),
              bottomStatsItem(
                  state.profile.attributes["force_points"].toString(),
                  "Fuerza",
                  Colors.red),
              bottomStatsItem(
                  state.profile.attributes["flexibility_points"].toString(),
                  "Flexibilidad",
                  Colors.green),
              bottomStatsItem(
                  state.profile.attributes["mind_points"].toString(),
                  "Mente",
                  Colors.blue)
            ],
          ));
    });
  }

  Widget bottomStatsItem(String level, String label, Color? color) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(20),
        child: Text(
          level,
          textScaleFactor: 2,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
      Container(
          padding: const EdgeInsets.only(top: 10),
          child: Text(label,
              style: const TextStyle(fontSize: 14, color: Colors.grey)))
    ]);
  }
}
