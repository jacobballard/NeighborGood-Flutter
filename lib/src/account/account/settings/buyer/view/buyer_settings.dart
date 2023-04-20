import 'package:flutter/material.dart';
import 'package:pastry/src/account/account/settings/utils/custom_buttons.dart';

class BuyerSettingsPage extends StatelessWidget {
  const BuyerSettingsPage({Key? key}) : super(key: key);

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
            // Navigate to become a seller page
            Navigator.pushNamed(context, '/become_a_seller');
          },
          child: const Text('Become a Seller'),
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
