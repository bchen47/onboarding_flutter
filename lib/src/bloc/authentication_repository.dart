import 'dart:async';
import 'package:http/http.dart' as http;

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationStatusLogin {
  AuthenticationStatus status;
  String token;
  AuthenticationStatusLogin(
      {this.status = AuthenticationStatus.unknown, this.token = ""});
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
    var url = Uri.parse('https://bestcycling.com/oauth/token');
    var response = await http.post(url, body: {
      'grant_type': 'password',
      'client_id': '1d665fac3ced84d799e615f5d5a2c1af',
      'username': username,
      'password': password
    });
    _controller.add(AuthenticationStatusLogin(
        status: AuthenticationStatus.authenticated, token: response.body));
  }

  void logOut() {
    _controller.add(AuthenticationStatusLogin(
        status: AuthenticationStatus.unauthenticated));
  }

  void dispose() => _controller.close();
}
