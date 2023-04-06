import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'edit_account_details_event.dart';
part 'edit_account_details_state.dart';

class EditAccountDetailsBloc
    extends Bloc<EditAccountDetailsEvent, EditAccountDetailsState> {
  final EditAccountDetailsRepository _repository;

  EditAccountDetailsBloc(this._repository) : super(EditAccountDetailsInitial());

  Stream<EditAccountDetailsState> mapEventToState(
    EditAccountDetailsEvent event,
  ) async* {
    if (event is UpdateDisplayName) {
      yield* _mapUpdateDisplayNameToState(event.displayName);
    } else if (event is UpdatePassword) {
      yield* _mapUpdatePasswordToState(
          event.currentPassword, event.newPassword);
    }
  }

  Stream<EditAccountDetailsState> _mapUpdateDisplayNameToState(
      String displayName) async* {
    try {
      yield EditAccountDetailsLoading();
      await _repository.updateDisplayName(displayName);
      yield const EditAccountDetailsSuccess(
          'Display name updated successfully');
    } catch (e) {
      yield EditAccountDetailsFailure(e.toString());
    }
  }

  Stream<EditAccountDetailsState> _mapUpdatePasswordToState(
      String currentPassword, String newPassword) async* {
    try {
      yield EditAccountDetailsLoading();
      await _repository.updatePassword(currentPassword, newPassword);
      yield const EditAccountDetailsSuccess('Password updated successfully');
    } catch (e) {
      yield EditAccountDetailsFailure(e.toString());
    }
  }
}
