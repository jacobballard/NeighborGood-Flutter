import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/auth/login/login.dart';
import 'package:pastry/src/auth/login/view/login_form.dart';

class GuestSettingsPage extends StatelessWidget {
  const GuestSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guest Settings'),
      ),
      body: BlocProvider(
        create: (context) =>
            LoginCubit(context.read<AuthenticationRepository>()),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Login', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 16),
                const LoginForm(isAlreadyGuest: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
