// import 'package:flutter/material.dart';
// import '../models/product.dart';
// import 'all_bakers.dart';
// import 'all_products.dart';
// import '../models/baker.dart';

// class StoreDetailPage extends StatelessWidget {
//   final Baker store;

//   StoreDetailPage({required this.store});

//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> imageWidgets = store.images.map((image) {
//       return Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
//         ),
//       );
//     }).toList();

//     final List<Product> products = [
//       Product(
//         id: '1',
//         name: 'Cupcake',
//         description: 'Delicious cupcake with sprinkles',
//         price: 2.50,
//         imageUrls: ['https://example.com/cupcake.jpg'],
//       ),
//       Product(
//         id: '2',
//         name: 'Chocolate Chip Cookie',
//         description: 'Soft and chewy cookie with chocolate chips',
//         price: 1.50,
//         imageUrls: ['https://example.com/cookie.jpg'],
//       ),
//       Product(
//         id: '3',
//         name: 'Brownie',
//         description: 'Rich and fudgy brownie',
//         price: 3.00,
//         imageUrls: ['https://example.com/brownie.jpg'],
//       ),
//       Product(
//         id: '4',
//         name: 'Apple Pie',
//         description: 'Classic apple pie with flaky crust',
//         price: 4.50,
//         imageUrls: ['https://example.com/pie.jpg'],
//       ),
//     ];

//     return Scaffold(
//       appBar: AppBar(title: Text(store.title)),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 200.0,
//             child: PageView(
//               children: imageWidgets,
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: products.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final product = products[index];
//                 return ListTile(
//                   leading: Image.network(
//                     product.imageUrls[0],
//                     height: 50.0,
//                     width: 50.0,
//                     fit: BoxFit.cover,
//                   ),
//                   title: Text(product.name),
//                   subtitle: Text(product.description),
//                   trailing: Text('\$${product.price.toStringAsFixed(2)}'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:pastry/src/models/product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pastry/src/ui/product_grid_view.dart';
import '../models/baker.dart';

class StoreDetailPage extends StatelessWidget {
  final Baker store;

  const StoreDetailPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(store.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Store header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "@${store.title}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "ETA: ${store.latitude} mins",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Direct Messages"),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.tiktok),
                        tooltip: "Social Media Profile 1",
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.instagram),
                        tooltip: "Social Media Profile 2",
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.pinterest),
                        tooltip: "Social Media Profile 3",
                      ),
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),

            // Product list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "All Products",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            // ProductGridView(products: store.products),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: store.products.length,
              itemBuilder: (context, index) {
                final Product product = store.products[index];
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            product.imageUrls[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "\$${product.price.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
