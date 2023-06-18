import 'package:equatable/equatable.dart';
import 'package:repositories/models/checkout/cart_modifier_selection.dart';
import 'package:repositories/models/delivery_method.dart';
import 'package:repositories/models/product.dart';

class CartItem extends Equatable {
  final ProductDetails productDetails;
  final List<CartModifierSelection>? cartModfiierSelections;
  final int quantity;
  final DeliveryMethodType? deliveryMethod;

  const CartItem({
    required this.productDetails,
    required this.quantity,
    this.deliveryMethod,
    this.cartModfiierSelections,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productDetails.id,
      'seller_id': productDetails.seller_id,
      'quantity': quantity,
      'delivery_method': enumToString(deliveryMethod!),
      'modifiers': CartModifierSelection.cartModifierSelectionToJson(
          cartModfiierSelections ?? []),
    };
  }

  @override
  List<Object?> get props => [
        quantity,
        productDetails,
        deliveryMethod,
        cartModfiierSelections,
      ];

  CartItem copyWith({
    ProductDetails? productDetails,
    int? quantity,
    DeliveryMethodType? deliveryMethod,
    List<CartModifierSelection>? cartModfiierSelections,
  }) {
    return CartItem(
      quantity: quantity ?? this.quantity,
      productDetails: productDetails ?? this.productDetails,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      cartModfiierSelections:
          cartModfiierSelections ?? this.cartModfiierSelections,
    );
  }
}
