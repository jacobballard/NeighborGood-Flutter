import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/app/app.dart';
import 'package:repositories/repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required this.authenticationRepository,
    required this.appBloc,
  }) : super(const ProfileNone(User.empty)) {
    on<ProfileUserChanged>(_onUserChanged);
    print("instantiating profile bloc");
    _appBlocSubscription = appBloc.stream.listen((state) {
      print("listening");
      print(state.status);
      if (state.status == AppStatus.authenticated &&
          _authSubscription == null) {
        _authSubscription = authenticationRepository.user.listen((user) {
          _userSubscription?.cancel();
          // _profileRepository?.dispose();  // Dispose of old repository
          // Create new ProfileRepository with updated user ID
          _profileRepository = ProfileRepository(
            userId: user.id,
            authenticationRepository: authenticationRepository,
          );
          // Start listening to the user stream of new ProfileRepository
          _userSubscription = _profileRepository!.user.listen(
            (user) => add(ProfileUserChanged(user)),
          );
        });
      } else if (state.status != AppStatus.authenticated) {
        _authSubscription?.cancel();
        _authSubscription = null;
        _userSubscription?.cancel();
        _userSubscription = null;
        // _profileRepository?.dispose();
        _profileRepository = null;
      }
    });
  }

  final AuthenticationRepository authenticationRepository;
  final AppBloc appBloc;
  ProfileRepository? _profileRepository;
  StreamSubscription<User>? _userSubscription;
  StreamSubscription<AppState>? _appBlocSubscription;
  StreamSubscription<User>? _authSubscription;

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
    _appBlocSubscription?.cancel();
    _authSubscription?.cancel();
    // _profileRepository?.();
    return super.close();
  }
}
