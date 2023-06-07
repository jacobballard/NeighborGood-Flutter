import 'package:formz/formz.dart';

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
