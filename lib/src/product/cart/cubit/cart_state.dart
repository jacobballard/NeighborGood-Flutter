part of 'cart_cubit.dart';

class CartState extends Equatable {
  final FormzStatus status;
  final String? errorMessage;
  final List<CartItem> checkoutItems;

  const CartState({
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.checkoutItems = const [],
  });

  CartState copyWith({
    FormzStatus? status,
    String? errorMessage,
    List<CartItem>? checkoutItems,
  }) {
    return CartState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      checkoutItems: checkoutItems ?? this.checkoutItems,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, checkoutItems];
}
