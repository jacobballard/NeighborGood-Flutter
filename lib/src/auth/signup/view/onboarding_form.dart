import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pastry/src/auth/signup/cubit/onboarding_cubit.dart';

class OnboardingForm extends StatelessWidget {
  const OnboardingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        // Handle submission success or failure here, similar to SignUpForm
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _UsernameInput(),
            const SizedBox(height: 8),
            _RealNameInput(),
            const SizedBox(height: 8),
            // Add other input widgets here
            _OnboardingSubmitButton(),
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('onboardingForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<OnboardingCubit>().usernameChanged(username),
          decoration: InputDecoration(
            labelText: 'username',
            helperText: '',
            errorText: state.username.invalid ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}

class _RealNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (previous, current) => previous.realName != current.realName,
      builder: (context, state) {
        return TextField(
          key: const Key('onboardingForm_realNameInput_textField'),
          onChanged: (realName) =>
              context.read<OnboardingCubit>().realNameChanged(realName),
          decoration: InputDecoration(
            labelText: 'real name',
            helperText: '',
            errorText: state.realName.invalid ? 'invalid real name' : null,
          ),
        );
      },
    );
  }
}

class _OnboardingSubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('onboardingForm_submit_ElevatedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.orangeAccent,
                ),
                onPressed: state.status.isValidated
                    ? () async => await context
                        .read<OnboardingCubit>()
                        .onboardingSubmitted()
                    : null,
                child: const Text('SUBMIT'),
              );
      },
    );
  }
}
