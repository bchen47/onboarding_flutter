import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:json_api/client.dart';
import 'package:json_api/routing.dart';
import 'package:prueba/models/user.dart';
import 'package:prueba/utils/constants.dart';
import 'package:prueba/utils/dio_singleton.dart';

class UnAuthenticated implements Exception {
  String cause;
  UnAuthenticated(this.cause);
}

class UserRepository {
  User? _user;
  final _controller = StreamController<User>();
  Stream<User> get status {
    return _controller.stream;
  }

  void logOut() {
    _controller.add(User(User.empty.attributes));
  }

  Future<User?> getUser(String accessToken) async {
    if (_user != null) return _user;
    if (accessToken == '-') return null;
    final response = await DioSingleton().dio.get(
      'https://apiv2.bestcycling.es/api/v2/user',
    );
    if (response.statusCode == 200) {
      _controller.add(User(json.decode(response.data)));
    } else {
      throw UnAuthenticated("No ha podido cargar el usuario");
    }
  }

  static Map<String, String> get headers {
    return {
      HttpHeaders.contentTypeHeader: contentType,
      HttpHeaders.userAgentHeader: userAgent,
      HttpHeaders.authorizationHeader: 'X-APP-ID:' + appID
    };
  }

  static Future<void> register(
      {required String username,
      required String password,
      required String email}) async {
    final uriDesign = StandardUriDesign(Uri.parse(apiUrl));
    final client = RoutingClient(uriDesign);
    var response =
        await client.createNew("user", headers: headers, attributes: {
      "login": email,
      "full_name": username,
      "password": password,
      "password_confirmation": password,
      "accept_terms_of_service": true,
      "birthday": "2000-01-01",
      "gdpr": true,
      "opted_in": true,
      "sex": "m"
    });
    if (response.http.statusCode != 200) {
      throw UnAuthenticated("Error con el registro");
    }
  }

  void dispose() => _controller.close();
}
