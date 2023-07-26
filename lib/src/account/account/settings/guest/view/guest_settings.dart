import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pastry/src/app/app.dart';

class GuestSettingsPage extends StatelessWidget {
  const GuestSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          print('pressed');
          await BlocProvider.of<AppBloc>(context)
              .onLogoutRequested(); //add(const AppLogoutRequested());
          print('go');
          context.go('/login');
          print('context.go');
        },
        child: const Text('Login'),
      ),
    );
  }
}
