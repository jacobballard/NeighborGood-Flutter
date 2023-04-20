part of 'profile_bloc.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}

class ProfileUserChanged extends ProfileEvent {
  const ProfileUserChanged(this.user);

  final User user;
}
