import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:pastry/src/account/create_store/cubit/store_address_cubit.dart';

import 'package:repositories/models/delivery_method.dart';
import 'package:repositories/models/presentation/cart_delivery_method.dart';
import 'package:repositories/repositories.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;
  final AuthenticationRepository authenticationRepository;
  final StoreAddressCubit firstStoreAddressCubit;
  final StoreAddressCubit secondStoreAddressCubit;
  final CardEditController cardEditController;
  CardFieldInputDetails? _card;
  CartCubit({
    required this.cartRepository,
    required this.firstStoreAddressCubit,
    required this.secondStoreAddressCubit,
    required this.authenticationRepository,
    required this.cardEditController,
  }) : super(const CartState()) {
    // emit(state.copyWith(email: authenticationRepository.user.e))
    //   emit(state.copyWith(
    //       firstStoreAddressCubit: StoreAddressCubit(),
    //       secondStoreAddressCubit: StoreAddressCubit()));
  }

  void resetState() {
    _card = null;
    firstStoreAddressCubit.resetState;
    secondStoreAddressCubit.resetState;
    emit(const CartState());
  }

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

  void sameBillingAsShipping(bool? value) {
    print("same billing as shipping ${value.toString()}");
    emit(state.copyWith(billingSameAsShipping: value));
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

  void useSameAddressBoolChanged(bool? value) {
    emit(state.copyWith(billingSameAsShipping: value));
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

    var cartNeedsShippingAddress = state.checkoutItems.any(
        (element) => element.deliveryMethod == DeliveryMethodType.shipping);
    var cartNeedsDeliveryAddress = state.checkoutItems.any(
        (element) => element.deliveryMethod == DeliveryMethodType.delivery);
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
      cartNeedsShippingAddress: cartNeedsShippingAddress,
      cartNeedsDeliveryAddress: cartNeedsDeliveryAddress,
    );
  }

  bool get isShippingValidated {
    return state.billingSameAsShipping
        ? (firstStoreAddressCubit.state.isValidated)
        : ((firstStoreAddressCubit.state.isValidated) &&
            (secondStoreAddressCubit.state.isValidated));
  }

  Future<void> checkout() async {
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress),
    );

    final billingFirst =
        (!state.cartNeedsDeliveryAddress! && !state.cartNeedsShippingAddress!)
            ? true
            : state.billingSameAsShipping
                ? true
                : false;
    try {
      final transactionId = await cartRepository.purchase(
        items: state.checkoutItems,
        billingAddress: (!state.cartNeedsDeliveryAddress! &&
                !state.cartNeedsShippingAddress!)
            ? firstStoreAddressCubit.toAddress()
            : state.billingSameAsShipping
                ? firstStoreAddressCubit.toAddress()
                : secondStoreAddressCubit.toAddress(),
        shippingAddress: state.billingSameAsShipping
            ? firstStoreAddressCubit.toAddress()
            : (!state.cartNeedsDeliveryAddress! &&
                    !state.cartNeedsShippingAddress!)
                ? secondStoreAddressCubit.toAddress()
                : firstStoreAddressCubit.toAddress(),
        token: await authenticationRepository.getIdToken(),
      );
      print('trans id $transactionId');
      if (!transactionId) {
        if (billingFirst) {
          firstStoreAddressCubit
              .addSuggestedAddress(cartRepository.suggestedBillingAddress);
          secondStoreAddressCubit
              .addSuggestedAddress(cartRepository.suggestedShippingAddress);
        } else {
          firstStoreAddressCubit
              .addSuggestedAddress(cartRepository.suggestedShippingAddress);
          secondStoreAddressCubit
              .addSuggestedAddress(cartRepository.suggestedBillingAddress);
        }
        cartRepository.suggestedBillingAddress = null;
        cartRepository.suggestedShippingAddress = null;
        emit(state.copyWith(status: FormzStatus.valid));
      } else {
        print('else success');
        emit(state.copyWith(
          clientSecret: cartRepository.clientSecret,
          status: FormzStatus.submissionSuccess,
          needsEmailAddress:
              (authenticationRepository.getEmailIfAnyElseNull() == null)
                  ? true
                  : false,
          email: (authenticationRepository.getEmailIfAnyElseNull() == null)
              ? const Email.dirty("")
              : Email.dirty(authenticationRepository.currentUser.email ?? ""),
          shippingPrice: cartRepository.shipping,
          tax: cartRepository.taxes,
          totalPrice: cartRepository.totalCharge,
          subtotal: cartRepository.subtotal,
          platformFee: cartRepository.platformFee,
        ));

        print(state.email.value);
        print('state.email');
      }
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
