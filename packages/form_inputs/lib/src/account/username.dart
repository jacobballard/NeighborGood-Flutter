import 'package:formz/formz.dart';

enum UsernameValidationError {
  invalid,
  tooShort,
  tooLong,
}

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  static final RegExp _usernameRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
  static const int _minLength = 3;
  static const int _maxLength = 15;

  @override
  UsernameValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return UsernameValidationError.invalid;
    }
    if (value.length < _minLength) {
      return UsernameValidationError.tooShort;
    }
    if (value.length > _maxLength) {
      return UsernameValidationError.tooLong;
    }
    return _usernameRegExp.hasMatch(value)
        ? null
        : UsernameValidationError.invalid;
  }
}
