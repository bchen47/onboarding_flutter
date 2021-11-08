import 'dart:async';
import 'package:http/http.dart' as http;

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    print(username);
    print(password);
    var url = Uri.parse('https://bestcycling.com/oauth/token');
    var response = await http.post(url, body: {
      'grant_type': 'password',
      'client_id': '1d665fac3ced84d799e615f5d5a2c1af',
      'username': username,
      'password': password
    });
    print(response.statusCode);
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
