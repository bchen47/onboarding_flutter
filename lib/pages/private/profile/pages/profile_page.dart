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

  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  static const TextStyle optionStyleImageCardText =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);

  Widget home() {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return Container(
          color: Colors.grey[850],
          child: Container(
              margin: const EdgeInsets.only(top: 25.0),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Perfil",
                        style: optionStyle,
                      )
                    ]),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                ),
                Image.network("https://bestcycling.com/" +
                    state.user.attributes["avatar_url"]),
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
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.orange, width: 1),
                                    borderRadius: BorderRadius.circular(30.0))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent)),
                        onPressed: () => {},
                        child: const Text("Editar"))),
                middleStatsItemRow(state)
              ])));
    });
  }

  Widget middleStatsItemRow(state) {
    return Container(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MiddleStatsItem(
                state.user.attributes["affiliation_data"]["level"].toString(),
                "nivel"),
            MiddleStatsItem(
                state.user.attributes["affiliation_data"]["level"].toString(),
                "nivel"),
            MiddleStatsItem(
                state.user.attributes["affiliation_data"]["level"].toString(),
                "nivel")
          ],
        ));
  }

  Widget MiddleStatsItem(String level, String label) {
    return Column(children: [
      Text(
        level,
        style: optionStyle,
      ),
      Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey))
    ]);
  }
}
