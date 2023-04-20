import 'package:flutter/material.dart';
import 'package:pastry/src/account/account/settings/utils/custom_buttons.dart';

class SellerSettingsPage extends StatelessWidget {
  const SellerSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        EditAccountDetailsButton(
          onPressed: () {
            // Navigate to edit account details page
            Navigator.pushNamed(context, '/edit_account_details');
          },
        ),
        EditAddPaymentInfoButton(
          onPressed: () {
            // Navigate to edit/add payment information page
            Navigator.pushNamed(context, '/edit_add_payment_info');
          },
        ),
        TextButton(
          onPressed: () {
            // Navigate to edit payment acceptance details page
            Navigator.pushNamed(context, '/edit_payment_acceptance_details');
          },
          child: const Text('Edit Payment Acceptance Details'),
        ),
        TextButton(
          onPressed: () {
            // Navigate to edit storefront information page
            Navigator.pushNamed(context, '/edit_storefront_information');
          },
          child: const Text('Edit Storefront Information'),
        ),
        TextButton(
          onPressed: () {
            // Navigate to manage products page
            Navigator.pushNamed(context, '/manage_products');
          },
          child: const Text('Manage Products'),
        ),
        ContactSupportButton(
          onPressed: () {
            // Navigate to contact support page
            Navigator.pushNamed(context, '/contact_support');
          },
        ),
      ],
    );
  }
}