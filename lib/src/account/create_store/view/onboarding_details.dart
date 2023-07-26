import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/models/business_type.dart';

import '../cubit/create_store_cubit.dart';
import '../cubit/onboarding_cubit.dart';

class OnboardingDetailsView extends StatelessWidget {
  const OnboardingDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onboardingCubit = context.read<CreateStoreCubit>().onboardingCubit;

    return Material(
      child: BlocProvider.value(
        value: onboardingCubit,
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text("Business Type",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    DropdownButton<BusinessType>(
                      value: state.businessType == BusinessType.none
                          ? null
                          : state.businessType,
                      hint: const Text("Select a business type"),
                      items: BusinessType.values
                          .where((type) => type != BusinessType.none)
                          .map((BusinessType value) {
                        return DropdownMenuItem<BusinessType>(
                          value: value,
                          child: Text(value.toString().split('.').last),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          onboardingCubit.setBusinessType(value);
                        }
                      },
                    ),
                  ],
                ),
                if (state.businessType != BusinessType.none) ...[
                  if (state.businessType == BusinessType.business)
                    BusinessView(),
                  if (state.businessType == BusinessType.individual)
                    const IndividualView(),
                ],
                const BankAccountView(),
                const TermsAcceptanceView(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TermsAcceptanceView extends StatelessWidget {
  const TermsAcceptanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onboardingCubit = context.read<CreateStoreCubit>().onboardingCubit;

    return BlocProvider.value(
      value: onboardingCubit,
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return CheckboxListTile(
            title: InkWell(
              onTap: () => Navigator.pushNamed(context, '/terms_of_service'),
              child: const Text(
                'I agree to the Terms of Service',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            value: state.tosAccepted,
            onChanged: (bool? value) =>
                onboardingCubit.acceptTermsChanged(value!),
            controlAffinity: ListTileControlAffinity.leading,
          );
        },
      ),
    );
  }
}

class BankAccountView extends StatelessWidget {
  const BankAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onboardingCubit = context.read<CreateStoreCubit>().onboardingCubit;

    return BlocProvider.value(
      value: onboardingCubit,
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return Column(
            children: [
              TextField(
                onChanged: onboardingCubit.bankAccountChanged,
                decoration: InputDecoration(
                  labelText: 'Bank Account Number',
                  errorText: state.bankAccount.invalid
                      ? 'Invalid Bank Account Number'
                      : null,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                onChanged: onboardingCubit.routingNumberChanged,
                decoration: InputDecoration(
                  labelText: 'Routing Number',
                  errorText: state.routingNumber.invalid
                      ? 'Invalid Routing Number'
                      : null,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class IndividualView extends StatelessWidget {
  const IndividualView({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingCubit = context.read<CreateStoreCubit>().onboardingCubit;

    return Material(
      child: BlocProvider.value(
        value: onboardingCubit,
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: TextField(
                          key: const Key("first_name_key_textField"),
                          onChanged: onboardingCubit.firstNameChanged,
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            errorText: state.firstName.invalid
                                ? 'Invalid First Name'
                                : null,
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          key: const Key("last_name_key_textField"),
                          onChanged: onboardingCubit.lastNameChanged,
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            errorText: state.lastName.invalid
                                ? 'Invalid Last Name'
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: TextField(
                          key: const Key("month_key_textField"),
                          onChanged: onboardingCubit.monthChanged,
                          decoration: InputDecoration(
                            labelText: 'Birth Month',
                            errorText:
                                state.month.invalid ? 'Invalid Month' : null,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        child: TextField(
                          key: const Key("day_key_textField"),
                          onChanged: onboardingCubit.dayChanged,
                          decoration: InputDecoration(
                            labelText: 'Birth Day',
                            errorText: state.day.invalid ? 'Invalid Day' : null,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        child: TextField(
                          key: const Key("year_key_textField"),
                          onChanged: onboardingCubit.yearChanged,
                          decoration: InputDecoration(
                            labelText: 'Birth Year',
                            errorText:
                                state.year.invalid ? 'Invalid Year' : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    key: const Key("ss_last_four_key_textField"),
                    onChanged: onboardingCubit.ssLastFourChanged,
                    decoration: InputDecoration(
                      labelText: 'Last 4 digits of SSN',
                      errorText: state.ssLastFour.invalid
                          ? 'Invalid SSN Last 4 digits'
                          : null,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class BusinessView extends StatelessWidget {
  BusinessView({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingCubit = context.read<CreateStoreCubit>().onboardingCubit;

    return Material(
      child: BlocProvider.value(
        value: onboardingCubit,
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    key: const Key("company_name_key_textField"),
                    onChanged: onboardingCubit.companyNameChanged,
                    decoration: InputDecoration(
                      labelText: 'Company Name',
                      errorText: state.companyName.invalid
                          ? 'Invalid Company Name'
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    key: const Key("company_tax_id_key_textField"),
                    onChanged: onboardingCubit.companyTaxIdChanged,
                    decoration: InputDecoration(
                      labelText: 'Company Tax ID',
                      errorText: state.companyTaxId.invalid
                          ? 'Invalid Company Tax ID'
                          : null,
                    ),
                  ),
                  // Other fields...
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
