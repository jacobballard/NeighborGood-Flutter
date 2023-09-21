import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  static Page<void> page() =>
      const MaterialPage<void>(child: EmailVerificationPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              "Please verify ${context.read<AuthenticationRepository>().currentUser.email}"),

          // Submit verification
        ],
      ),
    );
  }
}
