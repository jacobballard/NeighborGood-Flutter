import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/store_address_cubit.dart';

class StoreAddressView extends StatelessWidget {
  const StoreAddressView({super.key, required this.storeAddressCubit});

  final StoreAddressCubit storeAddressCubit;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider.value(
        value: storeAddressCubit,
        child: BlocBuilder<StoreAddressCubit, StoreAddressState>(
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  onChanged: storeAddressCubit.addressLine1Changed,
                  decoration: InputDecoration(
                    labelText: 'Address Line 1',
                    errorText:
                        state.addressLine1.invalid ? 'Invalid address' : null,
                  ),
                ),
                TextField(
                  onChanged: storeAddressCubit.addressLine2Changed,
                  decoration: InputDecoration(
                    labelText: 'Address Line 2',
                    errorText:
                        state.addressLine2.invalid ? 'Invalid address' : null,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: storeAddressCubit.cityChanged,
                        decoration: InputDecoration(
                          labelText: 'City',
                          errorText: state.city.invalid ? 'Invalid city' : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _StateInput(),
                    ),
                  ],
                ),
                TextField(
                  onChanged: storeAddressCubit.zipCodeChanged,
                  decoration: InputDecoration(
                    labelText: 'Zip Code',
                    errorText:
                        state.zipCode.invalid ? 'Invalid zip code' : null,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class _StateInput extends StatelessWidget {
  final List<String> statesAndTerritories = [
    'AL', // Alabama
    'AK', //# Alaska
    'AZ', //# Arizona
    'AR', //# Arkansas
    'CA', //# California
    'CO', //# Colorado
    'CT', //# Connecticut
    'DE', //# Delaware
    'FL', //# Florida
    'GA', //# Georgia
    'HI', //# Hawaii
    'ID', //# Idaho
    'IL', //# Illinois
    'IN', //# Indiana
    'IA', //# Iowa
    'KS', //# Kansas
    'KY', //# Kentucky
    'LA', //# Louisiana
    'ME', //# Maine
    'MD', //#// Maryland
    'MA', // # Massachusetts
    'MI', // # Michigan
    'MN', //# Minnesota
    'MS', //# Mississippi
    'MO', // # Missouri
    'MT', //# Montana
    'NE', // # Nebraska
    'NV', //# Nevada
    'NH', // # New Hampshire
    'NJ', //# New Jersey
    'NM', //# New Mexico
    'NY', //# New York
    'NC', //  # North Carolina
    'ND', //# North Dakota
    'OH', //# Ohio
    'OK', //# Oklahoma
    'OR', //# Oregon
    'PA', //# Pennsylvania
    'RI', //# Rhode Island
    'SC', //# South Carolina
    'SD', //# South Dakota
    'TN', //# Tennessee
    'TX', //# Texas
    'UT', //# Utah
    'VT', // # Vermont
    'VA', // #// Virginia
    'WA', //# Washington
    'WV', //# West Virginia
    'WI', //# Wisconsin
    'WY', //# Wyoming
    'DC', //# District of Columbia
    'PR', //# Puerto Rico
    'GU', //# Guam
    'AS', //# American Samoa
    'VI', // # U.S. Virgin Islands
    'MP' //# Northern Mariana Islands
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreAddressCubit, StoreAddressState>(
      buildWhen: (previous, current) => previous.stateName != current.stateName,
      builder: (context, state) {
        return DropdownButtonFormField<String>(
          key: const Key('onboardingForm_stateInput_dropdown'),
          onChanged: (value) {
            if (value != null) {
              context.read<StoreAddressCubit>().stateChanged(value);
            }
          },
          items: statesAndTerritories
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: const InputDecoration(
            labelText: 'State',
          ),
        );
      },
    );
  }
}
