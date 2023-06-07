import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/app/app.dart';
import 'package:repositories/repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
      {required ProfileRepository profileRepository, required AppBloc appBloc})
      : _profileRepository = profileRepository,
        super(const ProfileNone(User.empty)) {
    on<ProfileUserChanged>(_onUserChanged);
    // _userSubscription = _profileRepository.user.listen(
    //   (user) => add(ProfileUserChanged(user)),
    // );

    _userSubscription = appBloc.state.status == AppStatus.authenticated
        ? _profileRepository.user.listen(
            (user) => add(ProfileUserChanged(user)),
          )
        : const Stream<User>.empty().listen((user) {});
    // _appSubscription = _appBloc.stream.listen((appState) {
    //   if (appState.status == AppStatus.unauthenticated) {
    //     _userSubscription?.cancel();
    //     _userSubscription = Stream<User>.empty().listen((user) {});
    //   } else if (appState.status == AppStatus.authenticated) {
    //     _userSubscription?.cancel();
    //     _userSubscription = _profileRepository.user.listen(
    //       (user) => add(ProfileUserChanged(user)),
    //     );
    //   }
    // });
  }

  final ProfileRepository _profileRepository;
  StreamSubscription<User>? _userSubscription;

  void _onUserChanged(ProfileUserChanged event, Emitter<ProfileState> emit) {
    if (event.user.isEmpty) {
      emit(ProfileNone(event.user));
    } else {
      switch (event.user.accountType) {
        case AccountType.buyer:
          emit(ProfileBuyer(event.user));
          break;
        case AccountType.seller:
          emit(ProfileSeller(event.user));
          break;
        case AccountType.guest:
          emit(ProfileGuest(event.user));
          break;
        default:
          emit(ProfileNone(event.user));
          break;
      }
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    // _appSubscription?.cancel();
    return super.close();
  }
}

var test = {
  'email': 'jacob.platypus.ballard@gmail.com',
  'metadata': {
    'createdAt': '2023-06-06T02:25:57Z',
    'lastSignedInAt': '2023-06-06T02:25:57Z'
  },
  'providerData': [
    {
      'email': 'jacob.platypus.ballard@gmail.com',
      'providerId': 'password',
      'uid': 'jacob.platypus.ballard@gmail.com'
    }
  ],
  'uid': 'ym3BCcs1oidMg8Mw4qCLHVNROmv2'
};
