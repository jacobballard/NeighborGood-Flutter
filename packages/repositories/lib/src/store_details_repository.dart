import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repositories/src/product_details_repository.dart';

import '../models/product.dart';
import '../models/store_detail.dart';

class StoreDetailsRepository {
  String? sellerId;
  final String? storeId;

  StoreDetailsRepository({
    this.sellerId,
    this.storeId,
  });

  Future<StoreDetail> get() async {
    if (storeId != null) {}
    if (sellerId != null) {
      try {
        // Fetch the store document from Firestore
        DocumentSnapshot storeDoc = await FirebaseFirestore.instance
            .collection('stores')
            .doc(sellerId)
            .get();

        print(storeDoc.toString());
        print("doc");

        // Convert the document to a StoreDetail object
        StoreDetail storeDetails = StoreDetail.fromDocument(storeDoc);

        print("returning");

        // Return the store details
        return storeDetails;
      } on FirebaseException catch (e) {
        // Handle Firebase exceptions
        throw FetchStoreFailure.fromCode(e.code);
      } catch (e) {
        print('Error fetching store details: $e');
        // Handle other exceptions
        throw FetchStoreFailure();
      }
    }
  }

  Future<List<Product>> getProducts() async {
    try {
      // Fetch the products collection from Firestore
      QuerySnapshot productCollection = await FirebaseFirestore.instance
          .collection('stores')
          .doc(sellerId)
          .collection('products')
          .get();

      print(productCollection.docs.toString());
      print("docs");

      // Convert each document to a ProductDetails object
      List<Product> productDetails = productCollection.docs
          .map((doc) => Product.fromJson(doc as Map<String, dynamic>))
          .toList();

      print("returning");

      // Return the list of product details
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

class FetchStoreFailure implements Exception {
  final String message;

  const FetchStoreFailure([this.message = 'An unknown exception occurred.']);

  factory FetchStoreFailure.fromCode(String code) {
    switch (code) {
      case 'permission-denied':
        return const FetchStoreFailure(
            'You do not have permission to access this resource.');
      case 'not-found':
        return const FetchStoreFailure('The requested store does not exist.');
      default:
        return const FetchStoreFailure();
    }
  }
}
