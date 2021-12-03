import 'package:prueba/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static void saveSession(Token token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_token", token.accessToken);
    prefs.setString("refresh_token", token.refreshToken);
    prefs.setString("expires_in", token.expiresIn);
    prefs.setString("token_type", token.tokenType);
  }

  static void clearSession() async {
    SharedPreferences.getInstance()
        .then((SharedPreferences value) => value.clear());
  }
}
