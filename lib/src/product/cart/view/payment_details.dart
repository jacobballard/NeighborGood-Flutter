import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:formz/formz.dart';
import 'package:pastry/src/product/cart/cubit/finalize_payment_cubit.dart';
import '../cubit/cart_cubit.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var clientSecret = context.read<CartCubit>().state.clientSecret;

    print(clientSecret);
    print('payment details');
    return Scaffold(
      appBar: AppBar(title: const Text("Finish Checkout")),
      body: BlocListener<FinalizePaymentCubit, FinalizePaymentState>(
        listener: (context, state) {
          if (state.status == FormzStatus.submissionSuccess) {
            Navigator.popUntil(context, (route) => route.isFirst);
            context.read<CartCubit>().resetState();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text('Success!: The payment was confirmed successfully!')));
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _PaymentEmailInput(),
                      CardField(
                        enablePostalCode: true,
                        countryCode: 'US',
                        postalCodeHintText: 'Enter the us postal code',
                        onCardChanged: (card) {
                          context.read<FinalizePaymentCubit>().setCard(card);
                        },
                      ),
                      _PaymentTotalsDetails(),
                      _FinalizePaymentButton(),
                    ]),
              ),
            ],
          ),
        ),
        // },
      ),
    );
  }
}

class _FinalizePaymentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinalizePaymentCubit, FinalizePaymentState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) => Container(
        padding: const EdgeInsets.all(10.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: state.status.isValid
              ? context.read<FinalizePaymentCubit>().handlePayPress
              : null,
          child: state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : const Text("Pay Now"),
        ),
      ),
    );
  }
}

class _PaymentTotalsDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) {
        if (previous.subtotal != current.subtotal ||
            previous.totalPrice != current.totalPrice ||
            previous.platformFee != current.platformFee ||
            previous.shippingPrice != current.shippingPrice ||
            previous.tax != current.tax) return false;

        return true;
      },
      builder: (context, state) {
        return Padding(
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
                  Text('\$${state.tax}'),
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
        );
      },
    );
  }
}

class _PaymentEmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinalizePaymentCubit, FinalizePaymentState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          key: const Key('paymentDetails_emailInput_textField'),
          onChanged: (value) =>
              context.read<FinalizePaymentCubit>().emailChanged(value),
          initialValue: state.email.value,
          enabled: state.needsEmailAddress,
          decoration: InputDecoration(
            labelText: 'email',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PaymentFirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinalizePaymentCubit, FinalizePaymentState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('paymentDetails_firstNameInput_textField'),
          onChanged: (value) =>
              context.read<FinalizePaymentCubit>().emailChanged(value),
          decoration: InputDecoration(
            labelText: 'email',
            errorText: state.email.invalid ? 'invalid name' : null,
          ),
        );
      },
    );
  }
}
