import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repositories/models/address.dart';
import 'package:repositories/models/delivery_method.dart';

import '../models/business_type.dart';

class CreateStoreRepository {
  Address? suggestedAddress;

  Future<void> create(
      {required String token,
      required String title,
      // required
      required BusinessType type,
      String? ssnLastFour,
      String? firstName,
      String? lastName,
      String? birthDay,
      String? birthYear,
      String? birthMonth,
      String? companyName,
      String? companyTaxId,
      String? description,
      required Address address,
      List<DeliveryMethod>? deliveryMethods}) async {
    print("clicked??");
    // Create a Map for your JSON body
    bool isBusiness = type == BusinessType.business;
    var body = {
      'title': title,
      'description': description,
      'address': address.toJson(),
      'delivery_methods':
          deliveryMethods?.map((method) => method.toJson()).toList(),
      if (isBusiness) 'type': 'business',
      if (!isBusiness) 'type': 'individual',
      if (isBusiness) 'company_name': companyName,
      if (isBusiness) 'company_tax_id': companyTaxId,
      if (!isBusiness) 'first_name': firstName,
      if (!isBusiness) 'last_name': lastName,
      if (!isBusiness) 'birth_day': birthDay,
      if (!isBusiness) 'birth_month': birthMonth,
      if (!isBusiness) 'birth_year': birthYear,
      if (!isBusiness) 'ssn_last_four': ssnLastFour,
    };

    print("token $token");

    try {
      // Send a POST request
      var response = await http.post(
        Uri.parse(
            // 'https://us-central1-pastry-6b817.cloudfunctions.net/create_store'), // Replace with your URL
            'http://192.168.4.117:8085'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );
      print(response.body);
      print("response");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        print(data.toString());
        if (data['code'] == 'suggested_address') {
          if (data.containsKey('suggested_address')) {
            var adr = data['suggested_address'];
            suggestedAddress = Address(adr['Address1'], adr['Address2'],
                adr['City'], adr['State'], (adr['Zip5'] + '-' + adr['Zip4']));
            print(suggestedAddress!.toJson());
          }
        }
      }

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
