import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:pastry/src/seller/product/product_upload/bloc/modifier_cubit.dart';

part 'product_upload_state.dart';

class ProductUploadCubit extends Cubit<ProductUploadState> {
  ProductUploadCubit() : super(const ProductUploadState());

  void productNameChanged(String value) {
    final productName = ProductName.dirty(value);
    emit(state.copyWith(
      productName: productName,
      status: Formz.validate([
        productName,
        state.description,
        state.basePrice,
      ]),
    ));
  }

  void descriptionChanged(String value) {
    final description = Description.dirty(value);
    emit(state.copyWith(
      description: description,
      status: Formz.validate([
        state.productName,
        description,
        state.basePrice,
      ]),
    ));
  }

  void basePriceChanged(double value) {
    final basePrice = BasePrice.dirty(value);
    emit(state.copyWith(
      basePrice: basePrice,
      status: Formz.validate([
        state.productName,
        state.description,
        basePrice,
      ]),
    ));
  }

  void addModifier() {
    final updatedModifierCubits =
        List<ProductUploadModifierCubit>.from(state.modifierCubits)
          ..add(ProductUploadModifierCubit());
    emit(state.copyWith(modifierCubits: updatedModifierCubits));
  }

  void removeModifier(int index) {
    final removedCubit = state.modifierCubits[index];
    final updatedModifierCubits =
        List<ProductUploadModifierCubit>.from(state.modifierCubits)
          ..removeAt(index);
    emit(state.copyWith(modifierCubits: updatedModifierCubits));
    removedCubit.close();
  }

  Future<void> uploadProduct() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      // Implement your product uploading logic here

      // Emit success state if product upload is successful
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      // Emit failure state if product upload fails
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
      ));
    }
  }
}
