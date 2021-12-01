import 'dart:async';
import 'dart:io';
import 'package:json_api/client.dart';
import 'package:json_api/routing.dart';
import 'package:prueba/models/recipe/recipe.dart';

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
    final uriDesign =
        StandardUriDesign(Uri.parse("https://apiv2.bestcycling.es/api/v2/"));

    final client = RoutingClient(uriDesign);
    final response =
        await client.fetchResource('nutrition_recipes', id, headers: {
      HttpHeaders.userAgentHeader: "Flutter migration app",
      HttpHeaders.authorizationHeader: 'Bearer ' + accessToken,
      HttpHeaders.contentTypeHeader: 'application/vnd.api+json',
      'X-APP-ID': '1d665fac3ced84d799e615f5d5a2c1af'
    }, include: [
      "author"
    ]);

    if (!response.http.isFailed && response.http.hasDocument) {
      final resources = response.resource.attributes;

      Map<String, dynamic> author = {};

      response.included.toList().forEach((element) {
        author.addAll({element.id: element.attributes["full_name"].toString()});
      });
      //List<Map<String, dynamic>> resourc = resources.toList();

      _controller.add(Recipe(resources, author));
      //response.resource.attributes
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
      HttpHeaders.contentTypeHeader: 'application/vnd.api+json',
      HttpHeaders.userAgentHeader: "Flutter migration app",
      HttpHeaders.authorizationHeader:
          'X-APP-ID: 1d665fac3ced84d799e615f5d5a2c1af'
    };
  }
}
