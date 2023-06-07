import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/create_store_cubit.dart';
import '../cubit/store_details_cubit.dart';

class StoreDetailsView extends StatelessWidget {
  const StoreDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final storeDetailsCubit =
        context.read<CreateStoreCubit>().storeDetailsCubit;

    return Material(
      child: BlocProvider.value(
        value: storeDetailsCubit,
        child: BlocBuilder<StoreDetailsCubit, StoreDetailsState>(
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  key: const Key("title_key_textField"),
                  onChanged: storeDetailsCubit.titleChanged,
                  decoration: InputDecoration(
                    labelText: 'Store Title',
                    errorText: state.title.invalid ? 'Invalid title' : null,
                  ),
                ),
                TextField(
                  key: const Key("title_2_textField"),
                  onChanged: storeDetailsCubit.descriptionChanged,
                  decoration: InputDecoration(
                    labelText: 'Store Description',
                    errorText: state.description.invalid
                        ? 'Invalid description'
                        : null,
                  ),
                ),
                // Other fields...
              ],
            );
          },
        ),
      ),
    );
  }
}
