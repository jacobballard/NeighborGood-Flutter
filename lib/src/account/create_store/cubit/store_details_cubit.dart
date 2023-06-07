import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'store_details_state.dart';

class StoreDetailsCubit extends Cubit<StoreDetailsState> {
  StoreDetailsCubit() : super(const StoreDetailsState());

  void titleChanged(String value) {
    final title = StoreTitle.dirty(value);
    emit(state.copyWith(
      title: title,
      status: Formz.validate([
        title,
        state.description,
      ]),
    ));
  }

  void descriptionChanged(String value) {
    final description = StoreDescription.dirty(value);
    emit(state.copyWith(
      description: description,
      status: Formz.validate([
        state.title,
        description,
      ]),
    ));
  }

  void instagramChanged(String value) {
    emit(state.copyWith(
      instagram: value,
      status: Formz.validate([
        state.title,
        state.description,
      ]),
    ));
  }

  void tiktokChanged(String value) {
    emit(state.copyWith(
      tiktok: value,
      status: Formz.validate([
        state.title,
        state.description,
      ]),
    ));
  }

  void facebookChanged(String value) {
    emit(state.copyWith(
      facebook: value,
      status: Formz.validate([
        state.title,
        state.description,
      ]),
    ));
  }
}
