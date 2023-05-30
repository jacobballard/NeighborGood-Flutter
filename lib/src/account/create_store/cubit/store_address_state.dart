part of 'store_address_cubit.dart';

class StoreAddressState {
  final Address addressLine1;
  final Address addressLine2;
  final ZipCode zipCode;
  final City city;
  final String stateName;
  final FormzStatus status;

  FormzStatus get isZipcodeOnlyOrAllFieldsValid {
    print(zipCode.status);
    print(stateName);
    print("print value ${addressLine1.value}");
    print("status valid");
    if (zipCode.status == FormzInputStatus.valid &&
        addressLine1.value == "" &&
        addressLine2.value == "" &&
        city.value == "" &&
        stateName == "") {
      return FormzStatus.valid;
    }

    if (zipCode.valid &&
        addressLine1.valid &&
        (addressLine2.value == "" || addressLine2.valid) &&
        city.valid &&
        stateName != "") {
      return FormzStatus.valid;
    }

    return FormzStatus.invalid;
  }

  StoreAddressState({
    this.addressLine1 = const Address.pure(),
    this.addressLine2 = const Address.pure(),
    this.zipCode = const ZipCode.pure(),
    this.city = const City.pure(),
    this.stateName = "",
    this.status = FormzStatus.pure,
  });

  StoreAddressState copyWith({
    Address? addressLine1,
    Address? addressLine2,
    ZipCode? zipCode,
    City? city,
    String? stateName,
    FormzStatus? status,
  }) {
    return StoreAddressState(
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      zipCode: zipCode ?? this.zipCode,
      city: city ?? this.city,
      stateName: stateName ?? this.stateName,
      status: status ?? this.status,
    );
  }
}
