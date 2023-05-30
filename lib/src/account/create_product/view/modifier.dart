import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_rapid/create_product/modifier_cubit.dart';

import 'create_product_cubit.dart';

class ModifiersView extends StatelessWidget {
  const ModifiersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(children: const [
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
              print("index $index");

              if (index < state.modifiers.length) {
                final mod = state.modifiers[index];
                if (mod is TextModifier) {
                  print(
                      'is text modifier -=12-=1-=2=-12-2=1-=12-12-=21=--=1-12-12-=21=-21=-=12-=12=-1=2-=');
                  return _TextModifierView(modIndex: index);
                } else if (mod is MultiChoiceModifier) {
                  return _MultichoiceModifierView(modIndex: index);
                }
              } else {
                return const _AddModifierView();
              }
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
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.white,
            ),
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
  _MultichoiceModifierView({
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
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.white,
            ),
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
                        final choice =
                            (state.modifiers[modIndex] as MultiChoiceModifier)
                                .choices?[choiceIndex];
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
        decoration: InputDecoration(
          label: _labelWidget(context),
          hintText: defaultValue,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey.shade200,
        ),
        onChanged: enabled ? onChanged : null,
      ),
    );
  }

  Widget _labelWidget(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          if (required)
            const TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}
