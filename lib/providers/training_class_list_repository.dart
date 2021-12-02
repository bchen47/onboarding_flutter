import 'dart:async';
import 'dart:io';
import 'package:json_api/client.dart';
import 'package:json_api/routing.dart';
import 'package:prueba/models/list_class/training_class.dart';

class UnAuthenticated implements Exception {
  String cause;
  UnAuthenticated(this.cause);
}

class TrainingClassRepository {
  TrainingClass? _class;
  var _controller = StreamController<TrainingClass>();
  Stream<TrainingClass> get status {
    if (_controller.isClosed) _controller = StreamController<TrainingClass>();
    return _controller.stream;
  }

  Future<TrainingClass?> getClass(String accessToken, String category) async {
    if (_class != null) return _class;
    if (accessToken == "-") return null;
    final uriDesign =
        StandardUriDesign(Uri.parse("https://apiv2.bestcycling.es/api/v2/"));

    final client = RoutingClient(uriDesign);
    final response = await client.fetchCollection('training_classes', headers: {
      HttpHeaders.userAgentHeader: "Flutter migration app",
      HttpHeaders.authorizationHeader: 'Bearer ' + accessToken,
      HttpHeaders.contentTypeHeader: 'application/vnd.api+json',
      'X-APP-ID': '1d665fac3ced84d799e615f5d5a2c1af'
    }, filter: {
      "category_nr": category
    }, include: [
      "trainer"
    ]);

    if (!response.http.isFailed && response.http.hasDocument) {
      final resources = response.collection;

      List<Map<String, dynamic>> clases = [];
      Map<String, dynamic> trainers = {};

      // resources.map((resource) {
      //   clases.add(resource.attributes);
      // });
      resources.toList().forEach((element) {
        var trainingClass = element.attributes;
        trainingClass.addAll({"id": element.id});
        clases.add(trainingClass);
      });
      response.included.toList().forEach((element) {
        trainers
            .addAll({element.id: element.attributes["full_name"].toString()});
      });
      //List<Map<String, dynamic>> resourc = resources.toList();

      _controller.add(TrainingClass(clases, trainers));
      //response.resource.attributes
    } else {
      throw UnAuthenticated("No ha podido cargar las clases");
    }
  }

  void dispose() {
    _controller.close();
    _controller = StreamController<TrainingClass>();
  }

  static Map<String, String> get headers {
    return {
      HttpHeaders.contentTypeHeader: 'application/vnd.api+json',
      HttpHeaders.userAgentHeader: "Flutter migration app",
      HttpHeaders.authorizationHeader:
          'X-APP-ID: 1d665fac3ced84d799e615f5d5a2c1af'
    };
  }
}