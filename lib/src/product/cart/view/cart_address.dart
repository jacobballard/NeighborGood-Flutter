import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pastry/src/account/create_store/view/store_address.dart';
import 'package:pastry/src/product/cart/cubit/cart_cubit.dart';

class CartAddressPage extends StatelessWidget {
  const CartAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalize Checkout'),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          // ... existing code ...
        },
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state.checkoutItems.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          }

          String addressHeaderText = "Billing Address";
          if (state.cartNeedsShippingAddress == true &&
              state.cartNeedsDeliveryAddress == true) {
            addressHeaderText = "Delivery / Shipping Address";
          } else if (state.cartNeedsShippingAddress == true) {
            addressHeaderText = "Shipping Address";
          } else if (state.cartNeedsDeliveryAddress == true) {
            addressHeaderText = "Delivery Address";
          }

          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Address Header & Input Fields
                      Text(addressHeaderText,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      StoreAddressView(
                          storeAddressCubit:
                              context.read<CartCubit>().firstStoreAddressCubit,
                          isCheckout: true),

                      if (state.cartNeedsShippingAddress == true ||
                          state.cartNeedsDeliveryAddress == true) ...[
                        // Checkbox "My billing address is the same as my (text based on boolean) address"
                        Row(
                          children: [
                            Checkbox(
                              value: state.billingSameAsShipping,
                              onChanged: (bool? value) {
                                context
                                    .read<CartCubit>()
                                    .useSameAddressBoolChanged(value);
                              },
                            ),
                            Text(
                                "My billing address is the same as my $addressHeaderText")
                          ],
                        ),
                        // Here you can put your Billing Address Input fields when the checkbox is unchecked
                        // ...
                        if (!state.billingSameAsShipping)
                          StoreAddressView(
                              storeAddressCubit: context
                                  .read<CartCubit>()
                                  .secondStoreAddressCubit,
                              isCheckout: true),
                      ],

                      // ... existing code ...
                    ],
                  ),
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

// ... existing code ...
