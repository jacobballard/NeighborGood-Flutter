part of 'edit_account_details_bloc.dart';

abstract class EditAccountDetailsEvent extends Equatable {
  const EditAccountDetailsEvent();

  @override
  List<Object> get props => [];
}

class UpdateDisplayName extends EditAccountDetailsEvent {
  final String displayName;

  const UpdateDisplayName(this.displayName);

  @override
  List<Object> get props => [displayName];
}

class UpdatePassword extends EditAccountDetailsEvent {
  final String currentPassword;
  final String newPassword;

  const UpdatePassword(this.currentPassword, this.newPassword);

  @override
  List<Object> get props => [currentPassword, newPassword];
}
