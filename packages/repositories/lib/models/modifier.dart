import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';

abstract class Modifier extends Equatable {
  final ModifierTitle title;
  final bool required;
  const Modifier(this.title, this.required);

  Modifier copyWith({ModifierTitle? title, bool? required});
  Map<String, dynamic> toJson();
  static List<Modifier> parseModifiersFromJson(List<dynamic> jsonArray) {
    List<Modifier> modifiers = [];

    for (var item in jsonArray) {
      Map<String, dynamic> itemMap = item as Map<String, dynamic>;

      // Here, you could use a specific key in the JSON to determine the type of Modifier.
      // For example, if you have a "type" key in the JSON, you could check its value.
      // Assuming your JSON contains a "type" key with values "text" or "multi_choice".

      if (itemMap['type'] == 'text') {
        modifiers.add(TextModifier.fromJson(itemMap));
      } else if (itemMap['type'] == 'multi_choice') {
        modifiers.add(MultiChoiceModifier.fromJson(itemMap));
      }
    }

    return modifiers;
  }

  static List<Map<String, dynamic>> toJsonList(List<Modifier>? modifiers) {
    return modifiers?.map((modifier) => modifier.toJson()).toList() ?? [];
  }
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

  factory TextModifier.fromJson(Map<String, dynamic> json) {
    return TextModifier(
      characterLimit: TextModifierCharacterLimit.dirty(json['characterLimit']),
      price: ProductPrice.dirty(json['price']),
      fillText: TextModifierFillText.dirty(json['fillText']),
      title: ModifierTitle.dirty(json['title']),
      required: json['required'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'characterLimit': this.characterLimit.value,
      'price': this.price.value,
      'fillText': this.fillText.value,
      'title': this.title.value,
      'required': this.required,
    };
  }

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

  factory MultiChoiceModifier.fromJson(Map<String, dynamic> json) {
    return MultiChoiceModifier(
      choices: (json['choices'] as List)
          .map((e) => Choice.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultChoice: json['defaultChoice'] as int,
      title: ModifierTitle.dirty(json['title']),
      required: json['required'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'choices': this.choices?.map((e) => e.toJson()).toList(),
      'defaultChoice': this.defaultChoice,
      'title': this.title.value,
      'required': this.required,
    };
  }

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

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      title: ModifierTitle.dirty(json['title']),
      price: ProductPrice.dirty(json['price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': this.title.value,
      'price': this.price.value,
    };
  }

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
