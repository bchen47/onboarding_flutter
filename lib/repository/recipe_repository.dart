import 'dart:async';
import 'dart:io';
import 'package:json_api/client.dart';
import 'package:json_api/routing.dart';
import 'package:prueba/models/recipe.dart';
import 'package:prueba/utils/constants.dart';

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
    final uriDesign = StandardUriDesign(Uri.parse(apiUrl));

    final client = RoutingClient(uriDesign);
    final response =
        await client.fetchResource('nutrition_recipes', id, headers: {
      HttpHeaders.userAgentHeader: userAgent,
      HttpHeaders.authorizationHeader: 'Bearer ' + accessToken,
      HttpHeaders.contentTypeHeader: contentType,
      'X-APP-ID': appID
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
      HttpHeaders.contentTypeHeader: contentType,
      HttpHeaders.userAgentHeader: userAgent,
      HttpHeaders.authorizationHeader: 'X-APP-ID: ' + appID
    };
  }
}
