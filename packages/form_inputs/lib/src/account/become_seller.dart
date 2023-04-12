import 'package:formz/formz.dart';

enum StoreTitleValidationError { empty }

class StoreTitle extends FormzInput<String, StoreTitleValidationError> {
  const StoreTitle.pure() : super.pure('');
  const StoreTitle.dirty([String value = '']) : super.dirty(value);

  @override
  StoreTitleValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : StoreTitleValidationError.empty;
  }
}

enum StoreDescriptionValidationError { empty }

class StoreDescription
    extends FormzInput<String, StoreDescriptionValidationError> {
  const StoreDescription.pure() : super.pure('');
  const StoreDescription.dirty([String value = '']) : super.dirty(value);

  @override
  StoreDescriptionValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : StoreDescriptionValidationError.empty;
  }
}
