import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:repositories/repositories.dart';
import 'package:uuid/uuid.dart';

import '../../utilities/delivery_methods/delivery_method_cubit.dart';
import '../../utilities/delivery_methods/delivery_methods.dart';
import '../../utilities/image_upload/abstract_file_reader_service.dart';

import '../../utilities/image_upload/image_uploader.dart';
import '../../utilities/image_upload/image_uploader_cubit.dart';
import '../../utilities/image_upload/image_uploader_repository.dart';
import '../cubit/create_product_cubit.dart';
import '../cubit/modifier_cubit.dart';
import '../cubit/product_details_cubit.dart';
import 'modifier.dart';
import 'product_details.dart';

// class CreateProductPage extends StatelessWidget {
//   const CreateProductPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: BlocProvider(
//             create: (context) {
//               var productId = const Uuid().v4();
//               return CreateProductCubit(
//                 productId: productId,
//                 authenticationRepository:
//                     context.read<AuthenticationRepository>(),
//                 createProductRepository:
//                     CreateProductRepository(productId: productId),
//                 productDetailsCubit: ProductDetailsCubit(),
//                 modifierCubit: ModifierCubit(),
//                 deliveryMethodsCubit: DeliveryMethodsCubit(),
//                 imageUploaderCubit: ImageUploaderCubit(
//                   imageUploaderRepository: ConcreteImageUploaderRepository(
//                     fileReaderService: FileReaderService(),
//                     uploadPath:
//                         '/products/${context.read<AuthenticationRepository>().currentUser.id}/$productId',
//                   ),
//                 ),
//               );
//             },
//             child: BlocConsumer<CreateProductCubit, CreateProductState>(
//               listener: (context, state) {
//                 if (state.isValidated) {
//                   // TODO : Doosies
//                 }
//               },
//               builder: (context, state) {
//                 final createProductCubit = context.read<CreateProductCubit>();

//                 return Column(children: [
//                   const ProductDetailsView(),
//                   ImageUploadForm(
//                       imageUploaderCubit:
//                           createProductCubit.imageUploaderCubit),
//                   const ModifiersView(),
//                   DeliveryMethodsView(
//                     required: false,
//                     deliveryMethodsCubit:
//                         createProductCubit.deliveryMethodsCubit,
//                   ),
//                   ElevatedButton(
//                       onPressed:
//                           state.isValidated ? createProductCubit.submit : null,
//                       child: const Text('Submit'))
//                 ]);
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class CreateProductPage extends StatelessWidget {
  const CreateProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocProvider(
            create: (context) {
              var productId = const Uuid().v4();
              return CreateProductCubit(
                productId: productId,
                authenticationRepository:
                    context.read<AuthenticationRepository>(),
                createProductRepository:
                    CreateProductRepository(productId: productId),
                productDetailsCubit: ProductDetailsCubit(),
                modifierCubit: ModifierCubit(),
                deliveryMethodsCubit: DeliveryMethodsCubit(required: false),
                imageUploaderCubit: ImageUploaderCubit(
                  imageUploaderRepository: ConcreteImageUploaderRepository(
                    fileReaderService: FileReaderService(),
                    uploadPath:
                        '/products/${context.read<AuthenticationRepository>().currentUser.id}/$productId',
                  ),
                ),
              );
            },
            child: BlocConsumer<CreateProductCubit, CreateProductState>(
              listener: (context, state) {
                if (state.isValidated) {
                  // TODO : Doosies
                }
              },
              builder: (context, state) {
                final createProductCubit = context.read<CreateProductCubit>();

                return Column(children: [
                  const ProductDetailsView(),
                  ImageUploadForm(
                      imageUploaderCubit:
                          createProductCubit.imageUploaderCubit),
                  const ModifiersView(),
                  DeliveryMethodsView(
                    required: false,
                    deliveryMethodsCubit:
                        createProductCubit.deliveryMethodsCubit,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: state.isValidated
                            ? createProductCubit.submit
                            : null,
                        child: const Text('Submit'),
                      ),
                      if (state.status == FormzStatus.submissionInProgress)
                        const CircularProgressIndicator()
                    ],
                  )
                ]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
