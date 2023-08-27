import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:prueba/models/recipe.dart';
import 'package:prueba/utils/constants.dart';
import 'package:prueba/utils/dio_singleton.dart';

class UnAuthenticated implements Exception {
  String cause;
  UnAuthenticated(this.cause);
}

class RecipeRepository {
  Recipe? _recipe;
  var _controller = StreamController<Recipe>();
  Stream<Recipe> get status {
    if (_controller.isClosed) _controller = StreamController<Recipe>();
    return _controller.stream;
  }

  Future<Recipe?> getRecipe(String accessToken, String id) async {
    if (_recipe != null) return _recipe;
    if (accessToken == "-") return null;

    final response = await DioSingleton().dio.get(
          'https://apiv2.bestcycling.es/api/v2/nutrition_recipe',
        );
    if (response.statusCode == 200) {
      final resources = jsonDecode(response.data)["attribute"];

      Map<String, dynamic> author = {};

      jsonDecode(response.data)["authors"].toList().forEach((element) {
        author.addAll({element["id"]: element["full_name"].toString()});
      });

      _controller.add(Recipe(resources, author));
    } else {
      throw UnAuthenticated("No ha podido cargar las clases");
    }
  }

  void dispose() {
    _controller.close();
    _controller = StreamController<Recipe>();
  }

  static Map<String, String> get headers {
    return {
      HttpHeaders.contentTypeHeader: contentType,
      HttpHeaders.userAgentHeader: userAgent,
      HttpHeaders.authorizationHeader: 'X-APP-ID: ' + appID
    };
  }
}
