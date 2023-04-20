import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(const ProfileGuest(User.empty)) {
    on<ProfileUserChanged>(_onUserChanged);
    _userSubscription = _profileRepository.user.listen(
      (user) => add(ProfileUserChanged(user)),
    );
  }

  final ProfileRepository _profileRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(ProfileUserChanged event, Emitter<ProfileState> emit) {
    switch (event.user.accountType) {
      case AccountType.buyer:
        emit(ProfileBuyer(event.user));
        break;
      case AccountType.seller:
        emit(ProfileSeller(event.user));
        break;
      default:
        emit(ProfileGuest(event.user));
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
