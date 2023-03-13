class Baker {
  final String id;
  final String title;
  final double rating;
  final List<String> images;
  final double price;
  final double distance;

  Baker({
    required this.id,
    required this.title,
    required this.rating,
    required this.images,
    required this.price,
    required this.distance,
  });

  static List<Baker> allStores = [
    Baker(
      id: '1',
      title: 'Sweet Bakery',
      rating: 4.5,
      images: ['https://example.com/bakery1.jpg'],
      price: 2.5,
      distance: 2.5,
    ),
    Baker(
      id: '2',
      title: 'Savory Delights',
      rating: 4.2,
      images: ['https://example.com/delights1.jpg'],
      price: 3.5,
      distance: 1.7,
    ),
    Baker(
      id: '3',
      title: 'Cupcake Heaven',
      rating: 4.8,
      images: ['https://example.com/cupcake1.jpg'],
      price: 2.0,
      distance: 3.2,
    ),
    Baker(
      id: '4',
      title: 'Pie in the Sky',
      rating: 4.1,
      images: ['https://example.com/pie1.jpg'],
      price: 4.0,
      distance: 5.0,
    ),
    Baker(
      id: '5',
      title: 'Cookie Monster',
      rating: 3.9,
      images: ['https://example.com/cookie1.jpg'],
      price: 1.5,
      distance: 0.9,
    ),
    Baker(
      id: '6',
      title: 'Bread & Butter',
      rating: 4.0,
      images: ['https://example.com/bread1.jpg'],
      price: 2.5,
      distance: 4.2,
    ),
    Baker(
      id: '7',
      title: 'Fruit Stand',
      rating: 4.7,
      images: ['https://example.com/fruit1.jpg'],
      price: 1.0,
      distance: 1.0,
    ),
    Baker(
      id: '8',
      title: 'Smoothie Bar',
      rating: 4.3,
      images: ['https://example.com/smoothie1.jpg'],
      price: 3.0,
      distance: 3.8,
    ),
    Baker(
      id: '9',
      title: 'Juice Joint',
      rating: 4.6,
      images: ['https://example.com/juice1.jpg'],
      price: 2.5,
      distance: 2.1,
    ),
    Baker(
      id: '10',
      title: 'Coffee Corner',
      rating: 4.4,
      images: ['https://example.com/coffee1.jpg'],
      price: 3.5,
      distance: 0.5,
    ),
  ];
}
