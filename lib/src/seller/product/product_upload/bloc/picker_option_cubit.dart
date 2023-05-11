import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:pastry/src/seller/product/product_upload/bloc/picker_option_state.dart';

class PickerOptionCubit extends Cubit<PickerOptionState> {
  PickerOptionCubit() : super(const PickerOptionState());

  void optionNameChanged(String value) {
    final optionName = OptionName.dirty(value);
    emit(state.copyWith(optionName: optionName));
  }

  void optionPriceChanged(double value) {
    final optionPrice = OptionPrice.dirty(value);
    emit(state.copyWith(optionPrice: optionPrice));
  }
}
