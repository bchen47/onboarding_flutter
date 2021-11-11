import 'dart:async';
import 'dart:io';
import 'package:json_api/client.dart';
import 'package:json_api/routing.dart';
import 'package:prueba/src/models/user.dart';

class UnAuthenticated implements Exception {
  String cause;
  UnAuthenticated(this.cause);
}

class UserRepository {
  User? _user;
  final _controller = StreamController<User>();

  Future<User?> getUser(String accessToken) async {
    if (_user != null) return _user;
    final uriDesign =
        StandardUriDesign(Uri.parse("https://apiv2.bestcycling.es/api/v2/"));
    final client = RoutingClient(uriDesign);
    ResourceFetched response = await client.fetchResource('user', '', headers: {
      HttpHeaders.userAgentHeader: "Flutter migration app",
      HttpHeaders.authorizationHeader: 'Bearer ' + accessToken,
      HttpHeaders.contentTypeHeader: 'application/vnd.api+json',
      'X-APP-ID': '1d665fac3ced84d799e615f5d5a2c1af'
    });
    // _controller.add(AuthenticationStatusLogin(
    //       status: AuthenticationStatus.authenticated,
    //       token: Token(
    //           jsonDecode(response.body)["access_token"],
    //           jsonDecode(response.body)["refresh_token"],
    //           jsonDecode(response.body)["expires_in"].toString(),
    //           jsonDecode(response.body)["token_type"])));
    print(response.http);
  }

  static Map<String, String> get headers {
    return {
      HttpHeaders.contentTypeHeader: 'application/vnd.api+json',
      HttpHeaders.userAgentHeader: "Flutter migration app",
      HttpHeaders.authorizationHeader:
          'X-APP-ID: 1d665fac3ced84d799e615f5d5a2c1af'
    };
  }

  static Future<void> register(
      {required String username,
      required String password,
      required String email}) async {
    final uriDesign =
        StandardUriDesign(Uri.parse("https://apiv2.bestcycling.es/api/v2/"));
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
