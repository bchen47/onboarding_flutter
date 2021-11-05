import 'dart:async';

class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (String email, sink) {
    if (email.contains('@') || email.isEmpty) {
      sink.add(email);
    } else {
      sink.addError("Email incorrecto");
    }
  });
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (String password, sink) {
    if (password.length > 3 || password.isEmpty) {
      sink.add(password);
    } else {
      sink.addError("Contraseña muy corta");
    }
  });
}
