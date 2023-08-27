import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:prueba/models/profile.dart';
import 'package:prueba/utils/constants.dart';
import 'package:prueba/utils/dio_singleton.dart';

class UnAuthenticated implements Exception {
  String cause;
  UnAuthenticated(this.cause);
}

//Clase que contiene las peticiones respecto al perfil
class ProfileRepository {
  Profile? _profile;
  var _controller = StreamController<Profile>();
  Stream<Profile> get status {
    if (_controller.isClosed) _controller = StreamController<Profile>();
    return _controller.stream;
  }

  Future<Profile?> getProfile(String accessToken) async {
    if (_profile != null) return _profile;
    if (accessToken == "-") return null;
    final response = await DioSingleton().dio.get(
          'https://apiv2.bestcycling.es/api/v2/profile',
        );
    if (response.statusCode == 200) {
      _controller.add(Profile(json.decode(response.data)));
    } else {
      throw UnAuthenticated("No ha podido cargar el perfil");
    }
  }

  void dispose() {
    _controller.close();
    _controller = StreamController<Profile>();
  }

  static Map<String, String> get headers {
    return {
      HttpHeaders.contentTypeHeader: contentType,
      HttpHeaders.userAgentHeader: userAgent,
      HttpHeaders.authorizationHeader: 'X-APP-ID: ' + appID
    };
  }
}
