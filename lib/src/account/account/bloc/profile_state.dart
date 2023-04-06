part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, success, error }

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class InitialProfileState extends ProfileState {}

class LoadedProfileState extends ProfileState {
  final ProfileStatus status;
  final Account? account;

  const LoadedProfileState({
    required this.status,
    this.account,
  });

  LoadedProfileState copyWith({
    ValueGetter<ProfileStatus>? status,
    ValueGetter<Account>? account,
  }) {
    return LoadedProfileState(
      status: status?.call() ?? this.status,
      account: account?.call() ?? this.account,
    );
  }

  @override
  List<Object?> get props => [status, account];
}
