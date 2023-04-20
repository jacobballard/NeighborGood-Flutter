import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/account/account/bloc/profile_bloc.dart';
import 'package:pastry/src/account/account/settings/buyer/view/buyer_settings.dart';
import 'package:pastry/src/account/account/settings/guest/view/guest_settings.dart';
import 'package:pastry/src/account/account/settings/seller/view/seller_settings.dart';
import 'package:pastry/src/account/account/settings/utils/settings_navigator.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsNavigatorObserver = SettingsNavigatorObserver();
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        Widget settingsPage;
        if (state is ProfileBuyer) {
          settingsPage = const BuyerSettingsPage();
        } else if (state is ProfileGuest) {
          settingsPage = const GuestSettingsPage();
        } else if (state is ProfileSeller) {
          settingsPage = const SellerSettingsPage();
        } else {
          settingsPage = const CircularProgressIndicator();
        }
        return MaterialApp(
          home: settingsPage,
          navigatorObservers: [settingsNavigatorObserver],
        );
      },
    );
  }
}