import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repositories/models/delivery_method.dart';
import 'package:repositories/models/modifier.dart';

class CreateProductRepository {
  final String productId;
  CreateProductRepository({required this.productId});

  Future<void> create({
    required String token,
    required String title,
    String? description,
    required String price,
    List<DeliveryMethod>? deliveryMethods,
    List<Modifier>? modifiers,
  }) async {
    print("clicked?asdas?");
    // Create a Map for your JSON body

    print(productId);
    print(title);
    // print(description);
    print(double.tryParse(price));
    print(Modifier.toJsonList(modifiers));
    print(deliveryMethods?.map((method) => method.toJson()).toList());
    var body = {
      'id': productId,
      'title': title,
      if (description != null) 'description': description,
      'price': double.tryParse(price),
      if (modifiers != []) 'modifiers': Modifier.toJsonList(modifiers),
      if (deliveryMethods != [])
        'delivery_methods':
            deliveryMethods?.map((method) => method.toJson()).toList(),
    };
    print("oh no");
    print("token $token");

    try {
      // Send a POST request
      //var response =
      await http.post(
        Uri.parse('http://192.168.4.117:8084/'), // Replace with your URL
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );
      // print(response.body);
      // print("response");
      // if (response.statusCode != 201) {
      //   print("it was00");
      //   var error = jsonDecode(response.body);
      //   throw CreateProductFailure.fromCode(error['code']);
      // }
    } catch (e) {
      print(e);
      // If the call to the server was unsuccessful, throw a general error
      if (e is CreateProductFailure) {
        throw e;
      } else {
        throw const CreateProductFailure();
      }
    }
  }
}

class CreateProductFailure implements Exception {
  const CreateProductFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory CreateProductFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-address':
        return const CreateProductFailure(
          'Your address was invalid',
        );
      case 'already-exists':
        return const CreateProductFailure(
          'You already have a store. Please refresh the app and try editing it instead.',
        );

      default:
        return const CreateProductFailure();
    }
  }

  final String message;
}
