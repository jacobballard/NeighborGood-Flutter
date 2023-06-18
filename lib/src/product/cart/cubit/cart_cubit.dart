import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:repositories/repositories.dart';

import '../model/cart_item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;

  CartCubit({
    required this.cartRepository,
  }) : super(const CartState());

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

  void addToCart(ProductDetails? productDetails,
      List<CartModifierSelection>? cartModifierSelections) {
    if (productDetails == null) return;
    var checkout_items = state.checkoutItems.toList();

    var unique = checkout_items.any((element) =>
        element.productDetails.id == productDetails.id &&
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
      status: FormzStatus.valid,
      checkoutItems: checkout_items.toList(),
    ));
  }
}
