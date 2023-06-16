import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repositories/models/address.dart';
import 'package:repositories/models/delivery_method.dart';

class CreateStoreRepository {
  Future<void> create(
      {required String token,
      required String title,
      String? description,
      required Address address,
      List<DeliveryMethod>? deliveryMethods}) async {
    print("clicked??");
    // Create a Map for your JSON body
    var body = {
      'title': title,
      'description': description,
      'address': address.toJson(),
      'delivery_methods':
          deliveryMethods?.map((method) => method.toJson()).toList(),
    };

    print("token $token");

    try {
      // Send a POST request
      var response = await http.post(
        Uri.parse(
            // 'https://us-central1-pastry-6b817.cloudfunctions.net/create_store'), // Replace with your URL
            'http://192.168.4.25:8085/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );
      print(response.body);
      print("response");

      // if (response.statusCode != 201) {
      //   print("it was00");
      //   var error = jsonDecode(response.body);
      //   throw CreateStoreFailure.fromCode(error['code']);
      // }
    } catch (e) {
      print(e);
      // If the call to the server was unsuccessful, throw a general error
      if (e is CreateStoreFailure) {
        throw e;
      } else {
        throw const CreateStoreFailure();
      }
    }
  }
}

class CreateStoreFailure implements Exception {
  const CreateStoreFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory CreateStoreFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-address':
        return const CreateStoreFailure(
          'Your address was invalid',
        );
      case 'already-exists':
        return const CreateStoreFailure(
          'You already have a store. Please refresh the app and try editing it instead.',
        );

      default:
        return const CreateStoreFailure();
    }
  }

  final String message;
}
