import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/models/delivery_method.dart' as enum_to;
import 'package:repositories/models/delivery_method.dart';
import 'delivery_method_cubit.dart';

class DeliveryMethodsView extends StatelessWidget {
  const DeliveryMethodsView(
      {super.key, required this.deliveryMethodsCubit, this.required = true});

  final DeliveryMethodsCubit deliveryMethodsCubit;

  final bool required;
  Widget _buildMethodItem(
      BuildContext context, DeliveryMethod method, int index) {
    switch (method.type) {
      case DeliveryMethodType.local_pickup:
        return LocalPickupMethodItem(
          method: method,
          index: index,
        );
      case DeliveryMethodType.delivery:
        return DeliveryMethodItem(
          method: method,
          index: index,
        );
      case DeliveryMethodType.shipping:
        return ShippingMethodItem(
          method: method,
          index: index,
        );

      default:
        return (context
                .read<DeliveryMethodsCubit>()
                .getRemainingMethods()
                .isNotEmpty)
            ? NoPickupMethodItem(
                index: index,
              )
            : const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: deliveryMethodsCubit,
      child: BlocBuilder<DeliveryMethodsCubit, DeliveryMethodsState>(
        builder: (context, state) {
          return Material(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Delivery Methods",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    if (!required)
                      const Text(
                          '(overrides your store\' global delivery methods)'),
                    if (state.methods.length < 3)
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () =>
                            context.read<DeliveryMethodsCubit>().addMethod(),
                      ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.methods.length,
                  itemBuilder: (context, index) {
                    final method = state.methods[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0), // or any other value you want
                      child: _buildMethodItem(context, method, index),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NoPickupMethodItem extends StatelessWidget {
  final int index;

  const NoPickupMethodItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryMethodsCubit, DeliveryMethodsState>(
      builder: (context, state) {
        final remainingMethods =
            context.read<DeliveryMethodsCubit>().getRemainingMethods();
        return AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: DropdownButton<DeliveryMethodType>(
            hint: const Text('Select delivery method'),
            items: remainingMethods.map((methodType) {
              return DropdownMenuItem<DeliveryMethodType>(
                value: methodType,
                child: Text(enum_to.enumToString(methodType)),
              );
            }).toList(),
            onChanged: (newMethodType) {
              context
                  .read<DeliveryMethodsCubit>()
                  .changeMethodType(index, newMethodType!);
            },
          ),
        );
      },
    );
  }
}

class LocalPickupMethodItem extends StatelessWidget {
  final DeliveryMethod method;
  final int index;

  const LocalPickupMethodItem({
    super.key,
    required this.method,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryMethodsCubit, DeliveryMethodsState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Wrap(
            spacing: 8,
            direction: Axis.horizontal,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () =>
                    context.read<DeliveryMethodsCubit>().removeMethod(index),
              ),
              const Text(
                "Local Pickup",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text("Keep address hidden"),
              Checkbox(
                value: method.showAddress,
                onChanged: (newValue) {
                  context.read<DeliveryMethodsCubit>().changeShowAddress(index);
                },
              ),
              DeliveryMethodTextField(
                onChanged: (p0) =>
                    context.read<DeliveryMethodsCubit>().changeEta(index, p0),
                label: "ETA (days)",
                defaultValue: "1",
              ),
            ],
          ),
        );
      },
    );
  }
}

class DeliveryMethodItem extends StatelessWidget {
  final DeliveryMethod method;
  final int index;

  const DeliveryMethodItem({
    super.key,
    required this.method,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryMethodsCubit, DeliveryMethodsState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Wrap(
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () =>
                    context.read<DeliveryMethodsCubit>().removeMethod(index),
              ),
              const Text(
                "Delivery",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 8,
              ),
              DeliveryMethodTextField(
                onChanged: (newValue) => context
                    .read<DeliveryMethodsCubit>()
                    .changeRange(index, newValue),
                label: 'Range (miles)',
                defaultValue: "10",
              ),
              const SizedBox(
                width: 8,
              ),
              DeliveryMethodTextField(
                onChanged: (p0) =>
                    context.read<DeliveryMethodsCubit>().changeEta(index, p0),
                label: "ETA (days)",
                defaultValue: "3",
              ),
              const SizedBox(
                width: 8,
              ),
              DeliveryMethodTextField(
                onChanged: (newValue) => context
                    .read<DeliveryMethodsCubit>()
                    .changeFee(index, newValue),
                label: 'Fee (\$)',
                defaultValue: "0",
              ),
            ],
          ),
        );
      },
    );
  }
}

class ShippingMethodItem extends StatelessWidget {
  final DeliveryMethod method;
  final int index;

  const ShippingMethodItem({
    super.key,
    required this.method,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryMethodsCubit, DeliveryMethodsState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Wrap(
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () =>
                    context.read<DeliveryMethodsCubit>().removeMethod(index),
              ),
              const Text(
                "Shipping",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 8,
              ),
              DeliveryMethodTextField(
                onChanged: (newValue) => context
                    .read<DeliveryMethodsCubit>()
                    .changeFee(index, newValue),
                label: 'Fee (\$)',
                defaultValue: "6",
              ),
              const SizedBox(width: 20),
              DeliveryMethodTextField(
                onChanged: (newValue) => context
                    .read<DeliveryMethodsCubit>()
                    .changeEta(index, newValue),
                label: 'ETA (days)',
                defaultValue: "7",
              ),
            ],
          ),
        );
      },
    );
  }
}

class DeliveryMethodTextField extends StatelessWidget {
  final Function(String) onChanged;
  final String label;
  final String defaultValue;

  const DeliveryMethodTextField({
    super.key,
    required this.onChanged,
    required this.label,
    this.defaultValue = '', // Set to empty string by default
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100, // Taking up all the available width
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: defaultValue,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
