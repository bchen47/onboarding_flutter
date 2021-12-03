import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prueba/application.dart';
import 'package:prueba/repository/authentication_repository.dart';
import 'package:prueba/repository/user_repository.dart';

void main() => runApp(Application(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
    ));
