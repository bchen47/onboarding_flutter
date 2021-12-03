import 'dart:async';
import 'dart:io';
import 'package:json_api/client.dart';
import 'package:json_api/routing.dart';
import 'package:prueba/models/recipes.dart';
import 'package:prueba/utils/constants.dart';

class UnAuthenticated implements Exception {
  String cause;
  UnAuthenticated(this.cause);
}

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
    final uriDesign = StandardUriDesign(Uri.parse(apiUrl));

    final client = RoutingClient(uriDesign);
    final response =
        await client.fetchCollection('nutrition_recipes', headers: {
      HttpHeaders.userAgentHeader: userAgent,
      HttpHeaders.authorizationHeader: 'Bearer ' + accessToken,
      HttpHeaders.contentTypeHeader: contentType,
      'X-APP-ID': appID
    }, filter: {
      category: "true"
    });

    if (!response.http.isFailed && response.http.hasDocument) {
      final resources = response.collection;

      List<Map<String, dynamic>> recipes = [];

      resources.toList().forEach((element) {
        var recipe = element.attributes;
        recipe.addAll({"id": element.id});
        recipes.add(recipe);
      });

      _controller.add(Recipes(recipes));
      //response.resource.attributes
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
