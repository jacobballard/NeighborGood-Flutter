part of 'create_store_cubit.dart';

class CreateStoreState {
  final FormzStatus storeDetailsStatus;
  final FormzStatus storeAddressStatus;
  final FormzStatus deliveryMethodsStatus;
  final FormzStatus imageUploaderStatus;

  CreateStoreState(
      {this.storeDetailsStatus = FormzStatus.pure,
      this.storeAddressStatus = FormzStatus.pure,
      this.deliveryMethodsStatus = FormzStatus.pure,
      this.imageUploaderStatus = FormzStatus.pure});

  bool get isValidated =>
      storeDetailsStatus == FormzStatus.valid &&
      storeAddressStatus == FormzStatus.valid &&
      deliveryMethodsStatus == FormzStatus.valid &&
      imageUploaderStatus == FormzStatus.valid;
}
