import 'package:authentication_repository/authentication_repository.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pastry/src/account/create_store/view/store_address.dart';
import 'package:pastry/src/account/create_store/view/store_details.dart';
import 'package:repositories/repositories.dart';

import '../../utilities/delivery_methods/delivery_method_cubit.dart';
import '../../utilities/delivery_methods/delivery_methods.dart';

import '../../utilities/image_upload/abstract_file_reader_service.dart';
import '../../utilities/image_upload/image_uploader.dart';
import '../../utilities/image_upload/image_uploader_cubit.dart';
import '../../utilities/image_upload/image_uploader_repository.dart';
import '../cubit/create_store_cubit.dart';
import '../cubit/store_address_cubit.dart';
import '../cubit/store_details_cubit.dart';

class CreateStoreView extends StatelessWidget {
  const CreateStoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("uid: ${context.read<AuthenticationRepository>().currentUser.id}");
    return BlocProvider(
      create: (_) => CreateStoreCubit(
        storeDetailsCubit: StoreDetailsCubit(),
        storeAddressCubit: StoreAddressCubit(),
        deliveryMethodsCubit: DeliveryMethodsCubit(
          getDeliveryMethodsRepository: GetDeliveryMethodsRepository(
            sellerId: context.read<AuthenticationRepository>().currentUser.id,
          ),
        )..addMethod(),
        imageUploaderCubit: ImageUploaderCubit(
          imageUploaderRepository: ConcreteImageUploaderRepository(
            fileReaderService: FileReaderService(),
            uploadPath:
                "/stores/${context.read<AuthenticationRepository>().currentUser.id}",
          ),
        ),
        authenticationRepository: context.read<AuthenticationRepository>(),
        createStoreRepository: CreateStoreRepository(),
      ),
      child: BlocConsumer<CreateStoreCubit, CreateStoreState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? "Creation Failure"),
                ),
              );
          }
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text("Store Created!"),
                ),
              );
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          final createStoreCubit = context.read<CreateStoreCubit>();

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const StoreDetailsView(),
                        StoreAddressView(
                          storeAddressCubit: createStoreCubit.storeAddressCubit,
                        ),
                        DeliveryMethodsView(
                          deliveryMethodsCubit:
                              createStoreCubit.deliveryMethodsCubit,
                        ),
                        ImageUploadForm(
                          imageUploaderCubit:
                              createStoreCubit.imageUploaderCubit,
                        ),
                        ElevatedButton(
                          onPressed: state.isValidated
                              ? createStoreCubit.submit
                              : null,
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                  if (state.status == FormzStatus.submissionInProgress)
                    Container(
                      color: Colors.black.withOpacity(0.5), // Optional
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
