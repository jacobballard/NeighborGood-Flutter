// import 'package:flutter/material.dart';

// class Product {
//   final String name;
//   final String description;
//   final String imageUrl;

//   const Product({
//     required this.name,
//     required this.description,
//     required this.imageUrl,
//   });
// }

// class MyAllProductsPage extends StatelessWidget {
//   final List<Product> products = [
//     Product(
//       name: 'Product 1',
//       description: 'This is the description for product 1',
//       imageUrl: 'https://example.com/product1.jpg',
//     ),
//     Product(
//       name: 'Product 2',
//       description: 'This is the description for product 2',
//       imageUrl: 'https://example.com/product2.jpg',
//     ),
//     Product(
//       name: 'Product 3',
//       description: 'This is the description for product 3',
//       imageUrl: 'https://example.com/product3.jpg',
//     ),
//     // Add more products here
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Products'),
//       ),
//       body: GridView.builder(
//         padding: EdgeInsets.all(8.0),
//         itemCount: products.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: MediaQuery.of(context).size.width > 600 ? 5 : 2,
//           crossAxisSpacing: 8.0,
//           mainAxisSpacing: 8.0,
//         ),
//         itemBuilder: (BuildContext context, int index) {
//           final product = products[index];
//           return InkWell(
//             onTap: () {
//               // Navigate to product details page
//             },
//             child: Card(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Expanded(
//                     child: Image.network(
//                       product.imageUrl,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           product.name,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 8.0),
//                         Text(
//                           product.description,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pastry/src/screens/product_detail.dart';
import 'package:pastry/src/product/view/product_grid_view.dart';

import '../models/product.dart';

class MyAllProductsPage extends StatefulWidget {
  @override
  _MyAllProductsPageState createState() => _MyAllProductsPageState();
}

class _MyAllProductsPageState extends State<MyAllProductsPage> {
  final List<Product> _allProducts = [
    Product(
      bakerDisplayName: "you",
      bakerId: '1',
      id: '1',
      name: 'Cupcake',
      description: 'Delicious cupcake with sprinkles',
      price: 2.50,
      imageUrls: ['https://example.com/cupcake.jpg'],
    ),
    Product(
      bakerDisplayName: "you",
      bakerId: '1',
      id: '2',
      name: 'Chocolate Chip Cookie',
      description: 'Soft and chewy cookie with chocolate chips',
      price: 1.50,
      imageUrls: ['https://example.com/cookie.jpg'],
    ),
    Product(
      bakerDisplayName: "you",
      bakerId: '1',
      id: '3',
      name: 'Brownie',
      description: 'Rich and fudgy brownie',
      price: 3.00,
      imageUrls: ['https://example.com/brownie.jpg'],
    ),
    Product(
      bakerDisplayName: "you",
      bakerId: '1',
      id: '4',
      name: 'Apple Pie',
      description: 'Classic apple pie with flaky crust',
      price: 4.50,
      imageUrls: ['https://example.com/pie.jpg'],
    ),
  ];

  List<Product> _filteredProducts = [];

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredProducts = _allProducts;
  }

  void _filterProducts() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text('Filter by price'),
                  onTap: () {
                    // TODO: Filter by price
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Filter by distance'),
                  onTap: () {
                    // TODO: Filter by distance
                    Navigator.pop(context);
                  },
                ),
                // Add more filter options here
              ],
            ),
          ),
        );
      },
    );
  }

  void _searchProducts(String query) {
    setState(() {
      _searchQuery = query;
      _filteredProducts = _allProducts.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: _SearchDelegate(_searchProducts),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _filterProducts,
          ),
        ],
      ),
      body: ProductGridView(products: _filteredProducts),
      // body: GridView.builder(
      //   padding: EdgeInsets.only(top: kToolbarHeight),
      //   itemCount: _filteredProducts.length,
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: MediaQuery.of(context).size.width > 600 ? 5 : 2,
      //     crossAxisSpacing: 8.0,
      //     mainAxisSpacing: 8.0,
      //   ),
      //   itemBuilder: (BuildContext context, int index) {
      //     final product = _filteredProducts[index];
      //     return InkWell(
      //       onTap: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => ProductDetailPage(product: product),
      //           ),
      //         );
      //       },
      //       child: Card(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.stretch,
      //           children: <Widget>[
      //             Expanded(
      //               child: Image.network(
      //                 product.imageUrls[0],
      //                 fit: BoxFit.cover,
      //               ),
      //             ),
      //             Padding(
      //               padding: EdgeInsets.all(8.0),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: <Widget>[
      //                   Text(
      //                     product.name,
      //                     style: TextStyle(
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                   ),
      //                   SizedBox(height: 8.0),
      //                   Text(
      //                     product.description,
      //                     maxLines: 2,
      //                     overflow: TextOverflow.ellipsis,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

class _SearchDelegate extends SearchDelegate<String> {
  final ValueChanged<String> onSearch;

  _SearchDelegate(this.onSearch);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.light,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
