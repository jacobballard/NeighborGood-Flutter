import 'package:equatable/equatable.dart';
import 'package:repositories/models/checkout/cart_modifier_selection.dart';
import 'package:repositories/models/delivery_method.dart';

class CartItem extends Equatable {
  final String productId;
  final String sellerId;
  final String image;
  final int quantity;
  final String productTitle;
  final String price;
  final DeliveryMethodType deliveryMethod;
  final List<CartModifierSelection>? cartModfiierSelections;

  const CartItem({
    required this.productId,
    required this.sellerId,
    required this.image,
    required this.quantity,
    required this.productTitle,
    required this.price,
    required this.deliveryMethod,
    this.cartModfiierSelections,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'seller_id': sellerId,
      'quantity': quantity,
      'delivery_method': enumToString(deliveryMethod),
      'modifiers': CartModifierSelection.cartModifierSelectionToJson(
          cartModfiierSelections ?? []),
    };
  }

  @override
  List<Object?> get props => [
        productId,
        sellerId,
        image,
        quantity,
        productTitle,
        price,
        deliveryMethod,
        cartModfiierSelections,
      ];

  CartItem copyWith({
    String? productId,
    String? sellerId,
    String? image,
    int? quantity,
    String? productTitle,
    String? price,
    DeliveryMethodType? deliveryMethod,
    List<CartModifierSelection>? cartModfiierSelections,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      sellerId: sellerId ?? this.sellerId,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      productTitle: productTitle ?? this.productTitle,
      price: price ?? this.price,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      cartModfiierSelections:
          cartModfiierSelections ?? this.cartModfiierSelections,
    );
  }
}
