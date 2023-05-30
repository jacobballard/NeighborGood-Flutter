import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/account/create_store/view/store_address.dart';
import 'package:pastry/src/account/create_store/view/store_details.dart';

import '../../utilities/delivery_methods/delivery_method_cubit.dart';
import '../../utilities/delivery_methods/delivery_methods.dart';
import '../../utilities/image_upload/file_reader_service.dart';
import '../../utilities/image_upload/image_uploader.dart';
import '../../utilities/image_upload/image_uploader_cubit.dart';
import '../../utilities/image_upload/image_uploader_repository.dart';
import '../cubit/create_store_cubit.dart';
import '../cubit/store_address_cubit.dart';
import '../cubit/store_details_cubit.dart';

class CreateStoreView extends StatelessWidget {
  const CreateStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateStoreCubit(
        storeDetailsCubit: StoreDetailsCubit(),
        storeAddressCubit: StoreAddressCubit(),
        deliveryMethodsCubit: DeliveryMethodsCubit()..addMethod(),
        imageUploaderCubit: ImageUploaderCubit(StoreImageUploaderRepository(
            kIsWeb ? FileReaderServiceWeb() : FileReaderServiceMobile())),
      ),
      child: BlocConsumer<CreateStoreCubit, CreateStoreState>(
        listener: (context, state) {
          if (state.isValidated) {
            // TODO : navigate to the next page or show a success message
          }
        },
        builder: (context, state) {
          final createStoreCubit = context.read<CreateStoreCubit>();

          return SingleChildScrollView(
            child: Column(
              children: [
                StoreDetailsView(),
                StoreAddressView(
                  storeAddressCubit: createStoreCubit.storeAddressCubit,
                ),
                DeliveryMethodsView(
                  deliveryMethodsCubit: createStoreCubit.deliveryMethodsCubit,
                ),
                ImageUploadForm(
                  imageUploaderCubit: createStoreCubit.imageUploaderCubit,
                ),
                ElevatedButton(
                  onPressed: state.isValidated ? createStoreCubit.submit : null,
                  child: const Text('Submit'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
