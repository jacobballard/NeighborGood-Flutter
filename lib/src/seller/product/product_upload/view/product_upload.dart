import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pastry/src/seller/product/product_upload/bloc/product_upload_cubit.dart';

class ProductUploadScreen extends StatelessWidget {
  const ProductUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductUploadCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Product Upload')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProductNameInput(),
                const SizedBox(height: 8),
                _DescriptionInput(),
                const SizedBox(height: 8),
                _BasePriceInput(),
                // Add other input widgets here
                const SizedBox(height: 8),
                _UploadButton(),
                //TODOBuy and add to cart buttons
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductUploadCubit, ProductUploadState>(
      builder: (context, state) {
        return TextField(
          onChanged: (productName) => context
              .read<ProductUploadCubit>()
              .productNameChanged(productName),
          decoration: InputDecoration(
            labelText: 'Product Name',
            errorText:
                state.productName.invalid ? 'Invalid product name' : null,
          ),
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductUploadCubit, ProductUploadState>(
      builder: (context, state) {
        return TextField(
          onChanged: (description) => context
              .read<ProductUploadCubit>()
              .descriptionChanged(description),
          decoration: InputDecoration(
            labelText: 'Description',
            errorText: state.description.invalid ? 'Invalid description' : null,
          ),
        );
      },
    );
  }
}

class _BasePriceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductUploadCubit, ProductUploadState>(
      builder: (context, state) {
        return TextField(
          onChanged: (basePrice) => context
              .read<ProductUploadCubit>()
              .basePriceChanged(double.tryParse(basePrice) ?? 0.0),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Base Price',
            errorText: state.basePrice.invalid ? 'Invalid base price' : null,
          ),
        );
      },
    );
  }
}

class _UploadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductUploadCubit, ProductUploadState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.status.isValidated
              ? () => context.read<ProductUploadCubit>().uploadProduct()
              : null,
          child: const Text('Upload Product'),
        );
      },
    );
  }
}

// class _ModifierInput extends StatelessWidget {
//   final int modifierIndex;

//   _ModifierInput({required this.modifierIndex});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<ProductUploadModifierCubit>(
//       create: (context) => ProductUploadModifierCubit(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           DropdownButtonFormField<String>(
//             items: [
//               DropdownMenuItem(
//                 value: 'input',
//                 child: Text('Input'),
//               ),
//               DropdownMenuItem(
//                 value: 'picker',
//                 child: Text('Picker'),
//               ),
//             ],
//             onChanged: (value) => context.read<ProductUploadModifierCubit>().modifierTypeChanged(value),
//             decoration: InputDecoration(
//               labelText: 'Modifier Type',
//             ),
//           ),
//           BlocBuilder<ProductUploadModifierCubit, ProductUploadModifierState>(
//             builder: (context, state) {
//               if (state.modifierType.value == 'input') {
//                 return _TextInput(modifierIndex: modifierIndex);
//               } else if (state.modifierType.value == 'picker') {
//                 return _PickerInput(modifierIndex: modifierIndex);
//               }
//               return Container();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _TextInput extends StatelessWidget {
//   final int modifierIndex;

//   _TextInput({required this.modifierIndex});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextFormField(
//           onChanged: (value) => context.read<ProductUploadModifierCubit>().characterLimitChanged(int.tryParse(value) ?? 0),
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//             labelText: 'Character Limit',
//             helperText: 'Enter the maximum number of characters allowed',
//           ),
//         ),
//         // Add any other input-related UI elements here
//       ],
//     );
//   }
// }

// class _PickerInput extends StatelessWidget {
//   final int modifierIndex;

//   _PickerInput({required this.modifierIndex});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Picker Options'),
//         BlocBuilder<ProductUploadModifierCubit, ProductUploadModifierState>(
//           builder: (context, state) {
//             return ListView.builder(
//               shrinkWrap: true,
//               itemCount: state.pickerOptions.length,
//               itemBuilder: (context, index) {
//                 final pickerOption = state.pickerOptions[index];
//                 return _PickerOptionInput(
//                   modifierIndex: modifierIndex,
//                   optionIndex: index,
//                   initialOption: pickerOption.value,
//                   initialPrice: pickerOption.price,
//                 );
//               },
//             );
//           },
//         ),
//         TextButton(
//           onPressed: () => context.read<ProductUploadModifierCubit>().addPickerOption('', 0),
//           child: Text('Add Picker Option'),
//         ),
//       ],
//     );
//   }
// }

// class _PickerOptionInput extends StatefulWidget {
//   final int modifierIndex;
//   final int optionIndex;
//   final String initialOption;
//   final double initialPrice;

//   _PickerOptionInput({
//     required this.modifierIndex,
//     required this.optionIndex,
//     required this.initialOption,
//     required this.initialPrice,
//   });

//   @override
//   _PickerOptionInputState createState() => _PickerOptionInputState();
// }

// class _PickerOptionInputState extends State<_PickerOptionInput> {
//   late TextEditingController _optionController;
//   late TextEditingController _priceController;

//   @override
//   void initState() {
//     super.initState();
//     _optionController = TextEditingController(text: widget.initialOption);
//     _priceController
