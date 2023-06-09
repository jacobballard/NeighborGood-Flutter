// // part of 'product_upload_cubit.dart';

// // class ProductUploadState extends Equatable {
// //   final ProductName productName;
// //   final Description description;
// //   final BasePrice basePrice;
// //   final FormzStatus status;

// //   const ProductUploadState({
// //     this.productName = const ProductName.pure(),
// //     this.description = const Description.pure(),
// //     this.basePrice = const BasePrice.pure(),
// //     this.status = FormzStatus.pure,
// //   });

// //   ProductUploadState copyWith({
// //     ProductName? productName,
// //     Description? description,
// //     BasePrice? basePrice,
// //     FormzStatus? status,
// //   }) {
// //     return ProductUploadState(
// //       productName: productName ?? this.productName,
// //       description: description ?? this.description,
// //       basePrice: basePrice ?? this.basePrice,
// //       status: status ?? this.status,
// //     );
// //   }

// //   @override
// //   List<Object?> get props => [productName, description, basePrice, status];
// // }

// part of 'product_upload_cubit.dart';

// class ProductUploadState extends Equatable {
//   final ProductName productName;
//   final Description description;
//   final BasePrice basePrice;
//   final FormzStatus status;
//   final List<ProductUploadModifierCubit> modifierCubits; // Add this line

//   const ProductUploadState({
//     this.productName = const ProductName.pure(),
//     this.description = const Description.pure(),
//     this.basePrice = const BasePrice.pure(),
//     this.status = FormzStatus.pure,
//     this.modifierCubits = const <ProductUploadModifierCubit>[], // And this line
//   });

//   ProductUploadState copyWith({
//     ProductName? productName,
//     Description? description,
//     BasePrice? basePrice,
//     FormzStatus? status,
//     List<ProductUploadModifierCubit>? modifierCubits, // And this line
//   }) {
//     return ProductUploadState(
//       productName: productName ?? this.productName,
//       description: description ?? this.description,
//       basePrice: basePrice ?? this.basePrice,
//       status: status ?? this.status,
//       modifierCubits: modifierCubits ?? this.modifierCubits, // And this line
//     );
//   }

//   @override
//   List<Object?> get props => [
//         productName,
//         description,
//         basePrice,
//         status,
//         modifierCubits
//       ]; // And this line
// }
