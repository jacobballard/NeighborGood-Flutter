part of 'store_address_cubit.dart';

class StoreAddressState extends Equatable {
  final Address addressLine1;
  final Address addressLine2;
  final ZipCode zipCode;
  final City city;
  final String stateName;
  final FormzStatus status;
  final bool hasSuggestedAddress;
  final returnAddress.Address? suggestedAddress;

  FormzStatus get isZipcodeOnlyOrAllFieldsValid {
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

  bool get isValidated {
    if (zipCode.valid &&
        addressLine1.valid &&
        (addressLine2.value == "" || addressLine2.valid) &&
        city.valid &&
        stateName != "") {
      return true;
    } else {
      return false;
    }
  }

  StoreAddressState({
    this.addressLine1 = const Address.pure(),
    this.addressLine2 = const Address.pure(),
    this.zipCode = const ZipCode.pure(),
    this.city = const City.pure(),
    this.stateName = "",
    this.status = FormzStatus.pure,
    this.hasSuggestedAddress = false,
    this.suggestedAddress,
  });

  StoreAddressState copyWith({
    Address? addressLine1,
    Address? addressLine2,
    ZipCode? zipCode,
    City? city,
    String? stateName,
    FormzStatus? status,
    bool? hasSuggestedAddress,
    returnAddress.Address? suggestedAddress,
  }) {
    return StoreAddressState(
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      zipCode: zipCode ?? this.zipCode,
      city: city ?? this.city,
      stateName: stateName ?? this.stateName,
      status: status ?? this.status,
      suggestedAddress: suggestedAddress ?? this.suggestedAddress,
      hasSuggestedAddress: hasSuggestedAddress ?? this.hasSuggestedAddress,
    );
  }

  @override
  List<Object?> get props => [
        addressLine1,
        addressLine2,
        zipCode,
        city,
        stateName,
        status,
        suggestedAddress,
        hasSuggestedAddress,
      ];
}
