import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:form_inputs/form_inputs.dart';

class PickerOptionState extends Equatable {
  const PickerOptionState({
    this.optionName = const OptionName.pure(),
    this.optionPrice = const OptionPrice.pure(),
    this.status = FormzStatus.pure,
  });

  final OptionName optionName;
  final OptionPrice optionPrice;
  final FormzStatus status;

  PickerOptionState copyWith({
    OptionName? optionName,
    OptionPrice? optionPrice,
    FormzStatus? status,
  }) {
    return PickerOptionState(
      optionName: optionName ?? this.optionName,
      optionPrice: optionPrice ?? this.optionPrice,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [optionName, optionPrice, status];
}
