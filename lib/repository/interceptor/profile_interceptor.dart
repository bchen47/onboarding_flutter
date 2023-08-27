import 'package:dio/dio.dart';
import 'dart:convert';

//Interceptor para las peticiones del perfil
class ProfileInterceptor extends Interceptor {
  ProfileInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // create a list of the endpoints where you don't need to pass a token.
    final listOfPaths = <String>[
      'https://apiv2.bestcycling.es/api/v2/profile',
    ];

    // Check if the requested endpoint match in the
    if (listOfPaths.contains(options.path.toString())) {
      final customResponseData = {
        "access_token": "custom_access_token",
        "refresh_token": "custom_refresh_token",
        "expires_in": 3600,
        "token_type": "Bearer",
        "resistance_points": 100,
        "level": 5,
        "perseverance": 75,
        "points": 500,
        "force_points": 80,
        "flexibility_points": 90,
        "mind_points": 70,
      };

      final customResponse = Response<dynamic>(
        requestOptions: options,
        statusCode: 200,
        data: jsonEncode(customResponseData),
      );

      return handler.resolve(customResponse);
    }

    return handler.next(options);
  }

  // You can also perform some actions in the response or onError.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}
