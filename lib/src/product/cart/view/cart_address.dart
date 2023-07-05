import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pastry/src/account/create_store/view/store_address.dart';
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
        // buildWhen: (previous, current) =>
        //     previous != current ||
        //     previous.hasSuggestedFirstAddress !=
        //         current.hasSuggestedFirstAddress,
        buildWhen: (previous, current) {
          print("rebuilding");
          return previous != current;
        },
        builder: (context, state) {
          if (state.checkoutItems.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          }

          String addressHeaderText = "Billing Address";
          String doubleText = "billing address";
          if (state.cartNeedsShippingAddress == true &&
              state.cartNeedsDeliveryAddress == true) {
            addressHeaderText = "Delivery / Shipping Address";
            doubleText = "delivery / shipping address";
          } else if (state.cartNeedsShippingAddress == true) {
            addressHeaderText = "Shipping Address";
            doubleText = 'shipping address';
          } else if (state.cartNeedsDeliveryAddress == true) {
            addressHeaderText = "Delivery Address";
            doubleText = 'delivery address';
          }

          return SingleChildScrollView(
            // physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Address Header & Input Fields
                        Text(addressHeaderText,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 8,
                        ),
                        StoreAddressView(
                            storeAddressCubit: context
                                .read<CartCubit>()
                                .firstStoreAddressCubit,
                            isCheckout: true),

                        // Show suggested address if flag is set

                        if (state.cartNeedsShippingAddress == true ||
                            state.cartNeedsDeliveryAddress == true) ...[
                          // Checkbox "My billing address is the same as my (text based on boolean) address"
                          Row(
                            children: [
                              Checkbox(
                                value: state.billingSameAsShipping,
                                onChanged: (bool? value) {
                                  print("changed");
                                  context
                                      .read<CartCubit>()
                                      .sameBillingAsShipping(value);
                                },
                              ),
                              Text(
                                  "My billing address is the same as my $doubleText")
                            ],
                          ),
                          // Here you can put your Billing Address Input fields when the checkbox is unchecked
                          // ...
                          if (!state.billingSameAsShipping) ...[
                            const Text("Billing Address",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 8,
                            ),
                            StoreAddressView(
                                storeAddressCubit: context
                                    .read<CartCubit>()
                                    .secondStoreAddressCubit,
                                isCheckout: true),
                          ],
                        ],
                      ],

                      // ... existing code ...
                      // ],
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
            ),
          );
        },
      ),
    );
  }
}
