import 'package:formz/formz.dart';

enum RealNameValidationError {
  invalid,
  tooShort,
  tooLong,
}

class RealName extends FormzInput<String, RealNameValidationError> {
  const RealName.pure() : super.pure('');
  const RealName.dirty([String value = '']) : super.dirty(value);

  static final RegExp _realNameRegExp = RegExp(r"^[a-zA-Z\s]*$");
  static const int _minLength = 2;
  static const int _maxLength = 50;

  @override
  RealNameValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return RealNameValidationError.invalid;
    }
    if (value.length < _minLength) {
      return RealNameValidationError.tooShort;
    }
    if (value.length > _maxLength) {
      return RealNameValidationError.tooLong;
    }
    return _realNameRegExp.hasMatch(value)
        ? null
        : RealNameValidationError.invalid;
  }
}
