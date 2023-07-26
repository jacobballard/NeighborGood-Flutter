import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pastry/src/account/create_store/cubit/create_store_cubit.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:pastry/src/account/create_store/cubit/onboarding_cubit.dart';
import 'package:pastry/src/account/create_store/view/create_store.dart';

import 'package:repositories/repositories.dart';

import '../../utilities/delivery_methods/delivery_method_cubit.dart';

import '../../utilities/image_upload/abstract_file_reader_service.dart';

import '../../utilities/image_upload/image_uploader_cubit.dart';
import '../../utilities/image_upload/image_uploader_repository.dart';
import '../cubit/store_address_cubit.dart';
import '../cubit/store_details_cubit.dart';
import 'onboarding_details.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    var createStoreCubit = CreateStoreCubit(
      storeDetailsCubit: StoreDetailsCubit(),
      storeAddressCubit: StoreAddressCubit(),
      deliveryMethodsCubit: DeliveryMethodsCubit(
        getDeliveryMethodsRepository: GetDeliveryMethodsRepository(
          sellerId:
              context.read<AuthenticationRepository>().currentUser.id ?? "",
        ),
      )..addMethod(),
      imageUploaderCubit: ImageUploaderCubit(
        imageUploaderRepository: ConcreteImageUploaderRepository(
          fileReaderService: FileReaderService(),
          uploadPath:
              "/stores/${context.read<AuthenticationRepository>().currentUser.id}",
        ),
      ),
      onboardingCubit: OnboardingCubit(),
      authenticationRepository: context.read<AuthenticationRepository>(),
      createStoreRepository: CreateStoreRepository(),
    );
    return BlocProvider(
      create: (context) => createStoreCubit,
      child: Builder(
        builder: (context) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Onboarding'),
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: BlocConsumer<CreateStoreCubit, CreateStoreState>(
                listener: (context, state) {
                  // You can handle state changes here.
                },
                builder: (context, state) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        OnboardingDetailsView(),
                      ],
                    ),
                  );
                },
              ),
              floatingActionButton: BlocProvider<OnboardingCubit>.value(
                value: createStoreCubit.onboardingCubit,
                child: BlocBuilder<OnboardingCubit, OnboardingState>(
                  builder: (context, state) {
                    print("built again");
                    return FloatingActionButton(
                      onPressed: (state.status.isValid && state.tosAccepted)
                          ? () {
                              print("tapped");
                              Navigator.of(context, rootNavigator: false).push(
                                MaterialPageRoute(
                                  builder: (context) => CreateStoreView(
                                    createStoreCubit: createStoreCubit,
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: const Icon(Icons.arrow_forward),
                    );
                  },
                ),
              ));
        },
      ),
    );
  }
}
