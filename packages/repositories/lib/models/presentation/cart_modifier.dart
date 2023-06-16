import 'package:equatable/equatable.dart';

abstract class CartModifier extends Equatable {
  final String title;
  final bool required;
  final String id;
  const CartModifier(this.title, this.required, this.id);

  static List<CartModifier> parseModifiersFromJson(List<dynamic> jsonArray) {
    List<CartModifier> modifiers = [];

    for (var item in jsonArray) {
      Map<String, dynamic> itemMap = item as Map<String, dynamic>;

      // Here, you could use a specific key in the JSON to determine the type of Modifier.
      // For example, if you have a "type" key in the JSON, you could check its value.
      // Assuming your JSON contains a "type" key with values "text" or "multi_choice".

      if (itemMap['type'] == 'text') {
        modifiers.add(CartTextModifier.fromJson(itemMap));
      } else if (itemMap['type'] == 'multi_choice') {
        modifiers.add(CartMultiChoiceModifier.fromJson(itemMap));
      }
    }

    return modifiers;
  }
}

class CartTextModifier extends CartModifier {
  final String characterLimit;
  final String price;
  final String fillText;

  const CartTextModifier(
      {this.characterLimit = '',
      this.price = '',
      this.fillText = '',
      String title = '',
      bool required = true,
      String id = ''})
      : super(
          title,
          required,
          id,
        );

  @override
  List<Object?> get props => [characterLimit, price, fillText, title, required];

  factory CartTextModifier.fromJson(Map<String, dynamic> json) {
    return CartTextModifier(
      characterLimit: json['characterLimit'] as String,
      price: json['price'] as String,
      fillText: json['fillText'] as String,
      title: json['title'] as String,
      required: json['required'] as bool,
      id: json['id'] as String,
    );
  }
}

class CartMultiChoiceModifier extends CartModifier {
  final List<CartChoice>? choices;
  final int defaultChoice;

  const CartMultiChoiceModifier(
      {this.choices = const [],
      this.defaultChoice = -1,
      String title = '',
      bool required = true,
      String id = ''})
      : super(
          title,
          required,
          id,
        );

  @override
  List<Object?> get props => [
        choices,
        defaultChoice,
        title,
        required,
      ];

  factory CartMultiChoiceModifier.fromJson(Map<String, dynamic> json) {
    return CartMultiChoiceModifier(
      choices: (json['choices'] as List)
          .map((e) => CartChoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultChoice: json['defaultChoice'] as int,
      title: json['title'] as String,
      required: json['required'] as bool,
      id: json['id'] as String,
    );
  }
}

class CartChoice extends Equatable {
  final String title;
  final String price;
  final String id;

  const CartChoice({
    this.title = '',
    this.price = '',
    this.id = '',
  });

  @override
  List<Object?> get props => [
        title,
        price,
        id,
      ];

  factory CartChoice.fromJson(Map<String, dynamic> json) {
    return CartChoice(
      title: json['title'] as String,
      price: json['price'] as String,
      id: json['id'] as String,
    );
  }
}
