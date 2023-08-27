import 'dart:async';
import 'dart:convert';
import 'package:prueba/models/session.dart';
import 'package:prueba/models/token.dart';
import 'package:prueba/utils/dio_singleton.dart';

//Enumeradores con el estado de las autenticaciones
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

//Clase que en caso de que falle la autenticación salta esta excepción
class UnAuthenticated implements Exception {
  String cause;
  UnAuthenticated(this.cause);
}

//Clase que contiene el estado del login
class AuthenticationStatusLogin {
  AuthenticationStatus status;
  Token token;
  AuthenticationStatusLogin(
      {this.status = AuthenticationStatus.unknown, this.token = Token.empty});
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatusLogin>();
  final dio = DioSingleton().dio; // Create a Dio instance

  Stream<AuthenticationStatusLogin> get status {
    return _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    var url = Uri.parse('https://apiv2.bestcycling.es/oauth/token');
    var response = await dio.post(
      url.toString(),
      data: {
        'grant_type': 'password',
        'client_id': '1d665fac3ced84d799e615f5d5a2c1af',
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      Session.saveSession(Token(
          jsonDecode(response.data)["access_token"],
          jsonDecode(response.data)["refresh_token"],
          jsonDecode(response.data)["expires_in"].toString(),
          jsonDecode(response.data)["token_type"]));
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
