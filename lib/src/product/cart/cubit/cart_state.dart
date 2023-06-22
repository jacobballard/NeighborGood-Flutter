part of 'cart_cubit.dart';

class CartState extends Equatable {
  final FormzStatus status;
  final String? errorMessage;
  final List<CartItem> checkoutItems;
  final String shippingPrice;
  final String tax;
  final String totalPrice;
  final String platformFee;
  final String subtotal;

  const CartState({
    this.subtotal = '',
    this.platformFee = '',
    this.totalPrice = '',
    this.shippingPrice = '',
    this.tax = '',
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.checkoutItems = const [],
  });

  CartState copyWith({
    FormzStatus? status,
    String? errorMessage,
    List<CartItem>? checkoutItems,
    String? shippingPrice,
    String? tax,
    String? totalPrice,
    String? platformFee,
    String? subtotal,
  }) {
    return CartState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      checkoutItems: checkoutItems ?? this.checkoutItems,
      shippingPrice: shippingPrice ?? this.shippingPrice,
      tax: tax ?? this.tax,
      totalPrice: totalPrice ?? this.totalPrice,
      platformFee: platformFee ?? this.platformFee,
      subtotal: subtotal ?? this.subtotal,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        checkoutItems,
        shippingPrice,
        tax,
        totalPrice,
        platformFee,
        subtotal,
      ];
}
