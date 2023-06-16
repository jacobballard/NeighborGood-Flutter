import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:repositories/models/modifier.dart';

import '../model/validation.dart';

part 'modifier_state.dart';

class ModifierCubit extends Cubit<ModifierState> {
  ModifierCubit() : super(ModifierState());

  void addTextModifier() {
    var modifiers = List<Modifier>.from(state.modifiers)
      ..add(const TextModifier());

    emit(state.copyWith(
      modifiers: modifiers,
      status: _computeStatus(modifiers),
    ));
  }

  void addMultiChoiceModifier() {
    var modifiers = List<Modifier>.from(state.modifiers)
      ..add(const MultiChoiceModifier());

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

    final titleInput = ModifierChoiceTitle.dirty(value);

    var modifiedModifier = modifiers[modIndex] as MultiChoiceModifier;
    var modifiedChoice =
        modifiedModifier.choices![choiceIndex].copyWith(title: titleInput);

    modifiedModifier.choices![choiceIndex] = modifiedChoice;

    modifiers[modIndex] = modifiedModifier;

    emit(state.copyWith(
      modifiers: List.from(modifiers),
      status: _computeStatus(modifiers),
    ));
  }

  void changeChoicePrice(int modIndex, int choiceIndex, String value) {
    var modifiers = state.modifiers;

    final priceInput = ProductPrice.dirty(value);

    var modifiedModifier = modifiers[modIndex] as MultiChoiceModifier;
    var modifiedChoice =
        modifiedModifier.choices![choiceIndex].copyWith(price: priceInput);

    modifiedModifier.choices![choiceIndex] = modifiedChoice;

    modifiers[modIndex] = modifiedModifier;

    emit(state.copyWith(
      modifiers: List.from(modifiers),
      status: _computeStatus(modifiers),
    ));
  }

  void changeDefaultChoice(int modIndex, int choiceIndex) {
    // var modifiers = state.modifiers;

    // var prevChoice = (modifiers[modIndex] as MultiChoiceModifier).defaultChoice;

    // modifiers[modIndex] = (modifiers[modIndex] as MultiChoiceModifier).copyWith(
    //     defaultChoice: (prevChoice == choiceIndex) ? null : choiceIndex);

    // emit(state.copyWith(
    //   modifiers: List.from(modifiers),
    //   status: _computeStatus(modifiers),
    // ));
    List<Modifier> modifiers =
        List.from(state.modifiers); // Create a copy of modifiers list

    MultiChoiceModifier currentModifier =
        modifiers[modIndex] as MultiChoiceModifier;

    // Toggle defaultChoice between choiceIndex and null
    if (currentModifier.defaultChoice == choiceIndex) {
      currentModifier = currentModifier.copyWith(defaultChoice: -1);
    } else {
      currentModifier = currentModifier.copyWith(defaultChoice: choiceIndex);
    }
    modifiers[modIndex] = currentModifier;
    emit(state.copyWith(
      modifiers: modifiers,
      status: _computeStatus(modifiers),
    ));
  }

  FormzStatus _computeStatus(List<Modifier> modifiers) {
    if (modifiers.isEmpty) return FormzStatus.valid;

    print("modifiers");
    print(modifiers);

    for (var mod in modifiers) {
      if (mod is TextModifier) {
        if (mod.required) {
          if (!((mod.characterLimit.valid || mod.characterLimit.value == "") &&
              (mod.price.value == "") &&
              (mod.fillText.valid || mod.fillText.value == "") &&
              mod.title.valid)) {
            return FormzStatus.invalid;
          }
        } else {
          if (!((mod.characterLimit.valid || mod.characterLimit.value == "") &&
              (mod.price.valid || mod.price.value == "") &&
              (mod.fillText.valid || mod.fillText.value == "") &&
              mod.title.valid)) {
            print("invalid mod text");
            return FormzStatus.invalid;
          }
        }
      } else if (mod is MultiChoiceModifier) {
        print("multi choice");
        print(mod.choices);

        if ((mod.choices?.length ?? 0) < 2) {
          return FormzStatus.invalid;
        }
        // bool areAllChoicesPriced = (mod.choices?.every((choice) =>
        //             choice.price.valid && choice.price.value != "") ??
        //         false) ==
        //     true;

        // print("all choice $areAllChoicesPriced");

        // print("mod.title.valid ${mod.title.valid}");
        // if (!(mod.title.valid && mod.title.value.isNotEmpty) ||
        //     mod.choices?.any((choice) =>
        //             (choice.title.valid && choice.title.value != "") &&
        //             (choice.price.valid || choice.price.value == "")) ==
        //         false ||
        //     areAllChoicesPriced) {
        //   print("invalid mod choice");
        //   return FormzStatus.invalid;
        // }
        // Check if every choice has a valid and non-empty title
        bool areAllChoicesTitled = mod.choices?.every((choice) =>
                choice.title.valid && choice.title.value.isNotEmpty) ??
            false;

        // Check if every choice has a valid and non-empty price
        bool areAllChoicesPriced = mod.choices?.every((choice) =>
                choice.price.valid && choice.price.value.isNotEmpty) ??
            false;

        // Modifier's title must also be valid and non-empty
        bool isModifierTitleValid =
            mod.title.valid && mod.title.value.isNotEmpty;

        // Check all the conditions to decide if the form is valid
        if (!isModifierTitleValid ||
            !areAllChoicesTitled ||
            areAllChoicesPriced) {
          print("invalid mod choice");
          return FormzStatus.invalid;
        }
      }
    }

    print("finally here>>?");

    return FormzStatus.valid;
  }
}
