import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/account/account/bloc/profile_bloc.dart';
import 'package:pastry/src/account/account/settings/buyer/view/buyer_settings.dart';
import 'package:pastry/src/account/account/settings/guest/view/guest_settings.dart';
import 'package:pastry/src/account/account/settings/seller/view/seller_settings.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is ProfileBuyer) {
            return const BuyerSettingsPage();
          } else if (state is ProfileGuest) {
            return const GuestSettingsPage();
          } else if (state is ProfileSeller) {
            return const SellerSettingsPage();
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
