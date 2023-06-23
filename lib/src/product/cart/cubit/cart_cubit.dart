import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:repositories/models/delivery_method.dart';
import 'package:repositories/models/presentation/cart_delivery_method.dart';
import 'package:repositories/repositories.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;

  CartCubit({
    required this.cartRepository,
  }) : super(const CartState()); // {
  //   _computeStatus();
  // }

  void updateCartQuantity(int position, int? newValue) {
    if (newValue == null) return;

    List<CartItem> updatedItems = List.from(state.checkoutItems);
    CartItem updatedItem = updatedItems[position].copyWith(quantity: newValue);

    updatedItems[position] = updatedItem;

    emit(state.copyWith(checkoutItems: updatedItems));
  }

  void removeFromCart(int position) {
    List<CartItem> updatedItems = List.from(state.checkoutItems);

    updatedItems.removeAt(position);

    emit(state.copyWith(checkoutItems: updatedItems));
  }

  void selectedDeliveryMethodChanged(int index, CartDeliveryMethod? value) {
    var checkoutItems = state.checkoutItems;
    var item = checkoutItems[index];

    checkoutItems[index] = item.copyWith(deliveryMethod: value?.type);

    CartState newState = _computeStatus();

    emit(newState.copyWith(checkoutItems: checkoutItems.toList()));
  }

  void addToCart(
      ProductDetails? productDetails,
      List<CartModifierSelection>? cartModifierSelections,
      String? displayPrice) {
    if (productDetails == null) return;

    if (displayPrice != null) {
      productDetails =
          productDetails.copyWith(price: double.tryParse(displayPrice));
    }
    var checkout_items = state.checkoutItems.toList();

    var unique = checkout_items.any((element) =>
        element.productDetails.id == productDetails?.id &&
        element.cartModfiierSelections == cartModifierSelections);

    if (unique) {
      CartItem item;
      for (int i = 0; i < checkout_items.length; i += 1) {
        item = checkout_items[i];
        if (item.cartModfiierSelections == cartModifierSelections &&
            item.productDetails.id == productDetails.id) {
          var quant = checkout_items[i].quantity + 1;
          checkout_items[i] = checkout_items[i].copyWith(quantity: quant);
        }
      }
    } else {
      checkout_items.add(CartItem(
          productDetails: productDetails,
          quantity: 1,
          cartModfiierSelections: cartModifierSelections));
    }

    print("Checkout items $checkout_items");

    emit(state.copyWith(
      status: FormzStatus.invalid,
      checkoutItems: checkout_items.toList(),
    ));
  }

  void cartTotals() {
    print("check");
    emit(_computeStatus());
  }

  CartState _computeStatus() {
    double totalShipping = 0.0;
    double totalPrice = 0.0;
    double totalPlatformFee = 0.0;
    double totalTax = 0.0;

    bool allDeliveriesFilledIn =
        state.checkoutItems.every((element) => element.deliveryMethod != null);

    var cartNeedsAddress = state.checkoutItems.any((element) =>
        element.deliveryMethod == DeliveryMethodType.shipping ||
        element.deliveryMethod == DeliveryMethodType.delivery);

    for (CartItem item in state.checkoutItems) {
      // if (item.deliveryMethod == null) break;
      double itemShippingFee = 0.0;
      if (item.deliveryMethod != null) {
        itemShippingFee = double.tryParse(item.productDetails.deliveryMethods!
                .where((element) => element.type == item.deliveryMethod)
                .first
                .fee) ??
            0;
      }
      totalShipping += itemShippingFee * item.quantity;

      double itemPrice = item.productDetails.price;
      totalPrice += itemPrice * item.quantity;
    }

    // Assuming a 5% platform fee
    totalPlatformFee = totalPrice * 0.05;

    // Assuming a 10% tax on the subtotal
    totalTax = totalPrice * 0.06;

    // Return updated state
    return state.copyWith(
      subtotal: totalPrice.toStringAsFixed(2),
      shippingPrice: totalShipping.toStringAsFixed(2),
      totalPrice: (totalPrice + totalShipping + totalPlatformFee + totalTax)
          .toStringAsFixed(2),
      platformFee: totalPlatformFee.toStringAsFixed(2),
      tax: totalTax.toStringAsFixed(2),
      status: allDeliveriesFilledIn ? FormzStatus.valid : FormzStatus.invalid,
      cartNeedsAddress: cartNeedsAddress,
    );
  }

  Future<void> checkout() async {}
}
