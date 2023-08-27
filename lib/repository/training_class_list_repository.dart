import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:prueba/models/training_list_class.dart';
import 'package:prueba/utils/constants.dart';
import 'package:prueba/utils/dio_singleton.dart';

class UnAuthenticated implements Exception {
  String cause;
  UnAuthenticated(this.cause);
}

//Clase que contiene las peticiones a la api en relación al listado de clases
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
    final response = await DioSingleton().dio.get(
          'https://apiv2.bestcycling.es/api/v2/training_classes',
        );
    if (response.statusCode == 200) {
      final resources = response.data;

      List<Map<String, dynamic>> clases = [];
      Map<String, dynamic> trainers = {};

      jsonDecode(resources)["attribute"].toList().forEach((trainingClass) {
        trainingClass.addAll({"id": trainingClass["id"]});
        clases.add(trainingClass);
      });
      jsonDecode(resources)["trainers"].toList().forEach((element) {
        trainers.addAll({element["id"]: element["full_name"].toString()});
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
