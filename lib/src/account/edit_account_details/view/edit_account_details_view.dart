import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/account/edit_account_details/bloc/edit_account_details_bloc.dart';

class EditAccountDetailsView extends StatelessWidget {
  // Add TextEditingController for display name and password fields
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  EditAccountDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditAccountDetailsBloc, EditAccountDetailsState>(
      listener: (context, state) {
        if (state is EditAccountDetailsSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.message)),
            );
        } else if (state is EditAccountDetailsFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.error)),
            );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Account Details'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _displayNameController,
                  decoration: const InputDecoration(
                    labelText: 'Display Name',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _currentPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Current Password',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _newPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                  ),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    context.read<EditAccountDetailsBloc>().add(
                          UpdateDisplayName(_displayNameController.text),
                        );
                  },
                  child: const Text('Update Display Name'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    context.read<EditAccountDetailsBloc>().add(
                          UpdatePassword(_currentPasswordController.text,
                              _newPasswordController.text),
                        );
                  },
                  child: const Text('Update Password'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
