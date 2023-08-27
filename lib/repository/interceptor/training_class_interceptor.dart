import 'package:dio/dio.dart';
import 'dart:convert';

//Interceptor para las peticiones una clase
class TrainingClassInterceptor extends Interceptor {
  TrainingClassInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // create a list of the endpoints where you don't need to pass a token.
    final listOfPaths = <String>[
      'https://apiv2.bestcycling.es/api/v2/training_class',
    ];

    // Check if the requested endpoint match in the
    if (listOfPaths.contains(options.path.toString())) {
      final customResponseData = {
        "attribute": {
          "id": 1,
          "level_nr": 1,
          "duration_seconds": 1800,
          "training_type": "Cardio",
          "title": "High-Intensity Interval Training",
          "trainer_id": "TRN123",
          "life_force_points": 50,
          "life_resistance_points": 20,
          "published_at_timestamp": 1693000800000,
          "cover":
              "https://cdn0.bestcycling.es/image_covers/images/000/458/758/l.png?1676972335",
          "has_background": 1,
          "category_nr": 1,
          "graph":
              "https://cdn0.bestcycling.es/image_covers/images/000/458/756/l.png?1676972049",
          "content":
              "La rutina de entrenamiento conocida como High-Intensity Interval Training (HIIT) o Entrenamiento Intervalado de Alta Intensidad es una forma efectiva y dinámica de ejercicio cardiovascular. En esta modalidad, se alternan breves períodos de ejercicio extremadamente intenso con períodos de recuperación activa o descanso ligero. El objetivo principal del HIIT es elevar significativamente la frecuencia cardíaca durante los intervalos de alta intensidad, lo que conduce a una quema eficiente de calorías y a la mejora de la condición cardiovascular."
        },
        "trainers": [
          {'id': 'TRN123', 'full_name': 'Charlie Trainer'},
        ]
      };

      final customResponse = Response<dynamic>(
        requestOptions: options,
        statusCode: 200,
        data: jsonEncode(customResponseData),
      );

      return handler.resolve(customResponse);
    }

    return handler.next(options);
  }

  // You can also perform some actions in the response or onError.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}
