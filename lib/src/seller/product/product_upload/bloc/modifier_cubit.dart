// // Import the necessary packages at the top
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:form_inputs/form_inputs.dart';
// import 'package:formz/formz.dart';
// import 'package:pastry/src/seller/product/product_upload/bloc/picker_option_cubit.dart';

// part 'modifier_state.dart';

// class ProductUploadModifierCubit extends Cubit<ProductUploadModifierState> {
//   ProductUploadModifierCubit() : super(const ProductUploadModifierState());

//   void modifierTypeChanged(String? value) {
//     final modifierType = ModifierType.dirty(value);
//     emit(state.copyWith(modifierType: modifierType));
//   }

//   void characterLimitChanged(int value) {
//     final characterLimit = CharacterLimit.dirty(value);
//     emit(state.copyWith(characterLimit: characterLimit));
//   }

//   void addPickerOption() {
//     emit(state.copyWith(
//       pickerOptionCubits: List<PickerOptionCubit>.from(state.pickerOptionCubits)
//         ..add(PickerOptionCubit()),
//     ));
//   }

//   void removePickerOption(int index) {
//     emit(state.copyWith(
//       pickerOptionCubits: List<PickerOptionCubit>.from(state.pickerOptionCubits)
//         ..removeAt(index),
//     ));
//   }
// }
