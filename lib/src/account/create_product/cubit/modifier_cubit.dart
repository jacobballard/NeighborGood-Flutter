import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../model/validation.dart';

part 'modifier_state.dart';

class ModifierCubit extends Cubit<ModifierState> {
  ModifierCubit() : super(ModifierState());

  void addTextModifier() {
    print("adding");
    var modifiers = List<Modifier>.from(state.modifiers)
      ..add(const TextModifier());
    print(modifiers);
    emit(state.copyWith(
      modifiers: modifiers,
      status: _computeStatus(modifiers),
    ));
  }

  void addMultiChoiceModifier() {
    var modifiers = List<Modifier>.from(state.modifiers)
      ..add(const MultiChoiceModifier());
    print(modifiers);
    emit(state.copyWith(
      modifiers: modifiers,
      status: _computeStatus(modifiers),
    ));
  }

  void removeModifier(int index) {
    final modifiers = state.modifiers;
    modifiers.removeAt(index);
    emit(state.copyWith(
      modifiers: List.from(modifiers),
      status: _computeStatus(modifiers),
    ));
  }

  void changeCharacterLimit(int index, String limit) {
    final modifiers = state.modifiers;

    final limitInput = TextModifierCharacterLimit.dirty(limit);

    modifiers[index] =
        (modifiers[index] as TextModifier).copyWith(characterLimit: limitInput);

    emit(state.copyWith(
      modifiers: List.from(modifiers),
      status: _computeStatus(modifiers),
    ));
  }

  void textModifierPriceChanged(int index, String price) {
    final modifiers = state.modifiers;

    final priceInput = ProductPrice.dirty(price);

    modifiers[index] =
        (modifiers[index] as TextModifier).copyWith(price: priceInput);

    emit(state.copyWith(
      modifiers: List.from(modifiers),
      status: _computeStatus(modifiers),
    ));
  }

  void textModifierFillTextChanged(int index, String fillText) {
    final modifiers = state.modifiers;

    final fillInput = TextModifierFillText.dirty(fillText);

    modifiers[index] =
        (modifiers[index] as TextModifier).copyWith(fillText: fillInput);

    emit(state.copyWith(
      modifiers: List.from(modifiers),
      status: _computeStatus(modifiers),
    ));
  }

  void titleChanged(int index, String title) {
    final modifiers = state.modifiers;

    final titleInput = ModifierTitle.dirty(title);

    modifiers[index] = modifiers[index].copyWith(title: titleInput);

    emit(state.copyWith(
      modifiers: List.from(modifiers),
      status: _computeStatus(modifiers),
    ));
  }

  bool requiredChanged(int index) {
    final modifiers = state.modifiers;

    modifiers[index] =
        modifiers[index].copyWith(required: !modifiers[index].required);

    emit(state.copyWith(
      modifiers: List.from(modifiers),
      status: _computeStatus(modifiers),
    ));

    return modifiers[index].required;
  }

  void addChoice(int index) {
    var modifiers = state.modifiers;
    MultiChoiceModifier choiceMod = modifiers[index] as MultiChoiceModifier;
    var newChoice = const Choice();
    var choices = List<Choice>.from(choiceMod.choices ?? [])..add(newChoice);

    modifiers[index] = choiceMod.copyWith(choices: choices);

    emit(state.copyWith(
      modifiers: List.from(modifiers),
      status: _computeStatus(modifiers),
    ));
  }

  void removeChoice(int modIndex, int choiceIndex) {
    var modifiers = state.modifiers;

    modifiers[modIndex] = (modifiers[modIndex] as MultiChoiceModifier)
      ..choices!.removeAt(choiceIndex);

    emit(state.copyWith(
      modifiers: List.from(modifiers),
      status: _computeStatus(modifiers),
    ));
  }

  void changeChoiceTitle(int modIndex, int choiceIndex, String value) {
    var modifiers = state.modifiers;

    final titleInput = ModifierTitle.dirty(value);
    modifiers[modIndex] = (modifiers[modIndex] as MultiChoiceModifier)
      ..choices![choiceIndex].copyWith(title: titleInput);

    emit(state.copyWith(
      modifiers: List.from(modifiers),
      status: _computeStatus(modifiers),
    ));
  }

  void changeChoicePrice(int modIndex, int choiceIndex, String value) {
    var modifiers = state.modifiers;

    final priceInput = ProductPrice.dirty(value);
    modifiers[modIndex] = (modifiers[modIndex] as MultiChoiceModifier)
      ..choices![choiceIndex].copyWith(price: priceInput);

    emit(state.copyWith(
      modifiers: List.from(modifiers),
      status: _computeStatus(modifiers),
    ));
  }

  void changeDefaultChoice(int modIndex, int choiceIndex) {
    var modifiers = state.modifiers;

    var prevChoice = (modifiers[modIndex] as MultiChoiceModifier).defaultChoice;

    modifiers[modIndex] = (modifiers[modIndex] as MultiChoiceModifier).copyWith(
        defaultChoice: (prevChoice == choiceIndex) ? null : choiceIndex);

    emit(state.copyWith(
      modifiers: List.from(modifiers),
      status: _computeStatus(modifiers),
    ));
  }

  FormzStatus _computeStatus(List<Modifier> modifiers) {
    if (modifiers.isEmpty) return FormzStatus.valid;

    for (var mod in modifiers) {
      if (mod is TextModifier) {
        if (!(mod.characterLimit.valid &&
            mod.price.valid &&
            mod.fillText.valid &&
            mod.title.valid)) {
          return FormzStatus.invalid;
        }
      } else if (mod is MultiChoiceModifier) {
        if (!mod.title.valid ||
            mod.choices?.every((choice) =>
                    choice.title.valid &&
                    (choice.price.valid || choice.price.value == "")) ==
                false) {
          return FormzStatus.invalid;
        }
      }
    }

    return FormzStatus.valid;
  }
}
