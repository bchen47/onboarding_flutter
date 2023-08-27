import 'package:dio/dio.dart';
import 'package:prueba/repository/interceptor/auth_interceptor.dart';
import 'package:prueba/repository/interceptor/profile_interceptor.dart';
import 'package:prueba/repository/interceptor/recipe_interceptor.dart';
import 'package:prueba/repository/interceptor/recipe_list_interceptor.dart';
import 'package:prueba/repository/interceptor/training_class_interceptor.dart';
import 'package:prueba/repository/interceptor/traning_class_list_interceptor.dart';
import 'package:prueba/repository/interceptor/user_interceptor.dart';

// Webclient para realizar peticiones a la cuál interceptaremos los paquetes para mockearlo

class DioSingleton {
  static final DioSingleton _singleton = DioSingleton._internal();

  factory DioSingleton() {
    return _singleton;
  }

  late Dio _dio;

  DioSingleton._internal() {
    _dio = Dio();
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(ProfileInterceptor());
    _dio.interceptors.add(UserInterceptor());
    _dio.interceptors.add(TrainingClassListInterceptor());
    _dio.interceptors.add(TrainingClassInterceptor());
    _dio.interceptors.add(RecipeListInterceptor());
    _dio.interceptors.add(RecipeInterceptor());
  }

  Dio get dio => _dio;
}
