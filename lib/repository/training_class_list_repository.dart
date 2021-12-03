import 'dart:async';
import 'dart:io';
import 'package:json_api/client.dart';
import 'package:json_api/routing.dart';
import 'package:prueba/models/training_list_class.dart';
import 'package:prueba/utils/constants.dart';

class UnAuthenticated implements Exception {
  String cause;
  UnAuthenticated(this.cause);
}

class TrainingClassListRepository {
  TrainingListClass? _class;
  var _controller = StreamController<TrainingListClass>();
  Stream<TrainingListClass> get status {
    if (_controller.isClosed) {
      _controller = StreamController<TrainingListClass>();
    }
    return _controller.stream;
  }

  Future<TrainingListClass?> getClass(
      String accessToken, String category) async {
    if (_class != null) return _class;
    if (accessToken == "-") return null;
    final uriDesign = StandardUriDesign(Uri.parse(apiUrl));

    final client = RoutingClient(uriDesign);
    final response = await client.fetchCollection('training_classes', headers: {
      HttpHeaders.userAgentHeader: userAgent,
      HttpHeaders.authorizationHeader: 'Bearer ' + accessToken,
      HttpHeaders.contentTypeHeader: contentType,
      'X-APP-ID': appID
    }, filter: {
      "category_nr": category
    }, include: [
      "trainer"
    ]);

    if (!response.http.isFailed && response.http.hasDocument) {
      final resources = response.collection;

      List<Map<String, dynamic>> clases = [];
      Map<String, dynamic> trainers = {};

      resources.toList().forEach((element) {
        var trainingClass = element.attributes;
        trainingClass.addAll({"id": element.id});
        clases.add(trainingClass);
      });
      response.included.toList().forEach((element) {
        trainers
            .addAll({element.id: element.attributes["full_name"].toString()});
      });

      _controller.add(TrainingListClass(clases, trainers));
    } else {
      throw UnAuthenticated("No ha podido cargar las clases");
    }
  }

  void dispose() {
    _controller.close();
    _controller = StreamController<TrainingListClass>();
  }

  static Map<String, String> get headers {
    return {
      HttpHeaders.contentTypeHeader: contentType,
      HttpHeaders.userAgentHeader: userAgent,
      HttpHeaders.authorizationHeader: 'X-APP-ID: ' + appID
    };
  }
}
