part of 'create_store_cubit.dart';

class CreateStoreState extends Equatable {
  final FormzStatus storeDetailsStatus;
  final FormzStatus storeAddressStatus;
  final FormzStatus deliveryMethodsStatus;
  final FormzStatus imageUploaderStatus;
  final FormzStatus onboardingStatus;
  final FormzStatus status;

  final String? errorMessage;

  const CreateStoreState({
    this.storeDetailsStatus = FormzStatus.pure,
    this.storeAddressStatus = FormzStatus.pure,
    this.deliveryMethodsStatus = FormzStatus.pure,
    this.imageUploaderStatus = FormzStatus.pure,
    this.onboardingStatus = FormzStatus.pure,
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  bool get isValidated =>
      storeDetailsStatus == FormzStatus.valid &&
      storeAddressStatus == FormzStatus.valid &&
      deliveryMethodsStatus == FormzStatus.valid &&
      imageUploaderStatus == FormzStatus.valid &&
      onboardingStatus == FormzStatus.valid;

  CreateStoreState copyWith({
    FormzStatus? storeDetailsStatus,
    FormzStatus? storeAddressStatus,
    FormzStatus? deliveryMethodsStatus,
    FormzStatus? imageUploaderStatus,
    FormzStatus? onboardingStatus,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return CreateStoreState(
      storeDetailsStatus: storeDetailsStatus ?? this.storeDetailsStatus,
      storeAddressStatus: storeAddressStatus ?? this.storeAddressStatus,
      deliveryMethodsStatus:
          deliveryMethodsStatus ?? this.deliveryMethodsStatus,
      imageUploaderStatus: imageUploaderStatus ?? this.imageUploaderStatus,
      onboardingStatus: onboardingStatus ?? this.onboardingStatus,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        storeDetailsStatus,
        storeAddressStatus,
        deliveryMethodsStatus,
        imageUploaderStatus,
        onboardingStatus,
        status,
        errorMessage,
      ];
}
