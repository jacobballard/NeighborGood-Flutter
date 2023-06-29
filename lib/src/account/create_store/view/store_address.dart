import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/store_address_cubit.dart';

class StoreAddressView extends StatelessWidget {
  const StoreAddressView(
      {Key? key, required this.storeAddressCubit, required this.isCheckout})
      : super(key: key);

  final StoreAddressCubit storeAddressCubit;
  final bool isCheckout;

  Widget buildLabel(String text, bool required) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(color: Colors.black),
        children: [
          if (required)
            TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            )
        ],
      ),
    );
  }

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
                    label: buildLabel('Street address', isCheckout),
                    errorText:
                        state.addressLine1.invalid ? 'Invalid address' : null,
                  ),
                ),
                TextField(
                  onChanged: storeAddressCubit.addressLine2Changed,
                  decoration: InputDecoration(
                    labelText: 'Apt / Suite / Other',
                    errorText:
                        state.addressLine2.invalid ? 'Invalid address' : null,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: storeAddressCubit.zipCodeChanged,
                        decoration: InputDecoration(
                          label: buildLabel('Zip Code', true),
                          errorText:
                              state.zipCode.invalid ? 'Invalid zip code' : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        onChanged: storeAddressCubit.cityChanged,
                        decoration: InputDecoration(
                          label: buildLabel('City', isCheckout),
                          errorText: state.city.invalid ? 'Invalid city' : null,
                        ),
                      ),
                    ),
                  ],
                ),
                _StateInput(isRequired: isCheckout),
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

  final bool isRequired;

  _StateInput({required this.isRequired});

  Widget buildLabel(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(color: Colors.black),
        children: [
          if (isRequired)
            TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            )
        ],
      ),
    );
  }

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
          decoration: InputDecoration(
            label: buildLabel('State'),
          ),
        );
      },
    );
  }
}
