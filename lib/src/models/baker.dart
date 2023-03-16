import 'package:pastry/src/models/product.dart';

class Baker {
  final String id;
  final String title;
  final double rating;
  final List<String> images;
  final double price;
  final double latitude;
  final double longitude;
  final List<String> productIds;
  late List<Product> products;
  final String description;

  Baker({
    required this.id,
    required this.title,
    required this.rating,
    required this.images,
    required this.price,
    required this.latitude,
    required this.longitude,
    required this.productIds,
    required this.description,
  }) : this.products = [
          Product(
            bakerDisplayName: "you",
            bakerId: '1',
            id: '1',
            name: 'Chocolate Cake',
            description:
                'A delicious chocolate cake with layers of ganache and buttercream frosting',
            price: 20.99,
            imageUrls: [
              'https://example.com/chocolate_cake1.jpg',
              'https://example.com/chocolate_cake2.jpg',
              'https://example.com/chocolate_cake3.jpg',
            ],
          ),
          Product(
            bakerDisplayName: "you",
            bakerId: '1',
            id: '2',
            name: 'Croissant',
            description: 'A flaky croissant perfect for breakfast or brunch',
            price: 3.99,
            imageUrls: [
              'https://example.com/croissant1.jpg',
              'https://example.com/croissant2.jpg',
            ],
          ),
          Product(
            bakerDisplayName: "you",
            bakerId: '1',
            id: '3',
            name: 'Blueberry Muffin',
            description:
                'A freshly baked blueberry muffin bursting with juicy blueberries',
            price: 2.99,
            imageUrls: [
              'https://example.com/blueberry_muffin1.jpg',
              'https://example.com/blueberry_muffin2.jpg',
              'https://example.com/blueberry_muffin3.jpg',
            ],
          ),
        ];

  factory Baker.fromMap(Map<String, dynamic> map) {
    return Baker(
      id: map['id'] as String,
      title: map['title'] as String,
      rating: map['rating'] as double,
      images: List<String>.from(map['images'] as List<dynamic>),
      price: map['price'] as double,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      productIds: List<String>.from(map['productIds'] as List<dynamic>),
      description: map['description'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'rating': rating,
      'images': images,
      'price': price,
      'latitude': latitude,
      'longitude': longitude,
      'productIds': productIds,
      'description': description,
    };
  }

  static List<Baker> allStores = [
    Baker(
        id: '1',
        title: 'Sweet Bakery',
        rating: 4.5,
        images: ['https://example.com/bakery1.jpg'],
        price: 2.5,
        latitude: 37.7749,
        longitude: -122.4194,
        productIds: ['1', '2', '3'],
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum euismod malesuada. Donec interdum, risus quis bibendum suscipit, arcu magna sagittis nisl, nec porttitor velit velit vel ante.'),
    Baker(
        id: '2',
        title: 'Savory Delights',
        rating: 4.2,
        images: ['https://example.com/delights1.jpg'],
        price: 3.5,
        latitude: 37.7849,
        longitude: -122.4314,
        productIds: ['4', '5'],
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum euismod malesuada. Donec interdum, risus quis bibendum suscipit, arcu magna sagittis nisl, nec porttitor velit velit vel ante.'),
    Baker(
        id: '3',
        title: 'Cupcake Heaven',
        rating: 4.8,
        images: ['https://example.com/cupcake1.jpg'],
        price: 2.0,
        latitude: 37.7649,
        longitude: -122.4314,
        productIds: ['6', '7'],
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum euismod malesuada. Donec interdum, risus quis bibendum suscipit, arcu magna sagittis nisl, nec porttitor velit velit vel ante.'),
    Baker(
        id: '4',
        title: 'Pie in the Sky',
        rating: 4.1,
        images: ['https://example.com/pie1.jpg'],
        price: 4.0,
        latitude: 37.7549,
        longitude: -122.4314,
        productIds: ['8'],
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum euismod malesuada. Donec interdum, risus quis bibendum suscipit, arcu magna sagittis nisl, nec porttitor velit velit vel ante.'),
    Baker(
        id: '5',
        title: 'Cookie Monster',
        rating: 3.9,
        images: ['https://example.com/cookie1.jpg'],
        price: 1.5,
        latitude: 37.7449,
        longitude: -122.4314,
        productIds: ['9', '10'],
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed fermentum euismod malesuada. Donec interdum, risus quis bibendum suscipit, arcu magna sagittis nisl, nec porttitor velit velit vel ante.')
  ];
}
