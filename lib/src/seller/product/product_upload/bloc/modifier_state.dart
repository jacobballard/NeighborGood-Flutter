part of 'modifier_cubit.dart';

class ProductUploadModifierState extends Equatable {
  const ProductUploadModifierState({
    this.modifierType = const ModifierType.pure(),
    this.characterLimit = const CharacterLimit.pure(),
    this.pickerOptionCubits = const <PickerOptionCubit>[],
    this.status = FormzStatus.pure,
  });

  final ModifierType modifierType;
  final CharacterLimit characterLimit;
  final List<PickerOptionCubit> pickerOptionCubits;
  final FormzStatus status;

  @override
  List<Object> get props =>
      [modifierType, characterLimit, pickerOptionCubits, status];

  ProductUploadModifierState copyWith({
    ModifierType? modifierType,
    CharacterLimit? characterLimit,
    List<PickerOptionCubit>? pickerOptionCubits,
    FormzStatus? status,
  }) {
    return ProductUploadModifierState(
      modifierType: modifierType ?? this.modifierType,
      characterLimit: characterLimit ?? this.characterLimit,
      pickerOptionCubits: pickerOptionCubits ?? this.pickerOptionCubits,
      status: status ?? this.status,
    );
  }
}
