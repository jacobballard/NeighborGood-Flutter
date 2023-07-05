import 'package:formz/formz.dart';

enum StoreTitleValidationError { invalid }

class StoreTitle extends FormzInput<String, StoreTitleValidationError> {
  const StoreTitle.pure() : super.pure("");

  const StoreTitle.dirty([String value = '']) : super.dirty(value);

  static final unicodeRegex =
      RegExp(r'^[\p{L}\p{M}\p{S}\p{N}\p{P} ]*$', unicode: true);

  @override
  StoreTitleValidationError? validator(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.length < 2 ||
        !unicodeRegex.hasMatch(value)) {
      return StoreTitleValidationError.invalid;
    }
    return null;
  }
}

enum StoreDescriptionValidationError { invalid }

class StoreDescription
    extends FormzInput<String, StoreDescriptionValidationError> {
  const StoreDescription.pure() : super.pure("");
  const StoreDescription.dirty([String value = '']) : super.dirty(value);

  static final unicodeRegex =
      RegExp(r'^[\p{L}\p{M}\p{S}\p{N}\p{P} ]*$', unicode: true);

  @override
  StoreDescriptionValidationError? validator(String? value) {
    if (value != null && value.length > 1500) {
      return StoreDescriptionValidationError.invalid;
    }
    return unicodeRegex.hasMatch(value ?? '')
        ? null
        : StoreDescriptionValidationError.invalid;
  }
}

enum AddressValidationError { invalid }

class Address extends FormzInput<String, AddressValidationError> {
  const Address.pure() : super.pure('');
  const Address.dirty([String value = '']) : super.dirty(value);
  // Here you can adjust the regular expression to match your desired validation criteria for the address.
  static final _addressRegExp = RegExp(r'^[a-zA-Z0-9\s,]*$');
  @override
  AddressValidationError? validator(String? value) {
    return _addressRegExp.hasMatch(value ?? '')
        ? null
        : AddressValidationError.invalid;
  }
}

enum ZipCodeValidationError { invalid }

class ZipCode extends FormzInput<String, ZipCodeValidationError> {
  const ZipCode.pure() : super.pure('');
  const ZipCode.dirty([String value = '']) : super.dirty(value);

  // Modified regular expression
  static final _zipCodeRegExp = RegExp(r'^\d{5}(-\d{4})?$');

  @override
  ZipCodeValidationError? validator(String? value) {
    return _zipCodeRegExp.hasMatch(value ?? '')
        ? null
        : ZipCodeValidationError.invalid;
  }
}

enum CityValidationError { invalid }

class City extends FormzInput<String, CityValidationError> {
  const City.pure() : super.pure('');
  const City.dirty([String value = '']) : super.dirty(value);

  static final _cityRegExp = RegExp(r"^[a-zA-Z\s\-']+$");

  @override
  CityValidationError? validator(String? value) {
    return _cityRegExp.hasMatch(value ?? '')
        ? null
        : CityValidationError.invalid;
  }
}

class TermsAccepted extends FormzInput<bool, String> {
  const TermsAccepted.pure() : super.pure(false);
  const TermsAccepted.dirty([bool value = false]) : super.dirty(value);

  @override
  String? validator(bool? value) {
    return value == true ? null : 'You must accept the terms and conditions';
  }
}

class DeliveryRange extends FormzInput<String, DeliveryRangeValidationError> {
  const DeliveryRange.pure() : super.pure('');
  const DeliveryRange.dirty([String value = '']) : super.dirty(value);

  static final _deliveryRangeRegExp = RegExp(r'^\d+(\.\d+)?$');

  @override
  DeliveryRangeValidationError? validator(String? value) {
    return _deliveryRangeRegExp.hasMatch(value ?? '')
        ? null
        : DeliveryRangeValidationError.invalid;
  }
}

enum DeliveryRangeValidationError { invalid }

class DeliveryFee extends FormzInput<String, DeliveryFeeValidationError> {
  const DeliveryFee.pure() : super.pure('');
  const DeliveryFee.dirty([String value = '']) : super.dirty(value);

  static final _deliveryFeeRegExp = RegExp(r'^\d+(\.\d+)?$');

  @override
  DeliveryFeeValidationError? validator(String? value) {
    return _deliveryFeeRegExp.hasMatch(value ?? '')
        ? null
        : DeliveryFeeValidationError.invalid;
  }
}

enum DeliveryFeeValidationError { invalid }

class Eta extends FormzInput<String, EtaValidationError> {
  const Eta.pure() : super.pure('');
  const Eta.dirty([String value = '']) : super.dirty(value);

  static final _etaRegExp = RegExp(r'^\d+$');

  @override
  EtaValidationError? validator(String? value) {
    return _etaRegExp.hasMatch(value ?? '') ? null : EtaValidationError.invalid;
  }
}

enum EtaValidationError { invalid }
