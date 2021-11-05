import 'dart:async';

import 'package:prueba/src/bloc/validators.dart';

class Bloc extends Validators {
  final _email = StreamController<String>();
  final _password = StreamController<String>();

// Add data to stream
  get changeEmail => _email.sink.add;
  get changePassword => _password.sink.add;

  // Retrieve data from stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  dispose() {
    _email.close();
    _password.close();
  }
}

final bloc = Bloc();
