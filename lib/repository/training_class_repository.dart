import 'dart:async';
import 'dart:io';
import 'package:json_api/client.dart';
import 'package:json_api/routing.dart';
import 'package:prueba/models/training_class.dart';
import 'package:prueba/utils/constants.dart';

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

  Future<TrainingClass?> getTrainingClass(String accessToken, String id) async {
    if (_class != null) return _class;
    if (accessToken == "-") return null;
    final uriDesign = StandardUriDesign(Uri.parse(apiUrl));

    final client = RoutingClient(uriDesign);
    final response =
        await client.fetchResource('training_classes', id, headers: {
      HttpHeaders.userAgentHeader: userAgent,
      HttpHeaders.authorizationHeader: 'Bearer ' + accessToken,
      HttpHeaders.contentTypeHeader: contentType,
      'X-APP-ID': appID
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
      resources["category"] = resources["category_nr"];
      Map<String, dynamic> trainers = {};
      response.included.toList().forEach((element) {
        trainers
            .addAll({element.id: element.attributes["full_name"].toString()});
        resources["trainer"] = element.attributes["full_name"].toString();
      });
      _controller.add(TrainingClass(resources, trainers));
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
      HttpHeaders.contentTypeHeader: contentType,
      HttpHeaders.userAgentHeader: userAgent,
      HttpHeaders.authorizationHeader: 'X-APP-ID:' + appID
    };
  }
}
