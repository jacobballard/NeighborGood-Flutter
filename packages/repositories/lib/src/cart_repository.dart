import 'dart:convert';

import 'package:repositories/models/address.dart';

import '../models/checkout/cart_item.dart';
import 'package:http/http.dart' as http;

class CartRepository {
  Future<String> purchase({
    required List<CartItem> items,
    required String token,
    required Address billingAddress,
    required Address shippingAddress,
  }) async {
    // return '-';

    print('inside');
    var body = {
      'items': items.map((e) => e.toJson()).toList(),
    };

    try {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8090'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        print(data);

        return data['transaction_id'];
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }
}
