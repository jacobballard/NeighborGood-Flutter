import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/account/account/settings/utils/custom_buttons.dart';

import 'package:pastry/src/account/create_store/view/create_store.dart';
import 'package:pastry/src/app/bloc/app_bloc.dart';

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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateStoreView(),
              ),
            );
          },
          child: const Text('Become a Seller'),
        ),
        ContactSupportButton(
          onPressed: () {
            // Navigate to contact support page
            Navigator.pushNamed(context, '/contact_support');
          },
        ),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<AppBloc>(context).add(const AppLogoutRequested());
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
