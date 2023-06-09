import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/models/modifier.dart';

import '../cubit/create_product_cubit.dart';
import '../cubit/modifier_cubit.dart';

class ModifiersView extends StatelessWidget {
  const ModifiersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Column(children: [
        _BuildModifierView(),
      ]),
    );
  }
}

class _AddModifierView extends StatelessWidget {
  const _AddModifierView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modifierCubit = context.read<CreateProductCubit>().modifierCubit;

    return BlocProvider.value(
      value: modifierCubit,
      child: BlocBuilder<ModifierCubit, ModifierState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (state.modifiers.length < 10)
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      tooltip: 'Add Input',
                      onPressed: () => modifierCubit.addTextModifier(),
                    ),
                    const Text('Input'),
                  ],
                ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Add Multichoice',
                    onPressed: () => modifierCubit.addMultiChoiceModifier(),
                  ),
                  const Text('Multichoice'),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BuildModifierView extends StatelessWidget {
  const _BuildModifierView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modifierCubit = context.read<CreateProductCubit>().modifierCubit;

    return BlocProvider.value(
      value: modifierCubit,
      child: BlocBuilder<ModifierCubit, ModifierState>(
        builder: (context, state) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: (state.modifiers.length + 1),
            itemBuilder: (context, index) {
              if (index < state.modifiers.length) {
                final mod = state.modifiers[index];
                if (mod is TextModifier) {
                  return _TextModifierView(modIndex: index);
                } else if (mod is MultiChoiceModifier) {
                  return _MultichoiceModifierView(modIndex: index);
                }
              } else {
                return const _AddModifierView();
              }
              return null;
            },
          );
        },
      ),
    );
  }
}

class _TextModifierView extends StatelessWidget {
  const _TextModifierView({
    Key? key,
    required this.modIndex,
  }) : super(key: key);

  final int modIndex;

  @override
  Widget build(BuildContext context) {
    final modifierCubit = context.read<CreateProductCubit>().modifierCubit;
    return BlocProvider.value(
      value: modifierCubit,
      child: BlocBuilder<ModifierCubit, ModifierState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => modifierCubit.removeModifier(modIndex),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                _ModifierTextField(
                  label: "Title",
                  required: true,
                  onChanged: (p0) => modifierCubit.titleChanged(modIndex, p0),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    _ModifierTextField(
                      onChanged: (p0) =>
                          modifierCubit.textModifierPriceChanged(modIndex, p0),
                      label: "Price",
                      enabled: !state.modifiers[modIndex].required,
                    ),
                    Column(
                      children: [
                        const Text("Required"),
                        Checkbox(
                          value: state.modifiers[modIndex].required,
                          onChanged: (value) =>
                              modifierCubit.requiredChanged(modIndex),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    _ModifierTextField(
                      onChanged: (value) => modifierCubit
                          .textModifierFillTextChanged(modIndex, value),
                      label: "Filler Text",
                    ),
                    _ModifierTextField(
                      onChanged: (value) =>
                          modifierCubit.changeCharacterLimit(modIndex, value),
                      label: "Character Limit",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MultichoiceModifierView extends StatelessWidget {
  const _MultichoiceModifierView({
    Key? key,
    required this.modIndex,
  }) : super(key: key);

  final int modIndex;

  @override
  Widget build(BuildContext context) {
    final modifierCubit = context.read<CreateProductCubit>().modifierCubit;

    return BlocProvider.value(
      value: modifierCubit,
      child: BlocBuilder<ModifierCubit, ModifierState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => modifierCubit.removeModifier(modIndex),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                _ModifierTextField(
                  label: "Title",
                  required: true,
                  onChanged: (p0) => modifierCubit.titleChanged(modIndex, p0),
                ),
                const SizedBox(
                  height: 8,
                ),
                ListView.builder(
                    itemCount:
                        (((state.modifiers[modIndex] as MultiChoiceModifier)
                                    .choices
                                    ?.length ??
                                0) +
                            1),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, choiceIndex) {
                      if (choiceIndex !=
                          (state.modifiers[modIndex] as MultiChoiceModifier)
                              .choices
                              ?.length) {
                        return Row(
                          children: [
                            IconButton(
                              onPressed: () => modifierCubit
                                  .changeDefaultChoice(modIndex, choiceIndex),
                              icon: ((state.modifiers[modIndex]
                                              as MultiChoiceModifier)
                                          .defaultChoice ==
                                      choiceIndex)
                                  ? const Icon(Icons.star)
                                  : const Icon(Icons.star_border_outlined),
                            ),
                            _ModifierTextField(
                              onChanged: (value) =>
                                  modifierCubit.changeChoiceTitle(
                                      modIndex, choiceIndex, value),
                              label: "Name",
                              required: true,
                            ),
                            _ModifierTextField(
                              onChanged: (value) =>
                                  modifierCubit.changeChoicePrice(
                                      modIndex, choiceIndex, value),
                              label: "Cost",
                              defaultValue: "0",
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add),
                              tooltip: 'Add Choice',
                              onPressed: () =>
                                  modifierCubit.addChoice(modIndex),
                            ),
                            const Text('Add Choice'),
                          ],
                        );
                      }
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ModifierTextField extends StatelessWidget {
  final Function(String) onChanged;
  final String? label;
  final String defaultValue;
  final bool required;
  final bool enabled;

  const _ModifierTextField({
    Key? key,
    required this.onChanged,
    this.label,
    this.defaultValue = "",
    this.required = false,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        enabled: enabled,
        style: TextStyle(color: Colors.black), // Setting text color
        decoration: InputDecoration(
          labelText: label,
          hintText: defaultValue,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: Colors.white, // Setting fill color
          hintStyle: TextStyle(color: Colors.grey), // Setting hint text color
          labelStyle:
              TextStyle(color: Colors.black), // Setting label text color
        ),
        onChanged: enabled ? onChanged : null,
      ),
    );
  }
}
