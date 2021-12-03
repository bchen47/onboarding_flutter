import 'dart:async';
import 'dart:io';
import 'package:json_api/client.dart';
import 'package:json_api/routing.dart';
import 'package:prueba/models/profile.dart';
import 'package:prueba/utils/constants.dart';

class UnAuthenticated implements Exception {
  String cause;
  UnAuthenticated(this.cause);
}

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
    final uriDesign = StandardUriDesign(Uri.parse(apiUrl));
    final client = RoutingClient(uriDesign);
    ResourceFetched response =
        await client.fetchResource('profile', '', headers: {
      HttpHeaders.userAgentHeader: userAgent,
      HttpHeaders.authorizationHeader: 'Bearer ' + accessToken,
      HttpHeaders.contentTypeHeader: contentType,
      'X-APP-ID': '1d665fac3ced84d799e615f5d5a2c1af'
    });
    if (!response.http.isFailed && response.http.hasDocument) {
      _controller.add(Profile(response.resource.attributes));
      //response.resource.attributes
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
