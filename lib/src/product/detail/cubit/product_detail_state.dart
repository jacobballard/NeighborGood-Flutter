part of 'product_detail_cubit.dart';

enum ViewProductDetailsStatus { initial, loading, success, failure }

class ViewProductDetailsState extends Equatable {
  const ViewProductDetailsState({
    this.productDetails,
    this.errorMessage,
    this.inputStatus = FormzStatus.pure,
    this.status = ViewProductDetailsStatus.initial,
    this.cartModifierSelections,
    this.deliveryMethodType,
  });

  final FormzStatus inputStatus;
  final ViewProductDetailsStatus status;

  final ProductDetails? productDetails;

  final List<CartModifierSelection>? cartModifierSelections;

  final DeliveryMethodType? deliveryMethodType;

  final String? errorMessage;

  @override
  List<Object?> get props => [
        status,
        productDetails,
        errorMessage,
      ];

  ViewProductDetailsState copyWith({
    ViewProductDetailsStatus? status,
    ProductDetails? productDetails,
    String? errorMessage,
    List<CartModifierSelection>? cartModifierSelections,
    DeliveryMethodType? deliveryMethodType,
    FormzStatus? inputStatus,
  }) {
    return ViewProductDetailsState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      productDetails: productDetails ?? this.productDetails,
      inputStatus: inputStatus ?? this.inputStatus,
    );
  }
}
