import 'package:cloud_firestore/cloud_firestore.dart';

class ProductSummary {
  final String productID;
  final String storeID;
  final String productName;
  final double basePrice;
  final String firstImageURL;

  ProductSummary({
    required this.productID,
    required this.storeID,
    required this.productName,
    required this.basePrice,
    required this.firstImageURL,
  });

  factory ProductSummary.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ProductSummary(
      productID: doc.id,
      storeID: data['storeID'],
      productName: data['productName'],
      basePrice: data['basePrice'].toDouble(),
      firstImageURL: data['imageURLs'][0],
    );
  }
}
