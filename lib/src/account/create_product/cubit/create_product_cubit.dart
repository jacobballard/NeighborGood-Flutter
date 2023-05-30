import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:goods_rapid/create_product/modifier_cubit.dart';
import 'package:goods_rapid/create_product/product_details_cubit.dart';
import 'package:goods_rapid/create_store/image_uploader_cubit.dart';
import 'package:goods_rapid/create_store/store_address_cubit.dart';
import 'package:goods_rapid/create_store/store_details_cubit.dart';

import '../create_store/delivery_method_cubit.dart';

part 'create_product_state.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  final ProductDetailsCubit productDetailsCubit;
  final ModifierCubit modifierCubit;
  final DeliveryMethodsCubit deliveryMethodsCubit;
  final ImageUploaderCubit imageUploaderCubit;
  late final StreamSubscription _productDetailsSubscription;
  late final StreamSubscription _modifierSubscription;
  late final StreamSubscription _deliveryMethodsSubscription;
  late final StreamSubscription _imageUploaderSubscription;
  CreateProductCubit({
    required this.productDetailsCubit,
    required this.modifierCubit,
    required this.deliveryMethodsCubit,
    required this.imageUploaderCubit,
  }) : super(CreateProductState()) {
    _productDetailsSubscription = productDetailsCubit.stream.listen((state) {
      emit(CreateProductState(
          productDetailsStatus: state.status,
          productModifiersStatus: this.state.productModifiersStatus,
          deliveryMethodsStatus: this.state.deliveryMethodsStatus,
          imageUploaderStatus: this.state.imageUploaderStatus));
    });

    _modifierSubscription = modifierCubit.stream.listen((state) {
      emit(CreateProductState(
          productDetailsStatus: this.state.productDetailsStatus,
          productModifiersStatus: state.status,
          deliveryMethodsStatus: this.state.deliveryMethodsStatus,
          imageUploaderStatus: this.state.imageUploaderStatus));
    });
    _imageUploaderSubscription = imageUploaderCubit.stream.listen((state) {
      emit(CreateProductState(
          productDetailsStatus: this.state.productDetailsStatus,
          productModifiersStatus: this.state.productModifiersStatus,
          deliveryMethodsStatus: this.state.deliveryMethodsStatus,
          imageUploaderStatus: state.status));
    });

    _deliveryMethodsSubscription = deliveryMethodsCubit.stream.listen((state) {
      emit(CreateProductState(
          productDetailsStatus: this.state.productDetailsStatus,
          productModifiersStatus: this.state.productModifiersStatus,
          deliveryMethodsStatus: state.status,
          imageUploaderStatus: this.state.imageUploaderStatus));
    });
  }

  @override
  Future<void> close() {
    _productDetailsSubscription.cancel();
    _modifierSubscription.cancel();
    _deliveryMethodsSubscription.cancel();
    _imageUploaderSubscription.cancel();
    return super.close();
  }

  void submit() {
    if (!state.isValidated) return;
    // TODO : Call repo to submit here
  }
}
