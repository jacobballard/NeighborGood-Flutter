import 'package:formz/formz.dart';

enum ZipCodeValidationError { invalid }

class ZipCodeInput extends FormzInput<String, ZipCodeValidationError> {
  const ZipCodeInput.pure() : super.pure('');
  const ZipCodeInput.dirty([String value = '']) : super.dirty(value);

  static final _zipCodeRegExp = RegExp(r'^\d{5}$');

  @override
  ZipCodeValidationError? validator(String? value) {
    return _zipCodeRegExp.hasMatch(value ?? '')
        ? null
        : ZipCodeValidationError.invalid;
  }
}
