part of 'edit_account_details_bloc.dart';

abstract class EditAccountDetailsState extends Equatable {
  const EditAccountDetailsState();

  @override
  List<Object> get props => [];
}

class EditAccountDetailsInitial extends EditAccountDetailsState {}

class EditAccountDetailsLoading extends EditAccountDetailsState {}

class EditAccountDetailsSuccess extends EditAccountDetailsState {
  final String message;

  const EditAccountDetailsSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class EditAccountDetailsFailure extends EditAccountDetailsState {
  final String error;

  const EditAccountDetailsFailure(this.error);

  @override
  List<Object> get props => [error];
}
