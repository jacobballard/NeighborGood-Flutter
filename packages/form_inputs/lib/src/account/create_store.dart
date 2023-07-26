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

enum SSLastFourValidationError { invalid }

class SSLastFour extends FormzInput<String, SSLastFourValidationError> {
  const SSLastFour.pure() : super.pure("");
  const SSLastFour.dirty([String value = '']) : super.dirty(value);

  static final regex = RegExp(r'^\d{4}$');

  @override
  SSLastFourValidationError? validator(String? value) {
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return SSLastFourValidationError.invalid;
    }
    return null;
  }
}

enum DayValidationError { invalid }

class Day extends FormzInput<String, DayValidationError> {
  const Day.pure() : super.pure("");
  const Day.dirty([String value = '']) : super.dirty(value);

  @override
  DayValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return DayValidationError.invalid;
    }
    int day = int.tryParse(value) ?? 0;
    if (day < 1 || day > 31) {
      return DayValidationError.invalid;
    }
    return null;
  }
}

enum MonthValidationError { invalid }

class Month extends FormzInput<String, MonthValidationError> {
  const Month.pure() : super.pure("");
  const Month.dirty([String value = '']) : super.dirty(value);

  @override
  MonthValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return MonthValidationError.invalid;
    }
    int month = int.tryParse(value) ?? 0;
    if (month < 1 || month > 12) {
      return MonthValidationError.invalid;
    }
    return null;
  }
}

enum YearValidationError { invalid }

class Year extends FormzInput<String, YearValidationError> {
  const Year.pure() : super.pure("");
  const Year.dirty([String value = '']) : super.dirty(value);

  @override
  YearValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return YearValidationError.invalid;
    }
    int year = int.tryParse(value) ?? 0;
    if (year < 1920 || year > DateTime.now().year) {
      return YearValidationError.invalid;
    }
    return null;
  }
}

enum NameValidationError { invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure("");
  const Name.dirty([String value = '']) : super.dirty(value);

  static final unicodeRegex =
      RegExp(r'^[\p{L}\p{M}\p{S}\p{N}\p{P} ]*$', unicode: true);

  @override
  NameValidationError? validator(String? value) {
    if (value == null || value.isEmpty || !unicodeRegex.hasMatch(value)) {
      return NameValidationError.invalid;
    }
    return null;
  }
}

// enum CompanyNameValidationError { invalid }

// class CompanyName extends FormzInput<String, CompanyNameValidationError> {
//   const CompanyName.pure() : super.pure("");
//   const CompanyName.dirty([String value = '']) : super.dirty(value);

//   static final unicodeRegex = RegExp(r'^[\p{L}\p{M}\p{S}\p{N}\p{P} ]*$', unicode: true);

//   @override
//   CompanyNameValidationError? validator(String? value) {
//     if (value == null || value.isEmpty || !unicodeRegex.hasMatch(value)) {
//       return CompanyNameValidationError.invalid;
//     }
//     return null;
//   }
// }

enum CompanyTaxIdValidationError { invalid }

class CompanyTaxId extends FormzInput<String, CompanyTaxIdValidationError> {
  const CompanyTaxId.pure() : super.pure("");
  const CompanyTaxId.dirty([String value = '']) : super.dirty(value);

  static final regex = RegExp(
      r'^[0-9]{2}-[0-9]{7}$'); // Adjust this regex according to your requirement for tax ID

  @override
  CompanyTaxIdValidationError? validator(String? value) {
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return CompanyTaxIdValidationError.invalid;
    }
    return null;
  }
}

enum BankAccountValidationError { invalid }

class BankAccount extends FormzInput<String, BankAccountValidationError> {
  const BankAccount.pure() : super.pure("");
  const BankAccount.dirty([String value = '']) : super.dirty(value);

  static final regex = RegExp(r'^\d{1,17}$');

  @override
  BankAccountValidationError? validator(String? value) {
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return BankAccountValidationError.invalid;
    }
    return null;
  }
}

enum RoutingNumberValidationError { invalid }

class RoutingNumber extends FormzInput<String, RoutingNumberValidationError> {
  const RoutingNumber.pure() : super.pure("");
  const RoutingNumber.dirty([String value = '']) : super.dirty(value);

  static final regex = RegExp(r'^\d{9}$');

  @override
  RoutingNumberValidationError? validator(String? value) {
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return RoutingNumberValidationError.invalid;
    }
    return null;
  }
}
