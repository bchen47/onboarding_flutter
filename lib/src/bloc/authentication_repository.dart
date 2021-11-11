import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba/src/models/token.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class UnAuthenticated implements Exception {
  String cause;
  UnAuthenticated(this.cause);
}

class AuthenticationStatusLogin {
  AuthenticationStatus status;
  Token token;
  AuthenticationStatusLogin(
      {this.status = AuthenticationStatus.unknown, this.token = Token.empty});
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatusLogin>();

  Stream<AuthenticationStatusLogin> get status {
    return _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    // final baseUri = 'https://apiv2.bestcycling.es/';

    // /// Use the standard recommended URL structure or implement your own
    // final uriDesign = StandardUriDesign(Uri.parse(baseUri));

    // /// The [RoutingClient] is most likely the right choice.
    // /// It has methods covering many standard use cases.
    // final client = RoutingClient(uriDesign);

    // try {
    //   /// Fetch the collection.
    //   /// See other methods to query and manipulate resources.
    //   final response = await client.createNew('oauth/token', attributes: {
    //     'grant_type': 'password',
    //     'client_id': '1d665fac3ced84d799e615f5d5a2c1af',
    //     'username': username,
    //     'password': password
    //   });
    //   print(response.http.statusCode);
    //   if (response.http.statusCode == 200) {
    //     _controller.add(AuthenticationStatusLogin(
    //         status: AuthenticationStatus.authenticated,
    //         token: Token(
    //             jsonDecode(response.http.body)["access_token"],
    //             jsonDecode(response.http.body)["refresh_token"],
    //             jsonDecode(response.http.body)["expires_in"],
    //             jsonDecode(response.http.body)["token_type"])));
    //   } else {
    //     throw UnAuthenticated("Error con el login");
    //   }
    // } on RequestFailure catch (_) {
    //   throw UnAuthenticated("Error con el login");
    // }
    var url = Uri.parse('https://apiv2.bestcycling.es/oauth/token');
    var response = await http.post(url, body: {
      'grant_type': 'password',
      'client_id': '1d665fac3ced84d799e615f5d5a2c1af',
      'username': username,
      'password': password
    });
    if (response.statusCode == 200) {
      _controller.add(AuthenticationStatusLogin(
          status: AuthenticationStatus.authenticated,
          token: Token(
              jsonDecode(response.body)["access_token"],
              jsonDecode(response.body)["refresh_token"],
              jsonDecode(response.body)["expires_in"].toString(),
              jsonDecode(response.body)["token_type"])));
    } else {
      throw UnAuthenticated("Error con el login");
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatusLogin(
        status: AuthenticationStatus.unauthenticated));
  }

  void dispose() => _controller.close();
}
