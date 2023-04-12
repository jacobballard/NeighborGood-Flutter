// Import the necessary packages at the top
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';

part 'modifier_state.dart';

class ProductUploadModifierCubit extends Cubit<ProductUploadModifierState> {
  ProductUploadModifierCubit() : super(const ProductUploadModifierState());

  void modifierTypeChanged(String? value) {
    final modifierType = ModifierType.dirty(value);
    emit(state.copyWith(modifierType: modifierType));
  }

  void characterLimitChanged(int value) {
    final characterLimit = CharacterLimit.dirty(value);
    emit(state.copyWith(characterLimit: characterLimit));
  }

  void addPickerOption(String option, double price) {
    final pickerOption = PickerOption.dirty(option, price);
    emit(
      state.copyWith(
        pickerOptions: List<PickerOption>.from(state.pickerOptions)
          ..add(pickerOption),
      ),
    );
  }

  void updatePickerOption(int index, String option, double price) {
    final pickerOption = PickerOption.dirty(option, price);
    final updatedPickerOptions = List<PickerOption>.from(state.pickerOptions);
    updatedPickerOptions[index] = pickerOption;

    emit(state.copyWith(pickerOptions: updatedPickerOptions));
  }

  void removePickerOption(int index) {
    final updatedPickerOptions = List<PickerOption>.from(state.pickerOptions)
      ..removeAt(index);
    emit(state.copyWith(pickerOptions: updatedPickerOptions));
  }
}
