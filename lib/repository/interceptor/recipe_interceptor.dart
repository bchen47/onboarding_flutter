import 'package:dio/dio.dart';
import 'dart:convert';

//Interceptor para las peticiones de las recetas
class RecipeInterceptor extends Interceptor {
  RecipeInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // create a list of the endpoints where you don't need to pass a token.
    final listOfPaths = <String>[
      'https://apiv2.bestcycling.es/api/v2/nutrition_recipe',
    ];

    // Check if the requested endpoint match in the
    if (listOfPaths.contains(options.path.toString())) {
      final customResponseData = {
        "attribute": {
          "id": 1,
          "name": "Ensaladilla ibérica",
          "image":
              "https://cdn0.bestcycling.es/nutrition/recipes/nutrition/recipe/1422/l.jpg?1690356771",
          "minutes_time": 25,
          "difficulty_name": "Intermedio",
          "categories": [
            {"name": "Plato Principal"},
            {"name": "Rápido de hacer"}
          ],
          "nutrients": [
            {"name": "Calorías", "value": 350.0, "unit": "kcal"},
            {"name": "Proteína", "value": 15.0, "unit": "g"},
            {"name": "Carbohidratos", "value": 50.0, "unit": "g"},
            {"name": "Grasa", "value": 10.0, "unit": "g"}
          ]
        },
        "authors": [
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
