part of 'profile_bloc.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileBuyer extends ProfileState {
  const ProfileBuyer(this.user);

  final User user;
}

class ProfileSeller extends ProfileState {
  const ProfileSeller(this.user);

  final User user;
}

class ProfileGuest extends ProfileState {
  const ProfileGuest(this.user);

  final User user;
}
