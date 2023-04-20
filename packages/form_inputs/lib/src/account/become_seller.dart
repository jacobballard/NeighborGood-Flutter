import 'package:formz/formz.dart';

enum StoreTitleValidationError { empty }

class StoreTitle extends FormzInput<String, StoreTitleValidationError> {
  const StoreTitle.pure() : super.pure('');
  const StoreTitle.dirty([String value = '']) : super.dirty(value);

  @override
  StoreTitleValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : StoreTitleValidationError.empty;
  }
}

enum StoreDescriptionValidationError { empty }

class StoreDescription
    extends FormzInput<String, StoreDescriptionValidationError> {
  const StoreDescription.pure() : super.pure('');
  const StoreDescription.dirty([String value = '']) : super.dirty(value);

  @override
  StoreDescriptionValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : StoreDescriptionValidationError.empty;
  }
}

enum InstaValidationError { invalid }

class StoreInsta extends FormzInput<String, InstaValidationError> {
  const StoreInsta.pure() : super.pure('');
  const StoreInsta.dirty([String value = '']) : super.dirty(value);

  static final RegExp _instaRegExp = RegExp(
      r'^(?:https?://)?(?:www\.)?(?:instagram\.com|instagr\.am)/([A-Za-z0-9-_]+)$');

  @override
  InstaValidationError? validator(String? value) {
    return _instaRegExp.hasMatch(value ?? '')
        ? null
        : InstaValidationError.invalid;
  }
}

enum TikValidationError { invalid }

class StoreTik extends FormzInput<String, TikValidationError> {
  const StoreTik.pure() : super.pure('');
  const StoreTik.dirty([String value = '']) : super.dirty(value);

  static final RegExp _tikRegExp =
      RegExp(r'^(?:https?://)?(?:www\.)?(?:tiktok\.com)/(@[A-Za-z0-9-_]+)$');

  @override
  TikValidationError? validator(String? value) {
    return _tikRegExp.hasMatch(value ?? '') ? null : TikValidationError.invalid;
  }
}

enum MetaValidationError { invalid }

class StoreMeta extends FormzInput<String, MetaValidationError> {
  const StoreMeta.pure() : super.pure('');
  const StoreMeta.dirty([String value = '']) : super.dirty(value);

  static final RegExp _metaRegExp =
      RegExp(r'^(?:https?://)?(?:www\.)?(?:facebook\.com)/([A-Za-z0-9-_]+)$');

  @override
  MetaValidationError? validator(String? value) {
    return _metaRegExp.hasMatch(value ?? '')
        ? null
        : MetaValidationError.invalid;
  }
}

enum PinValidationError { invalid }

class StorePin extends FormzInput<String, PinValidationError> {
  const StorePin.pure() : super.pure('');
  const StorePin.dirty([String value = '']) : super.dirty(value);

  static final RegExp _pinRegExp =
      RegExp(r'^(?:https?://)?(?:www\.)?(?:pinterest\.com)/([A-Za-z0-9-_]+)$');

  @override
  PinValidationError? validator(String? value) {
    return _pinRegExp.hasMatch(value ?? '') ? null : PinValidationError.invalid;
  }
}
