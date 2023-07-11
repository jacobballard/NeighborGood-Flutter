import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/store_address_cubit.dart';

class StoreAddressView extends StatelessWidget {
  StoreAddressView({Key? key, this.storeAddressCubit, required this.isCheckout})
      : super(key: key);

  final StoreAddressCubit? storeAddressCubit;
  final bool isCheckout;

  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  Widget buildLabel(String text, bool required) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(color: Colors.black),
        children: [
          if (required)
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (storeAddressCubit == null) {
      return const SizedBox
          .shrink(); // return an empty widget if storeAddressCubit is null
    }

    return Material(
      child: BlocProvider.value(
        value: storeAddressCubit!,
        child: BlocBuilder<StoreAddressCubit, StoreAddressState>(
          builder: (context, state) {
            // Update the controller's text if different from the state and set cursor to end
            if (addressLine1Controller.text != state.addressLine1.value) {
              addressLine1Controller.text = state.addressLine1.value;
              addressLine1Controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: addressLine1Controller.text.length));
            }

            if (addressLine2Controller.text != state.addressLine2.value) {
              addressLine2Controller.text = state.addressLine2.value;
              addressLine2Controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: addressLine2Controller.text.length));
            }

            if (zipCodeController.text != state.zipCode.value) {
              zipCodeController.text = state.zipCode.value;
              zipCodeController.selection = TextSelection.fromPosition(
                  TextPosition(offset: zipCodeController.text.length));
            }

            if (cityController.text != state.city.value) {
              cityController.text = state.city.value;
              cityController.selection = TextSelection.fromPosition(
                  TextPosition(offset: cityController.text.length));
            }

            return Column(
              children: [
                TextField(
                  controller: addressLine1Controller,
                  onChanged: storeAddressCubit!.addressLine1Changed,
                  decoration: InputDecoration(
                    label: buildLabel('Street address', isCheckout),
                    errorText:
                        state.addressLine1.invalid ? 'Invalid address' : null,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: addressLine2Controller,
                  onChanged: storeAddressCubit!.addressLine2Changed,
                  decoration: InputDecoration(
                    labelText: 'Apt / Suite / Other',
                    errorText:
                        state.addressLine2.invalid ? 'Invalid address' : null,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: zipCodeController,
                        onChanged: storeAddressCubit!.zipCodeChanged,
                        decoration: InputDecoration(
                          label: buildLabel('Zip Code', true),
                          errorText:
                              state.zipCode.invalid ? 'Invalid zip code' : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: cityController,
                        onChanged: storeAddressCubit!.cityChanged,
                        decoration: InputDecoration(
                          label: buildLabel('City', isCheckout),
                          errorText: state.city.invalid ? 'Invalid city' : null,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                _StateInput(isRequired: isCheckout),
                if (state.hasSuggestedAddress) ...[
                  const SizedBox(height: 10),
                  const Text('Suggested Address:',
                      style: TextStyle(fontSize: 16)),
                  Text(
                      state.suggestedAddress != null
                          ? '${state.suggestedAddress!.address_line_1 != null ? '${state.suggestedAddress!.address_line_1}\n' : ''}${state.suggestedAddress!.address_line_2 != null && state.suggestedAddress!.address_line_2!.isNotEmpty ? '${state.suggestedAddress!.address_line_2}\n' : ''}${state.suggestedAddress!.city != null ? '${state.suggestedAddress!.city}, ' : ''}${state.suggestedAddress!.state}\n${state.suggestedAddress!.zip}'
                          : '',
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<StoreAddressCubit>().confirmAddress();
                    },
                    child: const Text('Confirm Address'),
                  ),
                ],
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
        style: const TextStyle(color: Colors.black),
        children: [
          if (isRequired)
            const TextSpan(
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
          value: state.stateName.isEmpty
              ? null
              : state.stateName, // This can be null if nothing is selected
          onChanged: (value) {
            context.read<StoreAddressCubit>().stateChanged(value ?? '');
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
