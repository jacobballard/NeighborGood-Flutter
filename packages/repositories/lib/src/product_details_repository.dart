import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product.dart';

class ProductDetailsRepository {
  final String productId;
  final String sellerId;

  ProductDetailsRepository({
    required this.productId,
    required this.sellerId,
  });

  Future<ProductDetails> get() async {
    try {
      // Fetch the product document from Firestore
      DocumentSnapshot productDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(sellerId)
          .collection('products')
          .doc(productId)
          .get();

      print(productDoc.toString());
      print("doc");

      // Convert the document to a ProductDetails object
      ProductDetails productDetails = ProductDetails.fromDocument(productDoc);
      print("returning");
      // Return the product details
      return productDetails;
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions
      throw FetchProductFailure.fromCode(e.code);
    } catch (e) {
      print('Error fetching product details: $e');
      // Handle other exceptions
      throw FetchProductFailure();
    }
  }
}

class FetchProductFailure implements Exception {
  final String message;

  const FetchProductFailure([this.message = 'An unknown exception occurred.']);

  factory FetchProductFailure.fromCode(String code) {
    switch (code) {
      case 'permission-denied':
        return const FetchProductFailure(
            'You do not have permission to access this resource.');
      case 'not-found':
        return const FetchProductFailure(
            'The requested product does not exist.');
      default:
        return const FetchProductFailure();
    }
  }
}
