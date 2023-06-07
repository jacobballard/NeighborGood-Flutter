// import 'package:formz/formz.dart';

// enum StoreTitleValidationError { empty }

// class StoreTitle extends FormzInput<String, StoreTitleValidationError> {
//   const StoreTitle.pure() : super.pure('');
//   const StoreTitle.dirty([String value = '']) : super.dirty(value);

//   @override
//   StoreTitleValidationError? validator(String? value) {
//     return value?.isNotEmpty == true ? null : StoreTitleValidationError.empty;
//   }
// }

// enum StoreDescriptionValidationError { empty }

// class StoreDescription
//     extends FormzInput<String, StoreDescriptionValidationError> {
//   const StoreDescription.pure() : super.pure('');
//   const StoreDescription.dirty([String value = '']) : super.dirty(value);

//   @override
//   StoreDescriptionValidationError? validator(String? value) {
//     return value?.isNotEmpty == true
//         ? null
//         : StoreDescriptionValidationError.empty;
//   }
// }

// enum InstaValidationError { invalid }

// class StoreInsta extends FormzInput<String, InstaValidationError> {
//   const StoreInsta.pure() : super.pure('');
//   const StoreInsta.dirty([String value = '']) : super.dirty(value);

//   static final RegExp _instaRegExp = RegExp(
//       r'^(?:https?://)?(?:www\.)?(?:instagram\.com|instagr\.am)/([A-Za-z0-9-_]+)$');

//   @override
//   InstaValidationError? validator(String? value) {
//     return _instaRegExp.hasMatch(value ?? '')
//         ? null
//         : InstaValidationError.invalid;
//   }
// }

// enum TikValidationError { invalid }

// class StoreTik extends FormzInput<String, TikValidationError> {
//   const StoreTik.pure() : super.pure('');
//   const StoreTik.dirty([String value = '']) : super.dirty(value);

//   static final RegExp _tikRegExp =
//       RegExp(r'^(?:https?://)?(?:www\.)?(?:tiktok\.com)/(@[A-Za-z0-9-_]+)$');

//   @override
//   TikValidationError? validator(String? value) {
//     return _tikRegExp.hasMatch(value ?? '') ? null : TikValidationError.invalid;
//   }
// }

// enum MetaValidationError { invalid }

// class StoreMeta extends FormzInput<String, MetaValidationError> {
//   const StoreMeta.pure() : super.pure('');
//   const StoreMeta.dirty([String value = '']) : super.dirty(value);

//   static final RegExp _metaRegExp =
//       RegExp(r'^(?:https?://)?(?:www\.)?(?:facebook\.com)/([A-Za-z0-9-_]+)$');

//   @override
//   MetaValidationError? validator(String? value) {
//     return _metaRegExp.hasMatch(value ?? '')
//         ? null
//         : MetaValidationError.invalid;
//   }
// }

// enum PinValidationError { invalid }

// class StorePin extends FormzInput<String, PinValidationError> {
//   const StorePin.pure() : super.pure('');
//   const StorePin.dirty([String value = '']) : super.dirty(value);

//   static final RegExp _pinRegExp =
//       RegExp(r'^(?:https?://)?(?:www\.)?(?:pinterest\.com)/([A-Za-z0-9-_]+)$');

//   @override
//   PinValidationError? validator(String? value) {
//     return _pinRegExp.hasMatch(value ?? '') ? null : PinValidationError.invalid;
//   }
// }

// enum DeliveryRangeValidationError { invalid }

// class DeliveryRange extends FormzInput<double, DeliveryRangeValidationError> {
//   const DeliveryRange.pure() : super.pure(0.0);
//   const DeliveryRange.dirty([double value = 0.0]) : super.dirty(value);

//   @override
//   DeliveryRangeValidationError? validator(double? value) {
//     return (value != null && value > 0.0)
//         ? null
//         : DeliveryRangeValidationError.invalid;
//   }
// }

// class DeliveryMethods extends FormzInput<List<String>, String> {
//   const DeliveryMethods.pure([List<String>? value])
//       : super.pure(value ?? const <String>[]);
//   const DeliveryMethods.dirty([List<String>? value])
//       : super.dirty(value ?? const <String>[]);

//   @override
//   String? validator(List<String>? value) {
//     return value != null && value.isNotEmpty
//         ? null
//         : 'Delivery methods must be selected';
//   }
// }

// class StoreLatitude extends FormzInput<double, String> {
//   const StoreLatitude.pure() : super.pure(0.0);
//   const StoreLatitude.dirty([double value = 0.0]) : super.dirty(value);

//   @override
//   String? validator(double? value) {
//     return (value != null && value >= -90.0 && value <= 90.0)
//         ? null
//         : 'Invalid latitude';
//   }
// }

// class StoreLongitude extends FormzInput<double, String> {
//   const StoreLongitude.pure() : super.pure(0.0);
//   const StoreLongitude.dirty([double value = 0.0]) : super.dirty(value);

//   @override
//   String? validator(double? value) {
//     return (value != null && value >= -180.0 && value <= 180.0)
//         ? null
//         : 'Invalid longitude';
//   }
// }

// class DeliveryFee extends FormzInput<String, DeliveryFeeValidationError> {
//   const DeliveryFee.pure() : super.pure('');
//   const DeliveryFee.dirty([String value = '']) : super.dirty(value);

//   static final _deliveryFeeRegExp = RegExp(r'^\d+(\.\d+)?$');

//   @override
//   DeliveryFeeValidationError? validator(String? value) {
//     return _deliveryFeeRegExp.hasMatch(value ?? '')
//         ? null
//         : DeliveryFeeValidationError.invalid;
//   }
// }

// enum DeliveryFeeValidationError { invalid }

// class Eta extends FormzInput<String, EtaValidationError> {
//   const Eta.pure() : super.pure('');
//   const Eta.dirty([String value = '']) : super.dirty(value);

//   static final _etaRegExp = RegExp(r'^\d+$');

//   @override
//   EtaValidationError? validator(String? value) {
//     return _etaRegExp.hasMatch(value ?? '') ? null : EtaValidationError.invalid;
//   }
// }

// enum EtaValidationError { invalid }
