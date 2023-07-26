import 'package:authentication_repository/authentication_repository.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pastry/src/account/create_store/view/store_address.dart';
import 'package:pastry/src/account/create_store/view/store_details.dart';

import '../../utilities/delivery_methods/delivery_methods.dart';

import '../../utilities/image_upload/image_uploader.dart';
import '../cubit/create_store_cubit.dart';

class CreateStoreView extends StatelessWidget {
  final CreateStoreCubit createStoreCubit;
  const CreateStoreView({
    Key? key,
    required this.createStoreCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("gonna read");

    print("uid: ${context.read<AuthenticationRepository>().currentUser.id}");
    return BlocProvider.value(
      value: createStoreCubit,
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
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Store Details"),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          const StoreDetailsView(),
                          const SizedBox(
                            height: 8,
                          ),
                          StoreAddressView(
                            isCheckout: true,
                            storeAddressCubit:
                                createStoreCubit.storeAddressCubit,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          DeliveryMethodsView(
                            deliveryMethodsCubit:
                                createStoreCubit.deliveryMethodsCubit,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ImageUploadForm(
                            imageUploaderCubit:
                                createStoreCubit.imageUploaderCubit,
                          ),
                          const SizedBox(
                            height: 8,
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
                  ),
                  if (state.status == FormzStatus.submissionInProgress)
                    Container(
                      color: Colors.black.withOpacity(0.5), // Optional
                      child: const Center(
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
