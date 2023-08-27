import 'package:dio/dio.dart';
import 'dart:convert';

//Interceptor para las peticiones del listado de recetas
class RecipeListInterceptor extends Interceptor {
  RecipeListInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // create a list of the endpoints where you don't need to pass a token.
    final listOfPaths = <String>[
      'https://apiv2.bestcycling.es/api/v2/nutrition_recipes',
    ];

    // Check if the requested endpoint match in the
    if (listOfPaths.contains(options.path.toString())) {
      final customResponseData = [
        {
          "id": 1,
          "name": "Ensaladilla ibérica",
          "image":
              "https://cdn0.bestcycling.es/nutrition/recipes/nutrition/recipe/1422/l.jpg?1690356771",
          "minutes_time": 25,
          "difficulty_name": "Intermedio",
          "nutrients": [
            {"name": "Calorías", "value": 350.0, "unit": "kcal"},
            {"name": "Proteína", "value": 15.0, "unit": "g"},
            {"name": "Carbohidratos", "value": 50.0, "unit": "g"},
            {"name": "Grasa", "value": 10.0, "unit": "g"}
          ]
        },
        {
          "id": 2,
          "name": "Tartar de atún con piña",
          "image":
              "https://cdn0.bestcycling.es/nutrition/recipes/nutrition/recipe/1431/l.jpg?1691128708",
          "minutes_time": 40,
          "difficulty_name": "Fácil",
          "nutrients": [
            {"name": "Calorías", "value": 250.0, "unit": "kcal"},
            {"name": "Proteína", "value": 20.0, "unit": "g"},
            {"name": "Carbohidratos", "value": 30.0, "unit": "g"},
            {"name": "Grasa", "value": 8.0, "unit": "g"}
          ]
        },
        {
          "id": 3,
          "name": "Bol de arroz, salmón y calabacín",
          "image":
              "https://cdn0.bestcycling.es/nutrition/recipes/nutrition/recipe/1421/l.jpg?1690354586",
          "minutes_time": 10,
          "difficulty_name": "Principiante",
          "nutrients": [
            {"name": "Calorías", "value": 180.0, "unit": "kcal"},
            {"name": "Proteína", "value": 5.0, "unit": "g"},
            {"name": "Carbohidratos", "value": 40.0, "unit": "g"},
            {"name": "Grasa", "value": 2.0, "unit": "g"}
          ]
        }
      ];

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
