import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'become_seller_state.dart';

class BecomeSellerCubit extends Cubit<BecomeSellerState> {
  BecomeSellerCubit() : super(const BecomeSellerState());

  void storeTitleChanged(String value) {
    final storeTitle = StoreTitle.dirty(value);
    emit(state.copyWith(storeTitle: storeTitle));
  }

  void storeDescriptionChanged(String value) {
    final storeDescription = StoreDescription.dirty(value);
    emit(state.copyWith(storeDescription: storeDescription));
  }

  Future<void> createStore() async {
    if (state.status.isValidated) {
      // TODO : Call your API or database to create the store with the provided values
      // You can access the form values with state.storeTitle.value and state.storeDescription.value
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } else {
      emit(state.copyWith(status: FormzStatus.invalid));
    }
  }
}
