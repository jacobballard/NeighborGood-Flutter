import 'dart:convert';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:http/http.dart' as http;
import 'package:repositories/models/product.dart';

class CreateProductRepository {
  final String baseUrl;
  final AuthenticationRepository authenticationRepository;

  CreateProductRepository({
    required this.baseUrl,
    required this.authenticationRepository,
  });

  Future<void> createProduct(Product product) async {
    try {
      final authToken = await authenticationRepository.getIdToken();
      final response = await http.post(
        Uri.parse('$baseUrl/create_product'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode == 200) {
        print('Product created successfully');
      } else {
        print('Error creating product: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating product: $e');
    }
  }
}
