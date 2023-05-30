part of 'modifier_cubit.dart';

class ModifierState {
  final List<Modifier> modifiers;
  final FormzStatus status;

  ModifierState({
    this.modifiers = const [],
    this.status = FormzStatus.pure,
  });

  ModifierState copyWith({
    List<Modifier>? modifiers,
    FormzStatus? status,
  }) {
    return ModifierState(
      modifiers: modifiers ?? this.modifiers,
      status: status ?? this.status,
    );
  }
}

abstract class Modifier extends Equatable {
  final ModifierTitle title;
  final bool required;
  const Modifier(this.title, this.required);

  Modifier copyWith({ModifierTitle? title, bool? required});
}

class TextModifier extends Modifier {
  final TextModifierCharacterLimit characterLimit;

  final ProductPrice price;
  final TextModifierFillText fillText;

  const TextModifier({
    this.characterLimit = const TextModifierCharacterLimit.pure(),
    this.price = const ProductPrice.pure(),
    this.fillText = const TextModifierFillText.pure(),
    ModifierTitle title = const ModifierTitle.pure(),
    bool required = true,
  }) : super(
          title,
          required,
        );

  @override
  List<Object?> get props => [characterLimit, price, fillText, title, required];

  @override
  TextModifier copyWith({
    TextModifierCharacterLimit? characterLimit,
    ProductPrice? price,
    TextModifierFillText? fillText,
    ModifierTitle? title,
    bool? required,
  }) {
    return TextModifier(
      characterLimit: characterLimit ?? this.characterLimit,
      price: price ?? this.price,
      fillText: fillText ?? this.fillText,
      title: title ?? this.title,
      required: required ?? this.required,
    );
  }
}

class MultiChoiceModifier extends Modifier {
  final List<Choice>? choices;
  final int? defaultChoice;

  const MultiChoiceModifier({
    this.choices = const [],
    this.defaultChoice,
    ModifierTitle title = const ModifierTitle.pure(),
    bool required = false,
  }) : super(title, required);

  @override
  List<Object?> get props => [choices, defaultChoice, title, required];

  @override
  MultiChoiceModifier copyWith({
    List<Choice>? choices,
    int? defaultChoice,
    ModifierTitle? title,
    bool? required,
  }) {
    return MultiChoiceModifier(
      choices: choices ?? this.choices,
      defaultChoice: defaultChoice ?? this.defaultChoice,
      title: title ?? this.title,
      required: required ?? this.required,
    );
  }
}

class Choice extends Equatable {
  final ModifierTitle title;
  final ProductPrice price;

  const Choice({
    this.title = const ModifierTitle.pure(),
    this.price = const ProductPrice.pure(),
  });

  @override
  List<Object?> get props => [
        title,
        price,
      ];

  Choice copyWith({
    ModifierTitle? title,
    ProductPrice? price,
  }) {
    return Choice(
      price: price ?? this.price,
      title: title ?? this.title,
    );
  }
}
