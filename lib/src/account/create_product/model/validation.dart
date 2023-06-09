// import 'package:formz/formz.dart';

// enum ProductTitleValidationError { invalid }

// class ProductTitle extends FormzInput<String, ProductTitleValidationError> {
//   const ProductTitle.pure() : super.pure("");

//   const ProductTitle.dirty([super.value = '']) : super.dirty();

//   static final unicodeRegex =
//       RegExp(r'^[\p{L}\p{N}\p{P}\p{Z}\p{Sm}]*$', unicode: true);

//   @override
//   ProductTitleValidationError? validator(String? value) {
//     if (value == null ||
//         value.isEmpty ||
//         value.length < 2 ||
//         !unicodeRegex.hasMatch(value)) {
//       return ProductTitleValidationError.invalid;
//     }
//     return null;
//   }
// }

// enum ProductDescriptionValidationError { invalid }

// class ProductDescription
//     extends FormzInput<String, ProductDescriptionValidationError> {
//   const ProductDescription.pure() : super.pure("");

//   const ProductDescription.dirty([super.value = '']) : super.dirty();

//   static final unicodeRegex = RegExp(r'^[\p{L}\p{N}\p{P}\p{Z}\p{Sm}]*$',
//       unicode: true, multiLine: true);

//   @override
//   ProductDescriptionValidationError? validator(String? value) {
//     if (value != null && value.length > 1500) {
//       return ProductDescriptionValidationError.invalid;
//     }
//     return unicodeRegex.hasMatch(value ?? "")
//         ? null
//         : ProductDescriptionValidationError.invalid;
//   }
// }

// enum ProductPriceValidationError { invalid }

// class ProductPrice extends FormzInput<String, ProductPriceValidationError> {
//   const ProductPrice.pure() : super.pure("");

//   const ProductPrice.dirty([String value = '']) : super.dirty(value);

//   static final _doubleValueLessThan100000 = RegExp(r'^\d{0,5}(\.\d{1,2})?$');

//   @override
//   ProductPriceValidationError? validator(String? value) {
//     if (value == null ||
//         value.isEmpty ||
//         !_doubleValueLessThan100000.hasMatch(value)) {
//       return ProductPriceValidationError.invalid;
//     }

//     return null;
//   }
// }

// enum ModifierTitleValidationError { invalid }

// class ModifierTitle extends FormzInput<String, ModifierTitleValidationError> {
//   const ModifierTitle.pure() : super.pure("");

//   const ModifierTitle.dirty([String value = '']) : super.dirty(value);

//   static final _validTitle =
//       RegExp(r'^[\p{L}\p{N}\p{P}\p{Z}\p{Sm}]*$', unicode: true);

//   @override
//   ModifierTitleValidationError? validator(String? value) {
//     return _validTitle.hasMatch(value ?? '')
//         ? null
//         : ModifierTitleValidationError.invalid;
//   }
// }

// enum TextModifierFillTextValidationError { invalid }

// class TextModifierFillText
//     extends FormzInput<String, TextModifierFillTextValidationError> {
//   const TextModifierFillText.pure() : super.pure("");

//   const TextModifierFillText.dirty([String value = '']) : super.dirty(value);

//   static final _validFillText =
//       RegExp(r'^[\p{L}\p{N}\p{P}\p{Z}\p{Sm}]*$', unicode: true);

//   @override
//   TextModifierFillTextValidationError? validator(String? value) {
//     return _validFillText.hasMatch(value ?? '')
//         ? null
//         : TextModifierFillTextValidationError.invalid;
//   }
// }

// enum TextModifierCharacterLimitValidationError { invalid }

// class TextModifierCharacterLimit
//     extends FormzInput<String, TextModifierCharacterLimitValidationError> {
//   const TextModifierCharacterLimit.pure() : super.pure("");

//   const TextModifierCharacterLimit.dirty([String value = ''])
//       : super.dirty(value);

//   static final _validCharacterLimit = RegExp(r'^\d*$');

//   @override
//   TextModifierCharacterLimitValidationError? validator(String? value) {
//     return _validCharacterLimit.hasMatch(value ?? '')
//         ? null
//         : TextModifierCharacterLimitValidationError.invalid;
//   }
// }
