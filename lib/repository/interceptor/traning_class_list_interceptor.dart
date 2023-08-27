import 'package:dio/dio.dart';
import 'dart:convert';

//Interceptor para las peticiones del listado de clases
class TrainingClassListInterceptor extends Interceptor {
  TrainingClassListInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // create a list of the endpoints where you don't need to pass a token.
    final listOfPaths = <String>[
      'https://apiv2.bestcycling.es/api/v2/training_classes',
    ];

    // Check if the requested endpoint match in the
    if (listOfPaths.contains(options.path.toString())) {
      final customResponseData = {
        "attribute": [
          {
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
                "https://cdn0.bestcycling.es/image_covers/images/000/464/135/l.png?1679474333",
          },
          {
            "id": 2,
            "level_nr": 2,
            "duration_seconds": 2400,
            "training_type": "Strength",
            "title": "Full-Body Strength Workout",
            "trainer_id": "TRN456",
            "life_force_points": 40,
            "life_resistance_points": 30,
            "published_at_timestamp": 1693000800000,
            "cover":
                "https://cdn0.bestcycling.es/image_covers/images/000/458/758/l.png?1676972335"
          },
          {
            "id": 3,
            "level_nr": 3,
            "duration_seconds": 1500,
            "training_type": "Yoga",
            "title": "Beginner's Yoga Flow",
            "trainer_id": "TRN789",
            "life_force_points": 30,
            "life_resistance_points": 40,
            "published_at_timestamp": 1693000800000,
            "cover":
                "https://cdn0.bestcycling.es/image_covers/images/000/461/294/l.jpg?1678179934"
          },
          // Add more training classes here
        ],
        "trainers": [
          {'id': 'TRN123', 'full_name': 'Alice Trainer'},
          {'id': 'TRN456', 'full_name': 'Bob Trainer'},
          {'id': 'TRN789', 'full_name': 'Charlie Trainer'},
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
