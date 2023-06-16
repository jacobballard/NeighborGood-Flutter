import 'package:formz/formz.dart';

enum CartTextModifierInputValidationError { invalid }

class CartTextModifierInput
    extends FormzInput<String, CartTextModifierInputValidationError> {
  final int? characterLimit;
  final bool required;

  const CartTextModifierInput.pure(
      {this.characterLimit = 0, this.required = false})
      : super.pure("");

  const CartTextModifierInput.dirty(
      {required String value, this.characterLimit = 0, this.required = false})
      : super.dirty(value);

  static final _validInput =
      RegExp(r'^[\p{L}\p{M}\p{S}\p{N}\p{P}\p{Z}\s]*$', unicode: true);

  @override
  CartTextModifierInputValidationError? validator(String? value) {
    if (required) {
      if (value == null ||
          value.isEmpty ||
          value.length < 2 ||
          value.length > characterLimit! ||
          !_validInput.hasMatch(value)) {
        return CartTextModifierInputValidationError.invalid;
      }
    }
    return null;
  }
}
