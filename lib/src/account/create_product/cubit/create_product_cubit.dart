import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pastry/src/account/create_product/cubit/product_details_cubit.dart';
import 'package:repositories/repositories.dart';

import '../../utilities/delivery_methods/delivery_method_cubit.dart';
import '../../utilities/image_upload/image_uploader_cubit.dart';
import 'modifier_cubit.dart';

part 'create_product_state.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  final ProductDetailsCubit productDetailsCubit;
  final ModifierCubit modifierCubit;
  final DeliveryMethodsCubit deliveryMethodsCubit;
  final ImageUploaderCubit imageUploaderCubit;
  final String productId;
  final CreateProductRepository createProductRepository;
  final AuthenticationRepository authenticationRepository;
  late final StreamSubscription _productDetailsSubscription;
  late final StreamSubscription _modifierSubscription;
  late final StreamSubscription _deliveryMethodsSubscription;
  late final StreamSubscription _imageUploaderSubscription;
  CreateProductCubit({
    required this.productDetailsCubit,
    required this.modifierCubit,
    required this.deliveryMethodsCubit,
    required this.imageUploaderCubit,
    required this.createProductRepository,
    required this.authenticationRepository,
    required this.productId,
  }) : super(const CreateProductState()) {
    _productDetailsSubscription = productDetailsCubit.stream.listen((state) {
      print("prod det");
      print(state.title.value);
      print(this.state.productModifiersStatus);
      emit(CreateProductState(
          productDetailsStatus: state.status,
          productModifiersStatus: this.state.productModifiersStatus,
          deliveryMethodsStatus: this.state.deliveryMethodsStatus,
          imageUploaderStatus: this.state.imageUploaderStatus));
    });

    _modifierSubscription = modifierCubit.stream.listen((state) {
      print("mod sub");
      print(state.status);
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

  Future<void> submit() async {
    if (!state.isValidated) return;

    print("submitting");
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await createProductRepository.create(
        token: await authenticationRepository.getIdToken(),
        title: productDetailsCubit.state.title.value,
        description: productDetailsCubit.state.description.value,
        price: productDetailsCubit.state.price.value,
        deliveryMethods: deliveryMethodsCubit.state.methods,
        modifiers: modifierCubit
            .state.modifiers, // Assuming you have a modifiers field in state
        // Add other product details here as needed
      );

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on CreateProductFailure catch (e) {
      // Assuming you have a CreateProductFailure exception class similar to CreateStoreFailure
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
