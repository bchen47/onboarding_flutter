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

  static Future<String?> readSession(String parameter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(parameter);
  }

  static Future<Token> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return Token(
        prefs.getString("access_token").toString(),
        prefs.getString("refresh_token").toString(),
        prefs.getString("expires_in").toString(),
        prefs.getString("token_type").toString());
  }

  static void clearSession() async {
    SharedPreferences.getInstance()
        .then((SharedPreferences value) => value.clear());
  }
}
