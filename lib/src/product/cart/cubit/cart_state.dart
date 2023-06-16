part of 'cart_cubit.dart';

class CartState extends Equatable {
  final FormzStatus status;
  final String? errorMessage;
  final List<CartItem> checkoutItems;

  const CartState({
    required this.status,
    required this.errorMessage,
    required this.checkoutItems,
  });

  @override
  List<Object?> get props => [status, errorMessage, checkoutItems];
}
