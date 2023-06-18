import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/models/presentation/cart_modifier.dart';
import '../cubit/product_detail_cubit.dart';

class ModifierList extends StatelessWidget {
  final List<CartModifier>? modifiers;

  const ModifierList({Key? key, required this.modifiers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (modifiers == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: modifiers!.length,
        itemBuilder: (context, index) {
          var mod = modifiers![index];
          if (mod is CartTextModifier) {
            return TextModifierView(
              index: index,
              modifierDetails: mod,
            );
          } else if (mod is CartMultiChoiceModifier) {
            return MultiChoiceModifierView(
              modifierDetails: mod as CartMultiChoiceModifier,
              index: index,
            );
          }
          return const SizedBox.shrink(); // return an empty widget if no match
        },
      ),
    );
  }
}

class TextModifierView extends StatelessWidget {
  final int index;
  final CartTextModifier modifierDetails;

  const TextModifierView({
    Key? key,
    required this.modifierDetails,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // Text(
        //   modifierDetails.title,
        //   style: TextStyle(fontWeight: FontWeight.bold),
        // ),

        Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: TextSpan(
              text: modifierDetails.title,
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                if (modifierDetails.required)
                  const TextSpan(
                      text: ' *', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ),

        TextFormField(
          // hin: modifierDetails.fillText,
          onChanged: (value) {
            context
                .read<ViewProductDetailsCubit>()
                .textModifierSelectionChanged(index, value);
          },
          keyboardType: TextInputType.multiline,
          minLines: 1,

          maxLength: modifierDetails.characterLimit.isNotEmpty
              ? int.parse(modifierDetails.characterLimit)
              : null,
          decoration: InputDecoration(
            hintText: modifierDetails.fillText,
            labelText: null,
            // label: RichText(
            //   text: TextSpan(
            //     text: modifierDetails.title,
            //     style: DefaultTextStyle.of(context).style,
            //     children: <TextSpan>[
            //       if (modifierDetails.required)
            //         const TextSpan(
            //             text: ' *', style: TextStyle(color: Colors.red)),
            //     ],
            //   ),
            // ),
            helperText: modifierDetails.price.isNotEmpty
                ? 'Price: ${modifierDetails.price}'
                : null,
          ),
        ),
      ],
    );
  }
}

class MultiChoiceModifierView extends StatefulWidget {
  final CartMultiChoiceModifier modifierDetails;
  final int index;

  const MultiChoiceModifierView({
    Key? key,
    required this.modifierDetails,
    required this.index,
  }) : super(key: key);

  @override
  _MultiChoiceModifierViewState createState() =>
      _MultiChoiceModifierViewState();
}

class _MultiChoiceModifierViewState extends State<MultiChoiceModifierView> {
  String? dropdownValue;
  late bool noPricingForChoices;

  @override
  void initState() {
    super.initState();
    noPricingForChoices =
        widget.modifierDetails.choices!.every((element) => element.price == "");
    print(widget.modifierDetails);
    if (widget.modifierDetails.choices != null &&
        widget.modifierDetails.choices!.isNotEmpty &&
        widget.modifierDetails.defaultChoice >= 0 &&
        widget.modifierDetails.defaultChoice <
            widget.modifierDetails.choices!.length) {
      dropdownValue = widget
          .modifierDetails.choices![widget.modifierDetails.defaultChoice].id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.modifierDetails.title,
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              if (widget.modifierDetails.required)
                const TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        if (widget.modifierDetails.choices != null)
          DropdownButton<String>(
            isExpanded: true,
            value: dropdownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                context
                    .read<ViewProductDetailsCubit>()
                    .multiChoiceModifierSelectionChanged(
                      widget.index,
                      newValue,
                    );
              });
            },
            items: widget.modifierDetails.choices!
                .map<DropdownMenuItem<String>>((CartChoice choice) {
              print("choice ${choice.id}");
              return DropdownMenuItem<String>(
                value: choice.id,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(choice.title),
                    if (choice.price != "") Text("+ \$${choice.price}"),
                    if (choice.price == "" && !noPricingForChoices)
                      const Text("+ \$0"),
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
