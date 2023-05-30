import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_rapid/create_store/file_reader_service.dart';
import 'package:goods_rapid/create_store/image_uploader.dart';
import 'package:goods_rapid/create_store/image_uploader_cubit.dart';
import 'package:goods_rapid/create_store/image_uploader_repository.dart';
import 'package:goods_rapid/create_store/store_address.dart';
import 'package:goods_rapid/create_store/store_address_cubit.dart';
import 'package:goods_rapid/create_store/store_details.dart';
import 'package:goods_rapid/create_store/store_details_cubit.dart';

import 'create_store_cubit.dart';
import 'delivery_method_cubit.dart';
import 'delivery_methods.dart';

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
