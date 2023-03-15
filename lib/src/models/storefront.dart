import 'package:pastry/src/models/product.dart';

class Storefront {
  final String id;
  final String displayName;
  final double deliveryRange;
  final double pickupLatitude;
  final double pickupLongitude;
  final List<String> productIds;
  late List<Product> products;
  final String description;
  final List<String> imageUrls;
  final String email;
  final String phone;

  // Main constructor
  Storefront({
    required this.id,
    required this.productIds,
    required this.displayName,
    required this.deliveryRange,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.description,
    required this.imageUrls,
    required this.email,
    required this.phone,
  });

  // Named constructor to create a Storefront object from a map (e.g., from Firestore)
  factory Storefront.fromMap(Map<String, dynamic> map) {
    return Storefront(
      id: map['id'],
      displayName: map['display_name'],
      deliveryRange: map['delivery_range'],
      pickupLatitude: map['pickup_latitude'],
      pickupLongitude: map['pickup_longitude'],
      description: map['description'],
      imageUrls: List<String>.from(map['image_urls']),
      email: map['email'],
      phone: map['phone'],
      productIds: map['product_ids'],
    );
  }

  // Method to convert the Storefront object to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'display_name': displayName,
      'delivery_range': deliveryRange,
      'pickup_latitude': pickupLatitude,
      'pickup_longitude': pickupLongitude,
      'description': description,
      'image_urls': imageUrls,
      'email': email,
      'phone': phone,
      'product_ids': productIds,
    };
  }
}
