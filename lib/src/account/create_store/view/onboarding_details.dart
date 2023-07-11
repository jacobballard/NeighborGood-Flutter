import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                ]
              ],
            );
          },
        ),
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
                            labelText: 'Name',
                            errorText:
                                state.firstName.invalid ? 'Invalid Name' : null,
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          key: const Key("last_name_key_textField"),
                          onChanged: onboardingCubit.lastNameChanged,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            errorText:
                                state.lastName.invalid ? 'Invalid Name' : null,
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
                            labelText: 'Month of Birth',
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
                            labelText: 'Day of Birth',
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
                            labelText: 'Year of Birth',
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
