import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/account/account/bloc/profile_bloc.dart';
import 'package:pastry/src/account/account/model/account.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is LoadedProfileState && state.account != null) {
          return _buildAccountSettings(context, state.account!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildAccountSettings(BuildContext context, Account account) {
    final bool isSeller = account.isSeller;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextButton(
          onPressed: () {
            // Navigate to edit account details page
          },
          child: const Text('Edit Account Details'),
        ),
        TextButton(
          onPressed: () {
            // Navigate to edit/add payment information page
          },
          child: const Text('Edit/Add Payment Information'),
        ),
        if (isSeller)
          TextButton(
            onPressed: () {
              // Navigate to edit payment acceptance details page
            },
            child: const Text('Edit Payment Acceptance Details'),
          ),
        if (isSeller)
          TextButton(
            onPressed: () {
              // Navigate to edit storefront information page
            },
            child: const Text('Edit Storefront Information'),
          ),
        if (!isSeller)
          TextButton(
            onPressed: () {
              // Navigate to become a seller page
            },
            child: const Text('Become a Seller'),
          ),
        TextButton(
          onPressed: () {
            // Navigate to contact support page
          },
          child: const Text('Contact Support'),
        ),
      ],
    );
  }
}
