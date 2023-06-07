class Product {
  String title;
  String description;
  double price;
  int stock;
  List<String> deliveryMethods;
  List<Map<String, dynamic>> productModifiers;

  Product({
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.deliveryMethods,
    required this.productModifiers,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'price': price,
        'stock': stock,
        'delivery_methods': deliveryMethods,
        'product_modifiers': productModifiers,
      };
}
