// class Product {
//   String title;
//   String description;
//   double price;
//   int stock;
//   List<String> deliveryMethods;
//   List<Map<String, dynamic>> productModifiers;

//   Product({
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.stock,
//     required this.deliveryMethods,
//     required this.productModifiers,
//   });

//   Map<String, dynamic> toJson() => {
//         'title': title,
//         'description': description,
//         'price': price,
//         'stock': stock,
//         'delivery_methods': deliveryMethods,
//         'product_modifiers': productModifiers,
//       };
// }

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
