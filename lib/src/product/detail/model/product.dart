class Product {
  final String id;
  final String bakerId;
  final String bakerDisplayName;
  final String name;
  final String description;
  final double price;
  final List<String> imageUrls;

  Product({
    required this.bakerId,
    required this.bakerDisplayName,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrls,
  });
}
