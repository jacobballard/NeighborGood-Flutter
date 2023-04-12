part of 'modifier_cubit.dart';

class ProductUploadModifierState extends Equatable {
  final ModifierType modifierType;
  final CharacterLimit characterLimit;
  final List<PickerOption> pickerOptions;

  const ProductUploadModifierState({
    this.modifierType = const ModifierType.pure(),
    this.characterLimit = const CharacterLimit.pure(),
    this.pickerOptions = const [],
  });

  ProductUploadModifierState copyWith({
    ModifierType? modifierType,
    CharacterLimit? characterLimit,
    List<PickerOption>? pickerOptions,
  }) {
    return ProductUploadModifierState(
      modifierType: modifierType ?? this.modifierType,
      characterLimit: characterLimit ?? this.characterLimit,
      pickerOptions: pickerOptions ?? this.pickerOptions,
    );
  }

  @override
  List<Object> get props => [modifierType, characterLimit, pickerOptions];
}
