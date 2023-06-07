import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'store_address_state.dart';

class StoreAddressCubit extends Cubit<StoreAddressState> {
  StoreAddressCubit() : super(StoreAddressState());

  void addressLine1Changed(String value) {
    final addressLine1 = Address.dirty(value);
    emit(state.copyWith(
      addressLine1: addressLine1,
      status: Formz.validate([
        addressLine1,
        state.addressLine2,
        state.zipCode,
        state.city,
      ]),
    ));
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
}
