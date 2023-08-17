import 'dart:convert';

import 'package:repositories/models/address.dart';

import '../models/checkout/cart_item.dart';
import 'package:http/http.dart' as http;

class CartRepository {
  // Side effects lolz
  late String clientSecret;
  Address? suggestedBillingAddress;
  Address? suggestedShippingAddress;

  // late bool transactionIdAvailable;
  Future<bool> purchase({
    required List<CartItem> items,
    required String token,
    required Address billingAddress,
    required Address shippingAddress,
  }) async {
    // return '-';

    print('inside');
    print(billingAddress.address_line_1!);
    print(shippingAddress.address_line_1);
    print("inside booya");
    var body = {
      'items': items.map((e) => e.toJson()).toList(),
      'address_billing': billingAddress.toJson(),
      'address_shipping': shippingAddress.toJson(),
    };

    try {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8090/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      print(response.statusCode);
      print('code');
      print(response.body);
      if (response.statusCode == 200) {
        print('was 200');
        var data;
        var flag = false;
        try {
          data = jsonDecode(response.body) as Map<String, dynamic>;
          flag = true;
          print(data.toString());
        } catch (e) {
          print(e.toString());
        }

        if (flag && data['code'] == 'suggested_address') {
          print('inside here ${data["code"]}');
          if (data.containsKey('billing')) {
            var adr = data['billing'];
            suggestedBillingAddress = Address(adr['Address1'], adr['Address2'],
                adr['City'], adr['State'], (adr['Zip5'] + '-' + adr['Zip4']));
            print(suggestedBillingAddress!.toJson());
          }
          if (data.containsKey('shipping')) {
            var adr = data['shipping'];
            suggestedShippingAddress = Address(adr['Address1'], adr['Address2'],
                adr['City'], adr['State'], (adr['Zip5'] + '-' + adr['Zip4']));
            print(suggestedShippingAddress!.toJson());
          }
          return false;
        } else {
          print('true');
          clientSecret = data['transaction_id'];
          return true;
        }
        // print(data);

        // return data['transaction_id'];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
