import 'package:formz/formz.dart';

enum BasePriceValidationError { invalid }

class BasePrice extends FormzInput<double, BasePriceValidationError> {
  const BasePrice.pure() : super.pure(0.0);
  const BasePrice.dirty([double value = 0.0]) : super.dirty(value);

  @override
  BasePriceValidationError? validator(double? value) {
    return (value != null && value >= 0.0)
        ? null
        : BasePriceValidationError.invalid;
  }
}
