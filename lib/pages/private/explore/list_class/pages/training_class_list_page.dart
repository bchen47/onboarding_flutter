import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/pages/private/explore/list_class/bloc/training_class_bloc.dart';
import 'package:prueba/pages/private/explore/list_class/training_class/bloc/class_bloc.dart';
import 'package:prueba/pages/private/explore/list_class/training_class/bloc/class_repository.dart';
import 'package:prueba/pages/private/explore/list_class/training_class/pages/training_individual_class_list_page.dart';
import 'package:prueba/pages/utils/style.dart';
import 'package:prueba/src/bloc/authentication_bloc.dart';
import 'package:intl/intl.dart';

class TrainingClassListPage extends StatelessWidget {
  final String category;
  const TrainingClassListPage({Key? key, category})
      : category = category ?? "",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TrainingClassBloc>(context);
    return BlocProvider(
        create: (BuildContext context) =>
            ClassBloc(classRepository: ClassRepository()),
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(12),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            context
                .read<TrainingClassBloc>()
                .add(const TrainingClassChanged([], {}));

            context
                .read<AuthenticationBloc>()
                .add(GetTrainingClasses(state.token.accessToken, category));
            return Scaffold(
                appBar: Customs.appBar("Elige un entrenamiento"),
                body: home(context));
          }),
        )));
  }

  Widget home(context) {
    return BlocBuilder<TrainingClassBloc, TrainingClassState>(
        builder: (context, state) {
      return ListView.separated(
        padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        itemCount: state.trainingClass.attributes.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: state.trainingClass.attributes.isNotEmpty
                  ? card(context, state.trainingClass.attributes[index],
                      state.trainingClass.trainers)
                  : Container());
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    });
  }

  Widget _loader(BuildContext context, String url) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _error(BuildContext context, String url, dynamic error) {
    return const Center(child: Icon(Icons.error));
  }

  Widget card(context, Map<String, dynamic> trainingClass,
      Map<String, dynamic> trainers) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TrainingIndividualClassPage(id: trainingClass["id"]),
                  ));
            },
            child: topSideCard(trainingClass, trainers)),
        bottomSide(trainingClass)
      ],
    );
  }

  Widget bottomSide(
    Map<String, dynamic> trainingClass,
  ) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        color: Colors.grey[850],
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
                alignment: Alignment.bottomLeft,
                child: Text(trainingClass["training_type"],
                    style: const TextStyle(fontSize: 12, color: Colors.grey)))
          ],
        ));
  }

  String convertTimeStampToHumanDate(int timeStamp) {
    var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    //DateFormat('HH:mm a');
    return DateFormat('dd MMM').format(dateToTimeStamp);
  }

  Widget topSideCard(
      Map<String, dynamic> trainingClass, Map<String, dynamic> trainers) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: trainingClass["cover"] ?? "",
          placeholder: _loader,
          errorWidget: _error,
        ),
        Positioned(
          child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: Text(trainingClass["title"].toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      trainers[trainingClass["trainer_id"].toString()]
                          .toString(),
                      style: const TextStyle(color: Colors.white70),
                    ))
              ])),
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
