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
