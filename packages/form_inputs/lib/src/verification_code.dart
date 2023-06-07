import 'package:formz/formz.dart';

/// Validation errors for the [VerificationCode] [FormzInput].
enum VerificationCodeValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template verification_code}
/// Form input for a verification code input.
/// {@endtemplate}
class VerificationCode
    extends FormzInput<String, VerificationCodeValidationError> {
  /// {@macro verification_code}
  const VerificationCode.pure() : super.pure('');

  /// {@macro verification_code}
  const VerificationCode.dirty([super.value = '']) : super.dirty();

  static final RegExp _verificationCodeRegExp = RegExp(
    r'^\d{6}$', // Matches exactly six digits
  );

  @override
  VerificationCodeValidationError? validator(String? value) {
    return _verificationCodeRegExp.hasMatch(value ?? '')
        ? null
        : VerificationCodeValidationError.invalid;
  }
}
