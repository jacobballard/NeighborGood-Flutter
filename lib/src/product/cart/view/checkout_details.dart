import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pastry/src/product/cart/cubit/cart_cubit.dart';
import 'package:repositories/models/checkout/cart_item.dart';
import 'package:repositories/models/delivery_method.dart';
import 'package:repositories/models/presentation/cart_delivery_method.dart';
import 'package:repositories/repositories.dart';

class CheckoutDetailsPage extends StatelessWidget {
  const CheckoutDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalize Checkout'),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                      state.errorMessage ?? "Error: Please refresh your cart"),
                ),
              );
          }
          if (state.status.isSubmissionSuccess) {
            // Navigator.of(context, rootNavigator: false).push(
            //           MaterialPageRoute(
            //             builder: (context) => PaymentDeta(),
            //           ),
            //         );
          }
        },
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
                    final checkoutItem = state.checkoutItems[index];
                    return CheckoutItemWidget(
                      cartItem: checkoutItem,
                      index: index,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal:'),
                        Text('\$${state.subtotal}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Delivery:'),
                        Text('\$${state.shippingPrice}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Platform Fee:'),
                        Text('\$${state.platformFee}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tax:'),
                        Text('~\$${state.tax}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:'),
                        Text('\$${state.totalPrice}'),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.status.isValid
                      ? () async {
                          await context.read<CartCubit>().checkout();
                        }
                      : null,
                  child: state.status.isSubmissionInProgress
                      ? const CircularProgressIndicator()
                      : const Text("Finish checkout"),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CheckoutItemWidget extends StatefulWidget {
  final CartItem cartItem;
  final int index;

  const CheckoutItemWidget(
      {Key? key, required this.cartItem, required this.index})
      : super(key: key);

  @override
  _CheckoutItemWidgetState createState() => _CheckoutItemWidgetState();
}

class _CheckoutItemWidgetState extends State<CheckoutItemWidget> {
  CartDeliveryMethod? _selectedDeliveryMethod;

  @override
  void initState() {
    super.initState();

    // Initialize _selectedDeliveryMethod with the existing delivery method of the cart item
    if (widget.cartItem.deliveryMethod != null) {
      var existingDeliveryMethod =
          widget.cartItem.productDetails.deliveryMethods!.firstWhere(
        (method) => method.type == widget.cartItem.deliveryMethod,
      );

      _selectedDeliveryMethod = existingDeliveryMethod;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<CartDeliveryMethod> _deliveryMethods =
        widget.cartItem.productDetails.deliveryMethods!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.cartItem.productDetails.image_urls.first,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.cartItem.productDetails.name),
                      Text(widget.cartItem.productDetails.seller_name),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        '\$${widget.cartItem.productDetails.price.toStringAsFixed(2)}'),
                    const SizedBox(height: 8),
                    Text("Quantity: ${widget.cartItem.quantity}"),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const Text("Delivery Method: "),
                DropdownButton<CartDeliveryMethod>(
                  value: _selectedDeliveryMethod,
                  items: _deliveryMethods.map((CartDeliveryMethod value) {
                    return DropdownMenuItem<CartDeliveryMethod>(
                      value: value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(enumToString(value.type)),
                          if (value.fee.isNotEmpty) Text('\$${value.fee}'),
                          if (value.fee.isEmpty) const Text('\$0'),
                          if (value.eta.isNotEmpty) Text('~${value.eta} days')
                        ],
                      ),
                    );
                  }).toList(),
                  selectedItemBuilder: (BuildContext context) {
                    return _deliveryMethods
                        .map<Widget>((CartDeliveryMethod value) {
                      return Row(
                        children: [
                          Text(enumToString(value.type)),
                          const SizedBox(width: 8.0), // This adds some spacing
                          if (value.fee.isNotEmpty) Text('\$${value.fee}'),
                          if (value.fee.isEmpty) const Text('\$0'),
                          if (value.eta.isNotEmpty) Text('~${value.eta} days')
                        ],
                      );
                    }).toList();
                  },
                  onChanged: (CartDeliveryMethod? newValue) {
                    context
                        .read<CartCubit>()
                        .selectedDeliveryMethodChanged(widget.index, newValue);
                    setState(() {
                      _selectedDeliveryMethod = newValue;
                    });
                  },
                  hint: const Text('Select a delivery method'),
                ),
              ],
            ),
            ...?widget.cartItem.cartModfiierSelections?.map(
              (CartModifierSelection modifier) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: "${modifier.question} ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (modifier.price != null &&
                            modifier.price!.isNotEmpty)
                          TextSpan(
                            text: "(\$${modifier.price}) ",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        TextSpan(
                          text: ": ${modifier.answer}",
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
