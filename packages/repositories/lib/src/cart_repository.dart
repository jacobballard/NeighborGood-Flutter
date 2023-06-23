import '../models/checkout/cart_item.dart';

class CartRepository {
  Future<String> purchase({
    required List<CartItem> items,
    required String token,
  }) async {}
}
