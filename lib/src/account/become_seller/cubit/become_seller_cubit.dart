import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:repositories/repositories.dart';
part 'become_seller_state.dart';

class BecomeSellerCubit extends Cubit<BecomeSellerState> {
  BecomeSellerCubit(this._profileRepository) : super(const BecomeSellerState());

  final ProfileRepository _profileRepository;
  void storeTitleChanged(String value) {
    final storeTitle = StoreTitle.dirty(value);
    emit(state.copyWith(storeTitle: storeTitle));
  }

  void storeDescriptionChanged(String value) {
    final storeDescription = StoreDescription.dirty(value);
    emit(state.copyWith(storeDescription: storeDescription));
  }

  void storeInstaChanged(String value) {
    final storeInsta = StoreInsta.dirty(value);
    emit(state.copyWith(storeInsta: storeInsta));
  }

  void storePinChanged(String value) {
    final storePin = StorePin.dirty(value);
    emit(state.copyWith(storePin: storePin));
  }

  void storeMetaChanged(String value) {
    final storeMeta = StoreMeta.dirty(value);
    emit(state.copyWith(storeMeta: storeMeta));
  }

  void storeTikChanged(String value) {
    final storeTik = StoreTik.dirty(value);
    emit(state.copyWith(storeTik: storeTik));
  }

  Future<void> createStore(String id) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      _profileRepository.createStore(
          id: id,
          title: state.storeTitle.value,
          description: state.storeDescription.value,
          insta: state.storeInsta.value,
          tik: state.storeTik.value,
          meta: state.storeMeta.value,
          pin: state.storePin.value);

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }
}
