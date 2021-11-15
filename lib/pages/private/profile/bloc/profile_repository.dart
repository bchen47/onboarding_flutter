import 'dart:async';
import 'dart:io';
import 'package:json_api/client.dart';
import 'package:json_api/routing.dart';
import 'package:prueba/pages/private/profile/models/profile.dart';

class UnAuthenticated implements Exception {
  String cause;
  UnAuthenticated(this.cause);
}

class ProfileRepository {
  Profile? _profile;
  final _controller = StreamController<Profile>();
  Stream<Profile> get status {
    return _controller.stream;
  }

  Future<Profile?> getProfile(String accessToken) async {
    if (_profile != null) return _profile;
    final uriDesign =
        StandardUriDesign(Uri.parse("https://apiv2.bestcycling.es/api/v2/"));
    final client = RoutingClient(uriDesign);
    ResourceFetched response =
        await client.fetchResource('profile', '', headers: {
      HttpHeaders.userAgentHeader: "Flutter migration app",
      HttpHeaders.authorizationHeader: 'Bearer ' + accessToken,
      HttpHeaders.contentTypeHeader: 'application/vnd.api+json',
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
  }

  static Map<String, String> get headers {
    return {
      HttpHeaders.contentTypeHeader: 'application/vnd.api+json',
      HttpHeaders.userAgentHeader: "Flutter migration app",
      HttpHeaders.authorizationHeader:
          'X-APP-ID: 1d665fac3ced84d799e615f5d5a2c1af'
    };
  }
}
