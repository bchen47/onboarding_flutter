import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/blocs/training_class/training_class_bloc.dart';
import 'package:prueba/blocs/authentication/authentication_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prueba/screens/video_player/web_view_player.dart';

class TrainingIndividualClassPage extends StatelessWidget {
  final String id;
  const TrainingIndividualClassPage({Key? key, required id})
      : id = id ?? "",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
              context.read<ClassBloc>().add(const ClassChanged({}, {}));
              context.read<ClassBloc>().add(GetClass(id,
                  context.read<AuthenticationBloc>().state.token.accessToken));

              return BlocBuilder<ClassBloc, ClassState>(
                  builder: (context, state) {
                return Scaffold(
                    appBar: appBar(
                        state.classes.attributes["title"],
                        state.classes.trainers[
                            state.classes.attributes["trainer_id"].toString()]),
                    body: home(context, state));
              });
            })));
  }

  PreferredSizeWidget appBar(String? title, String? trainer) {
    return AppBar(
      elevation: 0, // 1
      backgroundColor: Colors.grey[900],
      title: Column(children: [
        Text(title ?? "Cargando...",
            style: TextStyle(fontSize: 16, color: Colors.grey[300])),
        Text(trainer ?? "...",
            style: const TextStyle(fontSize: 14, color: Colors.grey))
      ]),
      centerTitle: true,
    );
  }

  Widget home(context, state) {
    return SafeArea(
      child: Container(
          child: state.classes.attributes.isNotEmpty
              ? card(context, state.classes.attributes)
              : const Center(child: CircularProgressIndicator())),
    );
  }

  Widget _loader(BuildContext context, String url) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _error(BuildContext context, String url, dynamic error) {
    return const Center(child: Icon(Icons.error));
  }

  Widget card(context, Map<String, dynamic> trainingClass) {
    return Column(
      children: [
        topSideCard(trainingClass),
        middleSide(),
        bottomSide(trainingClass),
        description(trainingClass),
        const Spacer(),
        buttons(context, trainingClass)
      ],
    );
  }

  Widget description(trainingClass) {
    return Container(
        color: Colors.grey[900],
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Text(
          trainingClass["content"].toString(),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.grey),
        ));
  }

  Widget buttons(context, trainingClass) {
    return Center(
      child: Container(
          alignment: Alignment.bottomCenter,
          child: Column(children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('RESULTADOS',
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                minimumSize: const Size.fromHeight(
                    40), // fromHeight use double.infinity as width and 40 is the height
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewPlayer(
                          token: context
                              .read<AuthenticationBloc>()
                              .state
                              .token
                              .accessToken
                              .toString(),
                          data: trainingClass),
                    ));
              },
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('REPRODUCIR'),
              ),
            )
          ])),
    );
  }

  Widget middleSide() {
    return Center(
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Colors.grey[900] ?? Colors.grey,
          ))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              imageButton(Icons.star, "Añadir favorito"),
              imageButton(Icons.download, "Descargas")
            ],
          )),
    );
  }

  Widget imageButton(icon, text) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey))
          ],
        ));
  }

  Widget bottomSide(
    Map<String, dynamic> trainingClass,
  ) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.grey[900] ?? Colors.grey),
                bottom: BorderSide(
                  color: Colors.grey[900] ?? Colors.grey,
                ))),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Nivel",
                      style: TextStyle(fontSize: 10, color: Colors.white)),
                  Container(margin: const EdgeInsets.only(right: 5)),
                  levelDots((trainingClass["level_nr"] / 10).round(), 1),
                  levelDots((trainingClass["level_nr"] / 10).round(), 2),
                  levelDots((trainingClass["level_nr"] / 10).round(), 3)
                ],
              ),
              Text(
                  convertTimeStampToHumanDate(
                      trainingClass["published_at_timestamp"]),
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(
                  "Duración " +
                      ((trainingClass["duration_seconds"] as int) / 60)
                          .round()
                          .toString() +
                      "'",
                  style: const TextStyle(fontSize: 12, color: Colors.white)),
            ]),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: const Text("Intervalos",
                    style: TextStyle(fontSize: 12, color: Colors.grey))),
            Container(
                alignment: Alignment.center,
                child: Text(trainingClass["training_type"],
                    style: const TextStyle(fontSize: 12, color: Colors.grey))),
          ],
        ));
  }

  String convertTimeStampToHumanDate(int timeStamp) {
    var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    //DateFormat('HH:mm a');
    return DateFormat('dd MMM').format(dateToTimeStamp);
  }

  Widget topSideCard(Map<String, dynamic> trainingClass) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: trainingClass["cover"] ?? "",
          placeholder: _loader,
          errorWidget: _error,
        ),
        Positioned(
            bottom: 0.0,
            left: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  stats(trainingClass["life_force_points"].toString(),
                      Colors.red),
                  stats(trainingClass["life_resistance_points"].toString(),
                      Colors.yellow)
                ],
              ),
            )),
      ],
    );
  }

  Widget stats(String level, Color? color) {
    return Column(children: [
      Container(
        alignment: Alignment.center,
        width: 32,
        padding: const EdgeInsets.all(8),
        child: Text(
          level,
          textScaleFactor: 2,
          style: const TextStyle(
              fontSize: 6, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      )
    ]);
  }

  Widget levelDots(int level, int actual) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Column(children: [
          Container(
            width: 8,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: actual <= level ? Colors.white : Colors.grey,
            ),
          )
        ]));
  }
}
