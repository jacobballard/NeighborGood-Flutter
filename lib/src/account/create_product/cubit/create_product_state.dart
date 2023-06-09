part of 'create_product_cubit.dart';

class CreateProductState extends Equatable {
  final FormzStatus productDetailsStatus;
  final FormzStatus deliveryMethodsStatus;
  final FormzStatus imageUploaderStatus;
  final FormzStatus productModifiersStatus;
  final FormzStatus status;
  final String? errorMessage;

  const CreateProductState({
    this.productDetailsStatus = FormzStatus.pure,
    this.deliveryMethodsStatus = FormzStatus.pure,
    this.imageUploaderStatus = FormzStatus.pure,
    this.productModifiersStatus = FormzStatus.pure,
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  bool get isValidated =>
      productDetailsStatus == FormzStatus.valid &&
      (productModifiersStatus == FormzStatus.valid ||
          productModifiersStatus == FormzStatus.pure) &&
      (deliveryMethodsStatus == FormzStatus.valid ||
          deliveryMethodsStatus == FormzStatus.pure) &&
      imageUploaderStatus == FormzStatus.valid;

  CreateProductState copyWith({
    FormzStatus? productDetailsStatus,
    FormzStatus? deliveryMethodsStatus,
    FormzStatus? imageUploaderStatus,
    FormzStatus? productModifiersStatus,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return CreateProductState(
      productDetailsStatus: productDetailsStatus ?? this.productDetailsStatus,
      deliveryMethodsStatus:
          deliveryMethodsStatus ?? this.deliveryMethodsStatus,
      imageUploaderStatus: imageUploaderStatus ?? this.imageUploaderStatus,
      productModifiersStatus:
          productModifiersStatus ?? this.productModifiersStatus,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        productDetailsStatus,
        deliveryMethodsStatus,
        imageUploaderStatus,
        productModifiersStatus,
        status,
        errorMessage,
      ];
}
