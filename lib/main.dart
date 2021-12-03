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
import 'package:prueba/application.dart';
import 'package:prueba/repository/authentication_repository.dart';
import 'package:prueba/repository/user_repository.dart';

void main() => runApp(Application(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
    ));
