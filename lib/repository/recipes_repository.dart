import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:prueba/models/recipes.dart';
import 'package:prueba/utils/constants.dart';
import 'package:prueba/utils/dio_singleton.dart';

class UnAuthenticated implements Exception {
  String cause;
  UnAuthenticated(this.cause);
}

//Clase que contiene las peticiones a la api en relación al listado de recetas
class RecipesRepository {
  Recipes? _class;
  var _controller = StreamController<Recipes>();
  Stream<Recipes> get status {
    if (_controller.isClosed) _controller = StreamController<Recipes>();
    return _controller.stream;
  }

  Future<Recipes?> getRecipes(String accessToken, String category) async {
    if (_class != null) return _class;
    if (accessToken == "-") return null;
    final response = await DioSingleton().dio.get(
          'https://apiv2.bestcycling.es/api/v2/nutrition_recipes',
        );
    if (response.statusCode == 200) {
      final resources = jsonDecode(response.data);

      List<Map<String, dynamic>> recipes = [];

      resources.toList().forEach((element) {
        var recipe = element;
        recipe.addAll({"id": element["id"]});
        recipes.add(recipe);
      });

      _controller.add(Recipes(recipes));
    } else {
      throw UnAuthenticated("No ha podido cargar las clases");
    }
  }

  void dispose() {
    _controller.close();
    _controller = StreamController<Recipes>();
  }

  static Map<String, String> get headers {
    return {
      HttpHeaders.contentTypeHeader: contentType,
      HttpHeaders.userAgentHeader: userAgent,
      HttpHeaders.authorizationHeader: 'X-APP-ID: ' + appID
    };
  }
}
