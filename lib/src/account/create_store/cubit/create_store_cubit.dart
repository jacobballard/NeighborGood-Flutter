import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:goods_rapid/create_store/image_uploader_cubit.dart';
import 'package:goods_rapid/create_store/store_address_cubit.dart';
import 'package:goods_rapid/create_store/store_details_cubit.dart';

import 'delivery_method_cubit.dart';

part 'create_store_state.dart';

class CreateStoreCubit extends Cubit<CreateStoreState> {
  final StoreDetailsCubit storeDetailsCubit;
  final StoreAddressCubit storeAddressCubit;
  final DeliveryMethodsCubit deliveryMethodsCubit;
  final ImageUploaderCubit imageUploaderCubit;
  late final StreamSubscription _storeDetailsSubscription;
  late final StreamSubscription _storeAddressSubscription;
  late final StreamSubscription _deliveryMethodsSubscription;
  late final StreamSubscription _imageUploaderSubscription;
  CreateStoreCubit({
    required this.storeDetailsCubit,
    required this.storeAddressCubit,
    required this.deliveryMethodsCubit,
    required this.imageUploaderCubit,
  }) : super(CreateStoreState()) {
    _storeDetailsSubscription = storeDetailsCubit.stream.listen((state) {
      emit(CreateStoreState(
          storeDetailsStatus: state.status,
          storeAddressStatus: this.state.storeAddressStatus,
          deliveryMethodsStatus: this.state.deliveryMethodsStatus,
          imageUploaderStatus: this.state.imageUploaderStatus));
    });

    _storeAddressSubscription = storeAddressCubit.stream.listen((state) {
      emit(CreateStoreState(
          storeDetailsStatus: this.state.storeDetailsStatus,
          storeAddressStatus: state.isZipcodeOnlyOrAllFieldsValid,
          deliveryMethodsStatus: this.state.deliveryMethodsStatus,
          imageUploaderStatus: this.state.imageUploaderStatus));
    });
    _imageUploaderSubscription = imageUploaderCubit.stream.listen((state) {
      emit(CreateStoreState(
          storeDetailsStatus: this.state.storeDetailsStatus,
          storeAddressStatus: this.state.storeAddressStatus,
          deliveryMethodsStatus: this.state.deliveryMethodsStatus,
          imageUploaderStatus: state.status));
    });

    _deliveryMethodsSubscription = deliveryMethodsCubit.stream.listen((state) {
      emit(CreateStoreState(
          storeDetailsStatus: this.state.storeDetailsStatus,
          storeAddressStatus: this.state.storeAddressStatus,
          deliveryMethodsStatus: state.status,
          imageUploaderStatus: this.state.imageUploaderStatus));
    });
  }

  @override
  Future<void> close() {
    _storeDetailsSubscription.cancel();
    _storeAddressSubscription.cancel();
    _deliveryMethodsSubscription.cancel();
    _imageUploaderSubscription.cancel();
    return super.close();
  }

  void submit() {
    if (!state.isValidated) return;
    // TODO : Call repo to submit here
  }
}
