import 'package:formz/formz.dart';

enum ZipCodeInputValidationError { invalid }

class ZipCodeInput extends FormzInput<String, ZipCodeInputValidationError> {
  const ZipCodeInput.pure() : super.pure('');
  const ZipCodeInput.dirty([String value = '']) : super.dirty(value);

  static final _zipCodeRegExp = RegExp(r'^\d{5}$');

  @override
  ZipCodeInputValidationError? validator(String? value) {
    return _zipCodeRegExp.hasMatch(value ?? '')
        ? null
        : ZipCodeInputValidationError.invalid;
  }
}
