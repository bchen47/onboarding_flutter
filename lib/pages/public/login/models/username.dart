import 'package:formz/formz.dart';

enum UsernameValidationError { empty, email }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    if (value == null || value.isEmpty == true) {
      return UsernameValidationError.empty;
    } else if (!value.contains("@")) {
      return UsernameValidationError.email;
    }
    return null;
  }
}
