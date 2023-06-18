import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/product/cart/cubit/cart_cubit.dart';
import 'package:pastry/src/product/cart/model/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state.checkoutItems.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.checkoutItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = state.checkoutItems[index];
                    return CartItemWidget(
                      cartItem: cartItem,
                      index: index,
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.checkoutItems.isEmpty
                      ? null
                      : () {
                          // Place your checkout logic here
                          // Example:
                          // context.read<CartCubit>().checkout();
                        },
                  child: const Text("Checkout"),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  final int index;

  const CartItemWidget({Key? key, required this.cartItem, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    context.read<CartCubit>().removeFromCart(index);
                  },
                ),
                const SizedBox(width: 8),
                Image.network(
                  cartItem.productDetails.image_urls.first,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartItem.productDetails.name),
                      Text(cartItem.productDetails.seller_name),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text('\$${cartItem.productDetails.price.toStringAsFixed(2)}'),
                const SizedBox(
                  width: 8,
                ),
                DropdownButton<int>(
                  value: cartItem.quantity,
                  onChanged: (newValue) {
                    context
                        .read<CartCubit>()
                        .updateCartQuantity(index, newValue);
                  },
                  items: List.generate(101, (index) => index + 1)
                      .map<DropdownMenuItem<int>>((value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  width: 8,
                ),
                //TODO : Just pass the selected modifiers
                // back into the product detail view...
                // IconButton(
                //   icon: const Icon(Icons.edit),
                //   onPressed: () {
                //     // Implement edit logic
                //     // Example:
                //     // Navigate to edit screen
                //   },
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
