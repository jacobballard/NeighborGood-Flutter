import 'package:formz/formz.dart';

// ModifierType Validationx
enum ModifierTypeValidationError { invalid }

class ModifierType extends FormzInput<String?, ModifierTypeValidationError> {
  const ModifierType.pure() : super.pure(null);
  const ModifierType.dirty([String? value]) : super.dirty(value);

  @override
  ModifierTypeValidationError? validator(String? value) {
    return (value == 'input' || value == 'picker')
        ? null
        : ModifierTypeValidationError.invalid;
  }
}

// CharacterLimit Validation
enum CharacterLimitValidationError { invalid }

class CharacterLimit extends FormzInput<int, CharacterLimitValidationError> {
  const CharacterLimit.pure() : super.pure(0);
  const CharacterLimit.dirty([int value = 0]) : super.dirty(value);

  @override
  CharacterLimitValidationError? validator(int value) {
    return (value >= 0) ? null : CharacterLimitValidationError.invalid;
  }
}

// PickerOption Validation
enum PickerOptionValidationError { invalid }

class PickerOption extends FormzInput<String, PickerOptionValidationError> {
  final double price;

  const PickerOption.pure()
      : price = 0.0,
        super.pure('');
  const PickerOption.dirty(String value, this.price) : super.dirty(value);

  @override
  PickerOptionValidationError? validator(String value) {
    return (value.isNotEmpty && price >= 0)
        ? null
        : PickerOptionValidationError.invalid;
  }
}

enum OptionNameValidationError { invalid }

enum OptionPriceValidationError { invalid }

class OptionName extends FormzInput<String, OptionNameValidationError> {
  const OptionName.pure() : super.pure('');
  const OptionName.dirty([String value = '']) : super.dirty(value);

  @override
  OptionNameValidationError? validator(String value) {
    return value.isNotEmpty ? null : OptionNameValidationError.invalid;
  }
}

class OptionPrice extends FormzInput<double, OptionPriceValidationError> {
  const OptionPrice.pure() : super.pure(0.0);
  const OptionPrice.dirty([double value = 0.0]) : super.dirty(value);

  @override
  OptionPriceValidationError? validator(double value) {
    return value >= 0 ? null : OptionPriceValidationError.invalid;
  }
}
