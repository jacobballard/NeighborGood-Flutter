import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_rapid/create_product/create_product_cubit.dart';
import 'package:goods_rapid/create_product/modifier.dart';
import 'package:goods_rapid/create_product/modifier_cubit.dart';
import 'package:goods_rapid/create_product/product_details_cubit.dart';
import 'package:goods_rapid/create_store/delivery_method_cubit.dart';
import 'package:goods_rapid/create_store/delivery_methods.dart';
import 'package:goods_rapid/create_store/file_reader_service.dart';
import 'package:goods_rapid/create_store/image_uploader.dart';
import 'package:goods_rapid/create_store/image_uploader_cubit.dart';
import 'package:goods_rapid/create_store/image_uploader_repository.dart';

import 'product_details.dart';

class CreateProductPage extends StatelessWidget {
  CreateProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocProvider(
            create: (context) => CreateProductCubit(
              productDetailsCubit: ProductDetailsCubit(),
              modifierCubit: ModifierCubit(),
              deliveryMethodsCubit: DeliveryMethodsCubit(),
              imageUploaderCubit: ImageUploaderCubit(
                StoreImageUploaderRepository(kIsWeb
                    ? FileReaderServiceWeb()
                    : FileReaderServiceMobile()),
              ),
            ),
            child: BlocConsumer<CreateProductCubit, CreateProductState>(
              listener: (context, state) {
                if (state.isValidated) {
                  // TODO : Doosies
                }
              },
              builder: (context, state) {
                final createProductCubit = context.read<CreateProductCubit>();

                return Column(children: [
                  ProductDetailsView(),
                  ImageUploadForm(
                      imageUploaderCubit:
                          createProductCubit.imageUploaderCubit),
                  const ModifiersView(),
                  DeliveryMethodsView(
                    required: false,
                    deliveryMethodsCubit:
                        createProductCubit.deliveryMethodsCubit,
                  ),
                  ElevatedButton(
                      onPressed:
                          state.isValidated ? createProductCubit.submit : null,
                      child: const Text('Submit'))
                ]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
