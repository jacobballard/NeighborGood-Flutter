part of 'create_product_cubit.dart';

class CreateProductState {
  final FormzStatus productDetailsStatus;
  final FormzStatus deliveryMethodsStatus;
  final FormzStatus imageUploaderStatus;
  final FormzStatus productModifiersStatus;

  CreateProductState(
      {this.productDetailsStatus = FormzStatus.pure,
      this.productModifiersStatus = FormzStatus.pure,
      this.deliveryMethodsStatus = FormzStatus.pure,
      this.imageUploaderStatus = FormzStatus.pure});

  bool get isValidated =>
      productDetailsStatus == FormzStatus.valid &&
      productModifiersStatus == FormzStatus.valid &&
      deliveryMethodsStatus == FormzStatus.valid &&
      imageUploaderStatus == FormzStatus.valid;
}
