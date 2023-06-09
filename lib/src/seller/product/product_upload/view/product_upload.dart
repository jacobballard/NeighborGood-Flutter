// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:formz/formz.dart';
// import 'package:pastry/src/seller/product/product_upload/bloc/modifier_cubit.dart';
// import 'package:pastry/src/seller/product/product_upload/bloc/product_upload_cubit.dart';

// import '../bloc/picker_option_cubit.dart';
// import '../bloc/picker_option_state.dart';

// class ProductUploadScreen extends StatelessWidget {
//   const ProductUploadScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProductUploadCubit(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Product Upload')),
//         body: Padding(
//           padding: const EdgeInsets.all(16),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _ProductNameInput(),
//                 const SizedBox(height: 8),
//                 _DescriptionInput(),
//                 const SizedBox(height: 8),
//                 _BasePriceInput(),
//                 // Add other input widgets here
//                 const SizedBox(height: 8),
//                 BlocBuilder<ProductUploadCubit, ProductUploadState>(
//                   builder: (context, state) {
//                     return Column(
//                       children:
//                           state.modifierCubits.asMap().entries.map((entry) {
//                         final index = entry.key;
//                         final cubit = entry.value;
//                         return BlocProvider.value(
//                           value: cubit,
//                           child: _ProductModifierInput(index: index),
//                         );
//                       }).toList(),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: () =>
//                       context.read<ProductUploadCubit>().addModifier(),
//                   child: const Text('Add Modifier'),
//                 ),
//                 const SizedBox(height: 8),
//                 _UploadButton(),
//                 //TODOBuy and add to cart buttons
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ProductNameInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductUploadCubit, ProductUploadState>(
//       builder: (context, state) {
//         return TextField(
//           onChanged: (productName) => context
//               .read<ProductUploadCubit>()
//               .productNameChanged(productName),
//           decoration: InputDecoration(
//             labelText: 'Product Name',
//             errorText:
//                 state.productName.invalid ? 'Invalid product name' : null,
//           ),
//         );
//       },
//     );
//   }
// }

// class _DescriptionInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductUploadCubit, ProductUploadState>(
//       builder: (context, state) {
//         return TextField(
//           onChanged: (description) => context
//               .read<ProductUploadCubit>()
//               .descriptionChanged(description),
//           decoration: InputDecoration(
//             labelText: 'Description',
//             errorText: state.description.invalid ? 'Invalid description' : null,
//           ),
//         );
//       },
//     );
//   }
// }

// class _BasePriceInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductUploadCubit, ProductUploadState>(
//       builder: (context, state) {
//         return TextField(
//           onChanged: (basePrice) => context
//               .read<ProductUploadCubit>()
//               .basePriceChanged(double.tryParse(basePrice) ?? 0.0),
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//             labelText: 'Base Price',
//             errorText: state.basePrice.invalid ? 'Invalid base price' : null,
//           ),
//         );
//       },
//     );
//   }
// }

// class _UploadButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductUploadCubit, ProductUploadState>(
//       builder: (context, state) {
//         return ElevatedButton(
//           onPressed: state.status.isValidated
//               ? () => context.read<ProductUploadCubit>().uploadProduct()
//               : null,
//           child: const Text('Upload Product'),
//         );
//       },
//     );
//   }
// }

// class _ProductModifierInput extends StatelessWidget {
//   final int index;

//   const _ProductModifierInput({required this.index});

//   @override
//   Widget build(BuildContext context) {
//     var productUploadModifierCubit =
//         context.read<ProductUploadCubit>().state.modifierCubits[index];

//     return BlocProvider.value(
//       value: productUploadModifierCubit,
//       child:
//           BlocBuilder<ProductUploadModifierCubit, ProductUploadModifierState>(
//         builder: (context, state) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               DropdownButtonFormField<String>(
//                 value: state.modifierType.value,
//                 items: <String>['text input', 'choice'].map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (value) => context
//                     .read<ProductUploadModifierCubit>()
//                     .modifierTypeChanged(value),
//                 decoration: InputDecoration(
//                   labelText: 'Modifier Type',
//                   errorText: state.modifierType.invalid
//                       ? 'Invalid modifier type'
//                       : null,
//                 ),
//               ),
//               if (state.modifierType.value == 'choice') ...[
//                 for (var i = 0; i < state.pickerOptionCubits.length; i++)
//                   _PickerOptionInput(
//                     modifierIndex: index,
//                     optionIndex: i,
//                   ),
//                 ElevatedButton(
//                   onPressed: () => context
//                       .read<ProductUploadModifierCubit>()
//                       .addPickerOption(),
//                   child: const Text('Add Option'),
//                 ),
//               ] else
//                 TextField(
//                   onChanged: (value) => context
//                       .read<ProductUploadModifierCubit>()
//                       .characterLimitChanged(int.tryParse(value) ?? 0),
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: 'Character Limit',
//                     errorText: state.characterLimit.invalid
//                         ? 'Invalid character limit'
//                         : null,
//                   ),
//                 ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () =>
//                     context.read<ProductUploadCubit>().removeModifier(index),
//                 child: const Text('Remove Modifier'),
//               ),
//               const SizedBox(height: 16),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class _PickerOptionInput extends StatelessWidget {
//   final int modifierIndex;
//   final int optionIndex;

//   const _PickerOptionInput(
//       {required this.modifierIndex, required this.optionIndex});

//   @override
//   Widget build(BuildContext context) {
//     var pickerOptionCubit = context
//         .read<ProductUploadCubit>()
//         .state
//         .modifierCubits[modifierIndex]
//         .state
//         .pickerOptionCubits[optionIndex];

//     return BlocProvider.value(
//       value: pickerOptionCubit,
//       child: BlocBuilder<PickerOptionCubit, PickerOptionState>(
//         builder: (context, state) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 onChanged: (value) =>
//                     context.read<PickerOptionCubit>().optionNameChanged(value),
//                 decoration: InputDecoration(
//                   labelText: 'Option Name',
//                   errorText:
//                       state.optionName.invalid ? 'Invalid option name' : null,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 onChanged: (value) => context
//                     .read<PickerOptionCubit>()
//                     .optionPriceChanged(double.tryParse(value) ?? 0.0),
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Option Price',
//                   errorText:
//                       state.optionPrice.invalid ? 'Invalid option price' : null,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () => context
//                     .read<ProductUploadModifierCubit>()
//                     .removePickerOption(optionIndex),
//                 child: const Text('Remove Option'),
//               ),
//               const SizedBox(height: 16),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
