import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pastry/src/account/create_store/cubit/onboarding_cubit.dart';
import 'package:pastry/src/account/create_store/cubit/store_address_cubit.dart';
import 'package:pastry/src/account/create_store/cubit/store_details_cubit.dart';
import 'package:repositories/models/address.dart';
import 'package:repositories/repositories.dart';

import '../../utilities/delivery_methods/delivery_method_cubit.dart';
import '../../utilities/image_upload/image_uploader_cubit.dart';

part 'create_store_state.dart';

class CreateStoreCubit extends Cubit<CreateStoreState> {
  final StoreDetailsCubit storeDetailsCubit;
  final StoreAddressCubit storeAddressCubit;
  final DeliveryMethodsCubit deliveryMethodsCubit;
  final ImageUploaderCubit imageUploaderCubit;
  final OnboardingCubit onboardingCubit;
  final CreateStoreRepository createStoreRepository;

  final AuthenticationRepository authenticationRepository;
  late final StreamSubscription _storeDetailsSubscription;
  late final StreamSubscription _storeAddressSubscription;
  late final StreamSubscription _deliveryMethodsSubscription;
  late final StreamSubscription _imageUploaderSubscription;
  late final StreamSubscription _onboardingSubscription;
  CreateStoreCubit({
    required this.storeDetailsCubit,
    required this.storeAddressCubit,
    required this.deliveryMethodsCubit,
    required this.imageUploaderCubit,
    required this.onboardingCubit,
    required this.createStoreRepository,
    required this.authenticationRepository,
  }) : super(const CreateStoreState()) {
    _storeDetailsSubscription = storeDetailsCubit.stream.listen((state) {
      emit(CreateStoreState(
        storeDetailsStatus: state.status,
        storeAddressStatus: this.state.storeAddressStatus,
        deliveryMethodsStatus: this.state.deliveryMethodsStatus,
        imageUploaderStatus: this.state.imageUploaderStatus,
        onboardingStatus: this.state.onboardingStatus,
      ));
    });

    _storeAddressSubscription = storeAddressCubit.stream.listen((state) {
      emit(CreateStoreState(
        storeDetailsStatus: this.state.storeDetailsStatus,
        storeAddressStatus: state.isZipcodeOnlyOrAllFieldsValid,
        deliveryMethodsStatus: this.state.deliveryMethodsStatus,
        imageUploaderStatus: this.state.imageUploaderStatus,
        onboardingStatus: this.state.onboardingStatus,
      ));
    });
    _imageUploaderSubscription = imageUploaderCubit.stream.listen((state) {
      emit(CreateStoreState(
        storeDetailsStatus: this.state.storeDetailsStatus,
        storeAddressStatus: this.state.storeAddressStatus,
        deliveryMethodsStatus: this.state.deliveryMethodsStatus,
        imageUploaderStatus: state.status,
        onboardingStatus: this.state.onboardingStatus,
      ));
    });

    _deliveryMethodsSubscription = deliveryMethodsCubit.stream.listen((state) {
      emit(CreateStoreState(
        storeDetailsStatus: this.state.storeDetailsStatus,
        storeAddressStatus: this.state.storeAddressStatus,
        deliveryMethodsStatus: state.status,
        imageUploaderStatus: this.state.imageUploaderStatus,
        onboardingStatus: this.state.onboardingStatus,
      ));
    });

    _onboardingSubscription = onboardingCubit.stream.listen((state) {
      print(state.status);
      print(state.status.isValid);
      print("status");
      emit(CreateStoreState(
        storeDetailsStatus: this.state.storeDetailsStatus,
        storeAddressStatus: this.state.storeAddressStatus,
        deliveryMethodsStatus: this.state.deliveryMethodsStatus,
        imageUploaderStatus: this.state.imageUploaderStatus,
        onboardingStatus: state.status,
      ));
    });
  }

  @override
  Future<void> close() {
    _storeDetailsSubscription.cancel();
    _storeAddressSubscription.cancel();
    _deliveryMethodsSubscription.cancel();
    _imageUploaderSubscription.cancel();
    _onboardingSubscription.cancel();
    return super.close();
  }

  Future<void> submit() async {
    if (!state.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      bool isBusiness =
          onboardingCubit.state.businessType == BusinessType.business;
      if (isBusiness) {
        await createStoreRepository.create(
            type: onboardingCubit.state.businessType,
            companyName: onboardingCubit.state.companyName.value,
            companyTaxId: onboardingCubit.state.companyTaxId.value,
            token: await authenticationRepository.getIdToken(),
            title: storeDetailsCubit.state.title.value,
            address: Address(
              storeAddressCubit.state.addressLine1.value,
              storeAddressCubit.state.addressLine2.value,
              storeAddressCubit.state.city.value,
              storeAddressCubit.state.stateName,
              storeAddressCubit.state.zipCode.value,
            ),
            deliveryMethods: deliveryMethodsCubit.state.methods,
            description: storeDetailsCubit.state.description.value);
      } else {
        await createStoreRepository.create(
            type: onboardingCubit.state.businessType,
            firstName: onboardingCubit.state.firstName.value,
            lastName: onboardingCubit.state.lastName.value,
            birthDay: onboardingCubit.state.day.value,
            birthMonth: onboardingCubit.state.month.value,
            birthYear: onboardingCubit.state.year.value,
            ssnLastFour: onboardingCubit.state.ssLastFour.value,
            token: await authenticationRepository.getIdToken(),
            title: storeDetailsCubit.state.title.value,
            address: Address(
              storeAddressCubit.state.addressLine1.value,
              storeAddressCubit.state.addressLine2.value,
              storeAddressCubit.state.city.value,
              storeAddressCubit.state.stateName,
              storeAddressCubit.state.zipCode.value,
            ),
            deliveryMethods: deliveryMethodsCubit.state.methods,
            description: storeDetailsCubit.state.description.value);
      }
      if (createStoreRepository.suggestedAddress != null) {
        print("there's something suggest");
        storeAddressCubit
            .addSuggestedAddress(createStoreRepository.suggestedAddress);
        createStoreRepository.suggestedAddress = null;
        emit(state.copyWith(
            // status: FormzStatus.submissionFailure,

            errorMessage: "Verify your address"));
      } else {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      }
    } on CreateStoreFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }
}
