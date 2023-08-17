import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
import '../cubit/cart_cubit.dart';

class PaymentScreen extends StatefulWidget {
  late String clientSecret;
  @override
  _PaymentScreen createState() => _PaymentScreen();
}

class _PaymentScreen extends State<PaymentScreen> {
  final controller = CardEditController();

  @override
  void initState() {
    controller.addListener(update);
    super.initState();
  }

  void update() => setState(() {});
  @override
  void dispose() {
    controller.removeListener(update);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.clientSecret = context.read<CartCubit>().state.clientSecret;
    return Scaffold(
      appBar: AppBar(title: const Text("Finish Checkout")),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(children: [
            CardField(
              controller: controller,
            ),
            Expanded(child: Container()),
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
                onPressed: controller.complete ? _handlePayPress : null,
                child: state.status.isSubmissionInProgress
                    ? const CircularProgressIndicator()
                    : const Text("Finish checkout"),
              ),
            ),
          ]);
        },
      ),
    );
  }

  Future<void> _handlePayPress() async {
    await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: widget.clientSecret,
        data: const PaymentMethodParams.card(
            paymentMethodData: PaymentMethodData()));
    // await Stripe.instance.confirmPayment(
    //   clientSecret,
    //   PaymentMethodParams.card(
    //     paymentMethodData: PaymentMethodData(
    //       billingDetails: billingDetails,
    //     ),
    //   ),
    // );
  }
}
