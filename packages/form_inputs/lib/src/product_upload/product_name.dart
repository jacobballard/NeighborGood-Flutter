import 'package:formz/formz.dart';

enum ProductNameValidationError { invalid }

class ProductName extends FormzInput<String, ProductNameValidationError> {
  const ProductName.pure() : super.pure('');
  const ProductName.dirty([String value = '']) : super.dirty(value);

  static final RegExp _productNameRegExp = RegExp(
    r'^[A-Za-z0-9 _-]{1,100}$',
  );

  @override
  ProductNameValidationError? validator(String? value) {
    return _productNameRegExp.hasMatch(value ?? '')
        ? null
        : ProductNameValidationError.invalid;
  }
}
