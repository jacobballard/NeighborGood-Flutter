// import 'package:flutter/material.dart';
// import 'package:pastry/src/models/product.dart';

// class ProductDetailPage extends StatefulWidget {
//   final Product product;

//   const ProductDetailPage({Key? key, required this.product}) : super(key: key);

//   @override
//   _ProductDetailPageState createState() => _ProductDetailPageState();
// }

// class _ProductDetailPageState extends State<ProductDetailPage> {
//   int _currentPage = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.product.name),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: PageView(
//               children: widget.product.imageUrls.map((imageUrl) {
//                 return Image.network(imageUrl);
//               }).toList(),
//               onPageChanged: (int page) {
//                 setState(() {
//                   _currentPage = page;
//                 });
//               },
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.arrow_back),
//                 onPressed: () {
//                   setState(() {
//                     _currentPage =
//                         (_currentPage - 1) % widget.product.imageUrls.length;
//                   });
//                 },
//               ),
//               Text('${_currentPage + 1}/${widget.product.imageUrls.length}'),
//               IconButton(
//                 icon: Icon(Icons.arrow_forward),
//                 onPressed: () {
//                   setState(() {
//                     _currentPage =
//                         (_currentPage + 1) % widget.product.imageUrls.length;
//                   });
//                 },
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   widget.product.name,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 24.0,
//                   ),
//                 ),
//                 SizedBox(height: 8.0),
//                 Text(
//                   '\$${widget.product.price}',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20.0,
//                   ),
//                 ),
//                 SizedBox(height: 8.0),
//                 Text(
//                   widget.product.description,
//                   style: TextStyle(
//                     fontSize: 16.0,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   // TODO: Add to cart logic
//                 },
//                 child: Text('Add to cart'),
//               ),
//               SizedBox(width: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   // TODO: Buy now logic
//                 },
//                 child: Text('Buy now'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:pastry/src/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 300,
              child: PageView.builder(
                itemCount: product.imageUrls.length,
                itemBuilder: (context, index) {
                  final imageUrl = product.imageUrls[index];
                  return Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Add to cart'),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Buy now'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
