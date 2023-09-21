import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:repositories/models/address.dart' as returnAddress;

part 'store_address_state.dart';

class StoreAddressCubit extends Cubit<StoreAddressState> {
  StoreAddressCubit() : super(StoreAddressState());

  void addressLine1Changed(String value) {
    print("inside");
    final addressLine1 = Address.dirty(value);

    print(addressLine1);
    emit(state.copyWith(
      addressLine1: addressLine1,
      status: Formz.validate([
        addressLine1,
        state.addressLine2,
        state.zipCode,
        state.city,
      ]),
    ));

    print(state.status);
    print(state.addressLine1.value);
    print("statis");
  }

  void resetState() {
    emit(StoreAddressState());
  }

  void addSuggestedAddress(returnAddress.Address? address) {
    emit(state.copyWith(
        suggestedAddress: address,
        hasSuggestedAddress: address == null ? false : true));
  }

  void confirmAddress() {
    final addressLine1 =
        Address.dirty(state.suggestedAddress!.address_line_1 ?? "");
    final addressLine2 =
        Address.dirty(state.suggestedAddress!.address_line_2 ?? "");
    final zipCode = ZipCode.dirty(state.suggestedAddress!.zip);
    final city = City.dirty(state.suggestedAddress!.city ?? "");
    final stateName = state.suggestedAddress!.state;

    final status = Formz.validate([addressLine1, addressLine2, zipCode, city]);

    emit(state.copyWith(
        addressLine1: addressLine1,
        addressLine2: addressLine2,
        zipCode: zipCode,
        city: city,
        stateName: stateName,
        status: status,
        suggestedAddress: null,
        hasSuggestedAddress: false));
  }

  void addressLine2Changed(String value) {
    final addressLine2 = Address.dirty(value);
    emit(state.copyWith(
      addressLine2: addressLine2,
      status: Formz.validate([
        state.addressLine1,
        addressLine2,
        state.zipCode,
        state.city,
      ]),
    ));
  }

  void zipCodeChanged(String value) {
    final zipCode = ZipCode.dirty(value);
    emit(state.copyWith(
      zipCode: zipCode,
      status: Formz.validate([
        state.addressLine1,
        state.addressLine2,
        zipCode,
        state.city,
      ]),
    ));
  }

  bool get isZipCodeValid => state.zipCode.valid;

  void cityChanged(String value) {
    final city = City.dirty(value);
    emit(state.copyWith(
      city: city,
      status: Formz.validate([
        state.addressLine1,
        state.addressLine2,
        state.zipCode,
        city,
      ]),
    ));
  }

  void stateChanged(String value) {
    emit(state.copyWith(
      stateName: value,
      status: Formz.validate([
        state.addressLine1,
        state.addressLine2,
        state.zipCode,
        state.city,
      ]),
    ));
  }

  returnAddress.Address toAddress() {
    return returnAddress.Address(
        state.addressLine1.value,
        state.addressLine2.value,
        state.city.value,
        state.stateName,
        state.zipCode.value);
  }
}
