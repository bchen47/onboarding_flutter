import 'dart:async';
import 'dart:io';
import 'package:json_api/client.dart';
import 'package:json_api/routing.dart';
import 'package:prueba/pages/private/explore/list_class/training_class/models/class.dart';

class UnAuthenticated implements Exception {
  String cause;
  UnAuthenticated(this.cause);
}

class ClassRepository {
  Class? _class;
  var _controller = StreamController<Class>();
  Stream<Class> get status {
    if (_controller.isClosed) _controller = StreamController<Class>();
    return _controller.stream;
  }

  Future<Class?> getTrainingClass(String accessToken, String id) async {
    if (_class != null) return _class;
    if (accessToken == "-") return null;
    final uriDesign =
        StandardUriDesign(Uri.parse("https://apiv2.bestcycling.es/api/v2/"));

    final client = RoutingClient(uriDesign);
    final response =
        await client.fetchResource('training_classes', id, headers: {
      HttpHeaders.userAgentHeader: "Flutter migration app",
      HttpHeaders.authorizationHeader: 'Bearer ' + accessToken,
      HttpHeaders.contentTypeHeader: 'application/vnd.api+json',
      'X-APP-ID': '1d665fac3ced84d799e615f5d5a2c1af'
    }, include: [
      "trainer"
    ]);

    if (!response.http.isFailed && response.http.hasDocument) {
      final resources = response.resource.attributes;
      resources["isNew"] = resources["is_new"] == 1;
      resources["hasBackground"] = resources["has_background"] == 1;
      resources["isNewBlack"] = resources["is_black"] == 1;
      resources["image_graph"] = resources["graph"];
      resources["need_progression"] = true;
      // resources["gender"] = "m";
      // resources["age"] = 39;
      // resources["weight"] = 72.0;
      resources["category"] = resources["category_nr"];
      Map<String, dynamic> trainers = {};
      response.included.toList().forEach((element) {
        trainers
            .addAll({element.id: element.attributes["full_name"].toString()});
        resources["trainer"] = element.attributes["full_name"].toString();
      });

      //List<Map<String, dynamic>> resourc = resources.toList();

      _controller.add(Class(resources, trainers));
      //response.resource.attributes
    } else {
      throw UnAuthenticated("No ha podido cargar las clases");
    }
  }

  void dispose() {
    _controller.close();
    _controller = StreamController<Class>();
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
