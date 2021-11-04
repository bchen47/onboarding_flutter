//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// © Cosmos Software | Ali Yigit Bireroglu                                                                                                           /
// All material used in the making of this code, project, program, application, software et cetera (the "Intellectual Property")                     /
// belongs completely and solely to Ali Yigit Bireroglu. This includes but is not limited to the source code, the multimedia and                     /
// other asset files. If you were granted this Intellectual Property for personal use, you are obligated to include this copyright                   /
// text at all times.                                                                                                                                /
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//@formatter:off

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prueba/login/login.dart';
import 'package:prueba/login/welcome.dart';
import 'package:prueba/login/register_options.dart';
import 'splash/splash.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Sequence Animator Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.black),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/welcome': (context) => const WelcomePage(),
        '/registerOptions': (context) => const RegisterOptions(),
        '/login': (context) => const LoginPage()
      },
    );
  }
}
