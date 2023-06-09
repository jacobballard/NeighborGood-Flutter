import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductRepository {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Add this line
  // final String cloudFunctionUrl;

  // ProductRepository({required this.cloudFunctionUrl});

  Future<List<Product>> getAllProducts({
    required String token,
    required double lat,
    required double lng,
    double radius = 10,
    bool filterShipping = false,
    bool filterDelivery = false,
    bool filterPickup = false,
  }) async {
    print("called");
    final response = await http.post(
      Uri.parse(
          "https://us-central1-pastry-6b817.cloudfunctions.net/get_products_list"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        'lat': lat,
        'lng': lng,
        'radius': radius,
        'filter_shipping': filterShipping,
        'filter_delivery': filterDelivery,
        'filter_pickup': filterPickup,
      }),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      print(data);
      final products = (data['products'] as List)
          .map((productJson) =>
              Product.fromJson(productJson as Map<String, dynamic>))
          .toList();

      for (var product in products) {
        final doc = await _firestore
            .collection('users')
            .doc(product.seller_id)
            .collection('products')
            .doc(product.id)
            .get();

        if (doc.exists) {
          final imageUrls = List<String>.from(doc['image_urls'] ?? []);
          product.set_images(imageUrls);
        }
      }
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
