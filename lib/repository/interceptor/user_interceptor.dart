import 'package:dio/dio.dart';
import 'dart:convert';

//Interceptor para las peticiones en relación a datos del usuario
class UserInterceptor extends Interceptor {
  UserInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // create a list of the endpoints where you don't need to pass a token.
    final listOfPaths = <String>[
      'https://apiv2.bestcycling.es/api/v2/user',
    ];

    // Check if the requested endpoint match in the
    if (listOfPaths.contains(options.path.toString())) {
      final customResponseData = {
        "avatar_url": "https://cdn-icons-png.flaticon.com/256/1025/1025346.png"
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
