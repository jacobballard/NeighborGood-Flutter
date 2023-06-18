import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repositories/models/presentation/cart_delivery_method.dart';
import 'presentation/cart_modifier.dart';

class ProductDetails {
  final String id;
  final String seller_id;
  final String seller_name;
  final double price;
  final String name;
  final String description;
  final List<CartModifier>? modifiers;
  final List<CartDeliveryMethod>? deliveryMethods;
  final List<String> image_urls;

  ProductDetails({
    required this.seller_name,
    required this.id,
    required this.seller_id,
    required this.price,
    required this.name,
    required this.description,
    this.modifiers,
    this.deliveryMethods,
    required this.image_urls,
  });

  factory ProductDetails.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Parse modifiers (assuming it's a list of maps)

    List<CartModifier>? modifiers;
    if (data['modifiers'] != null) {
      print("not nnull");
      modifiers = CartModifier.parseModifiersFromJson(data['modifiers']);
    }

    print(modifiers);
    print('modifiers');
    var test =
        (data['image_urls'] as List).map((item) => item as String).toList();

    print(test);
    print(test.runtimeType);
    print("test");
    // Parse deliveryMethods (assuming it's a list of maps)
    List<CartDeliveryMethod>? deliveryMethods;
    if (data['delivery_methods'] != null) {
      deliveryMethods = List<CartDeliveryMethod>.from(data['delivery_methods']
          .map((item) => CartDeliveryMethod.fromJson(item)));
    }
    // print("past delivery methods");
    // print(data['image_urls']);
    // print(List.from(data['image_urls']));
    // print(List.from(data['image_urls']).runtimeType);
    print(data);
    return ProductDetails(
      seller_name: '',
      id: doc.id,
      seller_id: data['seller_id'] ?? '',
      price: data['price'] ?? 0.0,
      name: data['title'] ?? '',
      description: data['description'] ?? '',
      modifiers: modifiers,
      deliveryMethods: deliveryMethods,
      image_urls:
          (data['image_urls'] as List).map((item) => item as String).toList(),
    );
  }

  ProductDetails copyWith({
    String? id,
    String? seller_id,
    double? price,
    String? name,
    String? description,
    List<CartModifier>? modifiers,
    List<CartDeliveryMethod>? deliveryMethods,
    List<String>? image_urls,
    String? seller_name,
  }) {
    return ProductDetails(
      seller_name: seller_name ?? this.seller_name,
      id: id ?? this.id,
      seller_id: seller_id ?? this.seller_id,
      price: price ?? this.price,
      name: name ?? this.name,
      description: description ?? this.description,
      modifiers: modifiers ?? this.modifiers,
      deliveryMethods: deliveryMethods ?? this.deliveryMethods,
      image_urls: image_urls ?? this.image_urls,
    );
  }
}

class Product {
  final String id;
  final double latitude;
  final double longitude;
  final double price;
  final String seller_id;
  final String name;
  late List<String> image_urls;
  // add other product properties

  Product({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.price,
    required this.seller_id,
  });

  void set_images(List<String> images) {
    this.image_urls = images;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    print("from json");
    double latitude = double.tryParse(
            double.tryParse(json['latitude']?.toString() ?? "0")
                    ?.toStringAsFixed(2) ??
                "0.0") ??
        0.0;
    double longitude = double.tryParse(
            double.tryParse(json['longitude']?.toString() ?? "0")
                    ?.toStringAsFixed(2) ??
                "0.0") ??
        0.0;
    print(latitude);
    print(json);
    return Product(
      latitude: latitude,
      longitude: longitude,
      price: double.tryParse(json['price']) ?? 0.0,
      seller_id: json['seller_id'],
      id: json['id'],
      name: json['title'] as String,
    );
  }
}
