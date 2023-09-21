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
  final bool? cartNeedsShippingAddress;
  final bool? cartNeedsDeliveryAddress;
  final bool needsEmailAddress;
  final Email email;
  final FormzStatus goodToFinishCheckout;
  final String clientSecret;
  final bool billingSameAsShipping;

  const CartState({
    this.clientSecret = '',
    this.needsEmailAddress = true,
    this.email = const Email.pure(),
    this.cartNeedsShippingAddress,
    this.cartNeedsDeliveryAddress,
    this.subtotal = '',
    this.platformFee = '',
    this.totalPrice = '',
    this.shippingPrice = '',
    this.billingSameAsShipping = true,
    this.tax = '',
    this.status = FormzStatus.pure,
    this.goodToFinishCheckout = FormzStatus.pure,
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
    bool? cartNeedsShippingAddress,
    String? clientSecret,
    bool? cartNeedsDeliveryAddress,
    bool? billingSameAsShipping,
    bool? needsEmailAddress,
    FormzStatus? goodToFinishCheckout,
    Email? email,
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
      cartNeedsShippingAddress:
          cartNeedsShippingAddress ?? this.cartNeedsShippingAddress,
      cartNeedsDeliveryAddress:
          cartNeedsDeliveryAddress ?? this.cartNeedsDeliveryAddress,
      billingSameAsShipping:
          billingSameAsShipping ?? this.billingSameAsShipping,
      clientSecret: clientSecret ?? this.clientSecret,
      needsEmailAddress: needsEmailAddress ?? this.needsEmailAddress,
      email: email ?? this.email,
      goodToFinishCheckout: goodToFinishCheckout ?? this.goodToFinishCheckout,
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
        cartNeedsShippingAddress,
        cartNeedsDeliveryAddress,
        billingSameAsShipping,
        clientSecret,
        needsEmailAddress,
        email,
        goodToFinishCheckout,
      ];
}
