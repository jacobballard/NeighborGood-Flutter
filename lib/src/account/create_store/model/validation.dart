import 'package:formz/formz.dart';

enum StoreTitleValidationError { invalid }

class StoreTitle extends FormzInput<String, StoreTitleValidationError> {
  const StoreTitle.pure() : super.pure("");

  const StoreTitle.dirty([String value = '']) : super.dirty(value);

  static final unicodeRegex =
      RegExp(r'^[\p{L}\p{M}\p{S}\p{N}\p{P}]*$', unicode: true);

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
      RegExp(r'^[\p{L}\p{M}\p{S}\p{N}\p{P}]*$', unicode: true);

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

enum LastNameValidationError { invalid }

class LastName extends FormzInput<String, LastNameValidationError> {
  const LastName.pure() : super.pure('');
  const LastName.dirty([String value = '']) : super.dirty(value);
  static final _fullNameRegExp = RegExp(r'^[a-zA-Z\s]*$');
  @override
  LastNameValidationError? validator(String? value) {
    return _fullNameRegExp.hasMatch(value ?? '')
        ? null
        : LastNameValidationError.invalid;
  }
}

enum FirstNameValidationError { invalid }

class FirstName extends FormzInput<String, FirstNameValidationError> {
  const FirstName.pure() : super.pure('');
  const FirstName.dirty([String value = '']) : super.dirty(value);
  static final _fullNameRegExp = RegExp(r'^[a-zA-Z\s]*$');
  @override
  FirstNameValidationError? validator(String? value) {
    return _fullNameRegExp.hasMatch(value ?? '')
        ? null
        : FirstNameValidationError.invalid;
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
  static final _zipCodeRegExp = RegExp(r'^\d{5}$');
  @override
  ZipCodeValidationError? validator(String? value) {
    return _zipCodeRegExp.hasMatch(value ?? '')
        ? null
        : ZipCodeValidationError.invalid;
  }
}

enum SocialSecurityValidationError { invalid }

class SocialSecurity extends FormzInput<String, SocialSecurityValidationError> {
  const SocialSecurity.pure() : super.pure('');
  const SocialSecurity.dirty([String value = '']) : super.dirty(value);
  static final _socialSecurityRegExp = RegExp(r'^\d{4}$');
  @override
  SocialSecurityValidationError? validator(String? value) {
    return _socialSecurityRegExp.hasMatch(value ?? '')
        ? null
        : SocialSecurityValidationError.invalid;
  }
}

enum PhoneNumberValidationError { invalid }

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);
  static final _phoneNumberRegExp = RegExp(r'^\(\d{3}\)\s\d{3}-\d{4}$');
  @override
  PhoneNumberValidationError? validator(String? value) {
    return _phoneNumberRegExp.hasMatch(value ?? '')
        ? null
        : PhoneNumberValidationError.invalid;
  }
}

enum DateOfBirthValidationError { invalid }

class DateOfBirth extends FormzInput<String, DateOfBirthValidationError> {
  const DateOfBirth.pure() : super.pure('');
  const DateOfBirth.dirty([String value = '']) : super.dirty(value);
  static final _dateOfBirthRegExp = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  @override
  DateOfBirthValidationError? validator(String? value) {
    return _dateOfBirthRegExp.hasMatch(value ?? '')
        ? null
        : DateOfBirthValidationError.invalid;
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

enum TaxIdValidationError { invalid }

class TaxId extends FormzInput<String, TaxIdValidationError> {
  const TaxId.pure() : super.pure('');
  const TaxId.dirty([String value = '']) : super.dirty(value);

  // US EIN (Employer Identification Number) has a format of 9 digits and typically written as 00-0000000
  static final _taxIdRegExp = RegExp(r"^\d{2}-\d{7}$");

  @override
  TaxIdValidationError? validator(String? value) {
    return _taxIdRegExp.hasMatch(value ?? '')
        ? null
        : TaxIdValidationError.invalid;
  }
}

enum CompanyNameValidationError { invalid }

class CompanyName extends FormzInput<String, CompanyNameValidationError> {
  const CompanyName.pure() : super.pure('');
  const CompanyName.dirty([String value = '']) : super.dirty(value);

  // Validation rule for company name can be adjusted as needed, let's assume at least one character is required
  static final _companyNameRegExp = RegExp(r"^.+$");

  @override
  CompanyNameValidationError? validator(String? value) {
    return _companyNameRegExp.hasMatch(value ?? '')
        ? null
        : CompanyNameValidationError.invalid;
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

enum LatitudeValidationError { invalid }

class Latitude extends FormzInput<double, LatitudeValidationError> {
  const Latitude.pure() : super.pure(0);
  const Latitude.dirty([double value = 0]) : super.dirty(value);

  @override
  LatitudeValidationError? validator(double? value) {
    return (value ?? 0).abs() <= 90 ? null : LatitudeValidationError.invalid;
  }
}

enum LongitudeValidationError { invalid }

class Longitude extends FormzInput<double, LongitudeValidationError> {
  const Longitude.pure() : super.pure(0);
  const Longitude.dirty([double value = 0]) : super.dirty(value);

  @override
  LongitudeValidationError? validator(double? value) {
    return (value ?? 0).abs() <= 180 ? null : LongitudeValidationError.invalid;
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
