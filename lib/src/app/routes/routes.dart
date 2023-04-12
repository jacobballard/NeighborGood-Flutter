import 'package:flutter/widgets.dart';
import 'package:pastry/src/app/bloc/app_bloc.dart';
import 'package:pastry/src/auth/login/login.dart';
import 'package:pastry/src/app/view/tab_bar.dart';
import 'package:pastry/src/location/view/zip_code.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [MyTabBar.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    case AppStatus.locationRequest:
      return const [ZipCodeScreenPage()];
  }
}
