import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/app/app.dart';

class GuestSettingsPage extends StatelessWidget {
  const GuestSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<AppBloc>(context).add(const AppLogoutRequested());
        },
        child: const Text('Login In'),
      ),
    );
  }
}
