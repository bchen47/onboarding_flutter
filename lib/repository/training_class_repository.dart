import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:prueba/models/training_class.dart';
import 'package:prueba/utils/constants.dart';
import 'package:prueba/utils/dio_singleton.dart';

class UnAuthenticated implements Exception {
  String cause;
  UnAuthenticated(this.cause);
}

//Clase que contiene las peticiones a la api en relación a las clases
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

    final response = await DioSingleton().dio.get(
          'https://apiv2.bestcycling.es/api/v2/training_class',
        );

    if (response.statusCode == 200) {
      final resources = jsonDecode(response.data)["attribute"];
      //parámetros para el reproductor
      resources["isNew"] = resources["is_new"] == 1;
      resources["hasBackground"] = resources["has_background"] == 1;
      resources["isNewBlack"] = resources["is_black"] == 1;
      //parámetros para la miniatura
      resources["image_graph"] = resources["graph"];
      resources["need_progression"] = true;
      resources["category"] = resources["category_nr"];
      Map<String, dynamic> trainers = {};
      jsonDecode(response.data)["trainers"].toList().forEach((element) {
        trainers.addAll({element["id"]: element["full_name"].toString()});
        resources["trainer"] = element["full_name"].toString();
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
