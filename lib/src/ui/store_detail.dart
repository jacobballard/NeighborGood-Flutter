import 'package:flutter/material.dart';
import '../models/product.dart';
import 'all_bakers.dart';
import 'all_products.dart';
import '../models/baker.dart';

class StoreDetailPage extends StatelessWidget {
  final Baker store;

  StoreDetailPage({required this.store});

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageWidgets = store.images.map((image) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        ),
      );
    }).toList();

    final List<Product> products = [
      Product(
        id: '1',
        name: 'Cupcake',
        description: 'Delicious cupcake with sprinkles',
        price: 2.50,
        imageUrl: 'https://example.com/cupcake.jpg',
      ),
      Product(
        id: '2',
        name: 'Chocolate Chip Cookie',
        description: 'Soft and chewy cookie with chocolate chips',
        price: 1.50,
        imageUrl: 'https://example.com/cookie.jpg',
      ),
      Product(
        id: '3',
        name: 'Brownie',
        description: 'Rich and fudgy brownie',
        price: 3.00,
        imageUrl: 'https://example.com/brownie.jpg',
      ),
      Product(
        id: '4',
        name: 'Apple Pie',
        description: 'Classic apple pie with flaky crust',
        price: 4.50,
        imageUrl: 'https://example.com/pie.jpg',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(store.title)),
      body: Column(
        children: [
          SizedBox(
            height: 200.0,
            child: PageView(
              children: imageWidgets,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];
                return ListTile(
                  leading: Image.network(
                    product.imageUrl,
                    height: 50.0,
                    width: 50.0,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
