import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/account/become_seller/cubit/become_seller_cubit.dart';
import 'package:repositories/repositories.dart';
import 'become_seller_form.dart';

class BecomeSellerPage extends StatelessWidget {
  const BecomeSellerPage({Key? key}) : super(key: key);

  static Page<void> page() =>
      const MaterialPage<void>(child: BecomeSellerPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Become a Seller')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            BlocProvider<BecomeSellerCubit>(
              create: (context) => BecomeSellerCubit(
                  context.read<ProfileRepository>(),
                  context.read<AuthenticationRepository>()),
              child: const BecomeSellerForm(),
            )
          ],
        ),
      ),
    );
  }
}
