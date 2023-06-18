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
        builder: (context, state) {
          if (state.checkoutItems.isEmpty) {
            return Center(child: Text("Your cart is empty"));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.checkoutItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = state.checkoutItems[index];
                    return CartItemWidget(cartItem: cartItem);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.checkoutItems.isEmpty
                      ? null
                      : () {
                          // Place your checkout logic here
                          // Example:
                          // context.read<CartCubit>().checkout();
                        },
                  child: Text("Checkout"),
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

  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          cartItem.productDetails.image_urls.first,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(cartItem.productDetails.name),
        subtitle: Text(cartItem.productDetails.seller_name),
        trailing: DropdownButton<int>(
          value: cartItem.quantity,
          onChanged: (newValue) {
            // You need to update the CartCubit with the new quantity
            // Example:
            // context.read<CartCubit>().updateQuantity(cartItem, newValue);
          },
          items: List.generate(101, (index) => index)
              .map<DropdownMenuItem<int>>((value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
      ),
    );
  }
}
