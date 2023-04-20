import 'package:flutter/material.dart';

class SettingsNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    // Handle route changes here
    if (route.settings.name == '/edit_account_details') {
      print('Navigating to Edit Account Details');
    } else if (route.settings.name == '/edit_add_payment_info') {
      print('Navigating to Edit/Add Payment Info');
    }
    // Add other named route checks here
  }
}
