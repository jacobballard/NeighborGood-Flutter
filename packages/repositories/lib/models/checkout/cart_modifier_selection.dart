import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';

abstract class CartModifierSelection extends Equatable {
  final String id;
  final bool required;
  const CartModifierSelection(this.id, this.required);
  Map<String, dynamic> toJson();
  CartModifierSelection copyWith({
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
    required bool required,
  }) : super(id, required);

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
  }) {
    return CartMultiChoiceModifierSelection(
      id: id ?? this.id,
      choiceId: choiceId ?? this.choiceId,
      required: required ?? this.required,
    );
  }

  @override
  List<Object?> get props => [
        id,
        choiceId,
        required,
      ];
}

class CartTextModifierSelection extends CartModifierSelection {
  final CartTextModifierInput cartTextModifierInput;

  CartTextModifierSelection(
      {this.cartTextModifierInput = const CartTextModifierInput.pure(),
      required String id,
      required bool required})
      : super(
          id,
          required,
        );

  @override
  List<Object?> get props => [
        cartTextModifierInput,
        id,
        required,
      ];

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
    String? id,
    CartTextModifierInput? cartTextModifierInput,
    bool? required,
  }) {
    return CartTextModifierSelection(
      id: id ?? this.id,
      cartTextModifierInput:
          cartTextModifierInput ?? this.cartTextModifierInput,
      required: required ?? this.required,
    );
  }
}
