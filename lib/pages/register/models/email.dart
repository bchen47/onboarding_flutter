import 'package:formz/formz.dart';

enum EmailValidationError { empty, email }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String? value) {
    if (value == null || value.isEmpty == true) {
      return EmailValidationError.empty;
    } else if (!value.contains("@")) {
      return EmailValidationError.email;
    }
    return null;
  }
}
