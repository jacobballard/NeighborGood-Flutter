import 'package:flutter/material.dart';
import 'package:pastry/src/product/detail/view/product_detail.dart';
import 'package:pastry/src/product/list/model/product_summary.dart';
import 'package:repositories/models/product.dart';

class ProductGridView extends StatelessWidget {
  final List<Product> products;

  const ProductGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    // return SingleChildScrollView(
    //   physics: const ClampingScrollPhysics(),
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.only(top: kToolbarHeight),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 5 : 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        final product = products[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
          },
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Image.network(
                    product.image_urls[0],
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "\$${product.price.toString()}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
