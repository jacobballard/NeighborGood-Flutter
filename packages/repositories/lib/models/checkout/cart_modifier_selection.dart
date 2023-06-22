import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';

abstract class CartModifierSelection extends Equatable {
  final String id;
  final bool required;
  final String? price;
  final String question;
  final String answer;
  const CartModifierSelection(
      this.id, this.required, this.price, this.question, this.answer);
  Map<String, dynamic> toJson();
  CartModifierSelection copyWith({
    String? price,
    String? id,
    bool? required,
  });
  static List<Map<String, dynamic>> cartModifierSelectionToJson(
      List<CartModifierSelection> selections) {
    return selections.map((selection) => selection.toJson()).toList();
  }
}

class CartMultiChoiceModifierSelection extends CartModifierSelection {
  final String choiceId;

  CartMultiChoiceModifierSelection({
    this.choiceId = '',
    required String id,
    required String question,
    required String answer,
    required bool required,
    required String? price,
  }) : super(id, required, price, question, answer);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': 'multi_choice',
      'input': this.choiceId,
    };
  }

  @override
  CartMultiChoiceModifierSelection copyWith({
    String? id,
    String? choiceId,
    bool? required,
    String? price,
    String? question,
    String? answer,
  }) {
    return CartMultiChoiceModifierSelection(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      price: price ?? this.price,
      id: id ?? this.id,
      choiceId: choiceId ?? this.choiceId,
      required: required ?? this.required,
    );
  }

  @override
  List<Object?> get props => [id, choiceId, required, price, question, answer];
}

class CartTextModifierSelection extends CartModifierSelection {
  final CartTextModifierInput cartTextModifierInput;

  CartTextModifierSelection(
      {this.cartTextModifierInput = const CartTextModifierInput.pure(),
      required String id,
      required String question,
      required String answer,
      required String? price,
      required bool required})
      : super(id, required, price, question, answer);

  @override
  List<Object?> get props =>
      [cartTextModifierInput, id, required, price, question, answer];

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': 'text',
      'input': this.cartTextModifierInput.value,
    };
  }

  @override
  CartTextModifierSelection copyWith({
    String? price,
    String? id,
    CartTextModifierInput? cartTextModifierInput,
    bool? required,
    String? question,
    String? answer,
  }) {
    return CartTextModifierSelection(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      price: price ?? this.price,
      id: id ?? this.id,
      cartTextModifierInput:
          cartTextModifierInput ?? this.cartTextModifierInput,
      required: required ?? this.required,
    );
  }
}
