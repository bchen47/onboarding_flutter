import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba/models/session.dart';
import 'package:prueba/models/token.dart';

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
    var url = Uri.parse('https://apiv2.bestcycling.es/oauth/token');
    var response = await http.post(url, body: {
      'grant_type': 'password',
      'client_id': '1d665fac3ced84d799e615f5d5a2c1af',
      'username': username,
      'password': password
    });
    if (response.statusCode == 200) {
      Session.saveSession(Token(
          jsonDecode(response.body)["access_token"],
          jsonDecode(response.body)["refresh_token"],
          jsonDecode(response.body)["expires_in"].toString(),
          jsonDecode(response.body)["token_type"]));
      _controller.add(AuthenticationStatusLogin(
        status: AuthenticationStatus.authenticated,
      ));
    } else {
      throw UnAuthenticated("Error con el login");
    }
  }

  void logOut() {
    Session.clearSession();
    _controller.add(AuthenticationStatusLogin(
        status: AuthenticationStatus.unauthenticated));
  }

  Future<void> checkAutenticated() async {
    var accessToken = await Session.readSession("access_token");
    if (accessToken != null) {
      var token = await Session.readToken();
      Session.saveSession(token);
      _controller.add(AuthenticationStatusLogin(
          status: AuthenticationStatus.authenticated, token: token));
    } else {
      _controller.add(AuthenticationStatusLogin(
          status: AuthenticationStatus.unauthenticated));
    }
  }

  void dispose() => _controller.close();
}
