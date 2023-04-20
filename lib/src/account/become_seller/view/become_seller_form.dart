import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pastry/src/account/become_seller/cubit/become_seller_cubit.dart';
import 'package:pastry/src/app/app.dart';

class BecomeSellerForm extends StatelessWidget {
  const BecomeSellerForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<BecomeSellerCubit, BecomeSellerState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Store Creation Failure'),
              ),
            );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TitleInput(),
            const SizedBox(height: 8),
            _DescriptionInput(),
            const SizedBox(height: 8),
            _InstaInput(),
            const SizedBox(height: 8),
            _TikInput(),
            const SizedBox(height: 8),
            _MetaInput(),
            const SizedBox(height: 8),
            _PinInput(),
            const SizedBox(height: 8),
            _CreateStoreButton(),
          ],
        ),
      ),
    );
  }
}

class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BecomeSellerCubit, BecomeSellerState>(
      buildWhen: (previous, current) =>
          previous.storeTitle != current.storeTitle,
      builder: (context, state) {
        return TextField(
          onChanged: (title) =>
              context.read<BecomeSellerCubit>().storeTitleChanged(title),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Store Title',
            helperText: '',
            errorText:
                state.storeTitle.invalid ? 'Store title is required' : null,
          ),
        );
      },
    );
  }
}

// Add similar widgets for Description, Insta, Tik, Meta, and Pin inputs
// based on the validators you created previously

class _CreateStoreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BecomeSellerCubit, BecomeSellerState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xFFFFD600),
                ),
                onPressed: state.status.isValidated
                    ? () async {
                        await context
                            .read<BecomeSellerCubit>()
                            .createStore(context.read<AppBloc>().state.user.id);
                      }
                    : null,
                child: const Text('Create Store'),
              );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BecomeSellerCubit, BecomeSellerState>(
      buildWhen: (previous, current) =>
          previous.storeDescription != current.storeDescription,
      builder: (context, state) {
        return TextField(
          onChanged: (description) => context
              .read<BecomeSellerCubit>()
              .storeDescriptionChanged(description),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Store Description (optional)',
            helperText: '',
            errorText:
                state.storeDescription.invalid ? 'Invalid description' : null,
          ),
        );
      },
    );
  }
}

class _InstaInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BecomeSellerCubit, BecomeSellerState>(
      buildWhen: (previous, current) =>
          previous.storeInsta != current.storeInsta,
      builder: (context, state) {
        return TextField(
          onChanged: (insta) =>
              context.read<BecomeSellerCubit>().storeInstaChanged(insta),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Instagram Handle (optional)',
            helperText: '',
            errorText:
                state.storeInsta.invalid ? 'Invalid Instagram handle' : null,
          ),
        );
      },
    );
  }
}

class _TikInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BecomeSellerCubit, BecomeSellerState>(
      buildWhen: (previous, current) => previous.storeTik != current.storeTik,
      builder: (context, state) {
        return TextField(
          onChanged: (tik) =>
              context.read<BecomeSellerCubit>().storeTikChanged(tik),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'TikTok Handle (optional)',
            helperText: '',
            errorText: state.storeTik.invalid ? 'Invalid TikTok handle' : null,
          ),
        );
      },
    );
  }
}

class _MetaInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BecomeSellerCubit, BecomeSellerState>(
      buildWhen: (previous, current) => previous.storeMeta != current.storeMeta,
      builder: (context, state) {
        return TextField(
          onChanged: (meta) =>
              context.read<BecomeSellerCubit>().storeMetaChanged(meta),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Meta Handle (optional)',
            helperText: '',
            errorText: state.storeMeta.invalid ? 'Invalid Meta handle' : null,
          ),
        );
      },
    );
  }
}

class _PinInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BecomeSellerCubit, BecomeSellerState>(
      buildWhen: (previous, current) => previous.storePin != current.storePin,
      builder: (context, state) {
        return TextField(
          onChanged: (pin) =>
              context.read<BecomeSellerCubit>().storePinChanged(pin),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'Pinterest Handle (optional)',
            helperText: '',
            errorText:
                state.storePin.invalid ? 'Invalid Pinterest handle' : null,
          ),
        );
      },
    );
  }
}
