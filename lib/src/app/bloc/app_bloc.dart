import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Cubit<AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        //_cacheClient = CacheClient(),
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    // on<_AppUserChanged>(_onUserChanged);
    // on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen((user) {
      print("app bloc user sub");
      print(user.toMap());
      // add(_AppUserChanged(user));
      _onUserChanged(user);
    });
  }

  final AuthenticationRepository _authenticationRepository;

  Timer? timer;
  // ignore: unused_field
  late final StreamSubscription<User> _userSubscription;
  //_AppUserChanged event, Emitter<AppState> emit
  void _onUserChanged(User user) async {
    print('user changed');
    print(user.toMap());
    if (user.isEmpty) {
      print('empty');
      emit(const AppState.unauthenticated());
    } else if (_authenticationRepository.isAnonymous) {
      print('anonymous');
      emit(AppState.authenticated(
          user.copyWith(accountType: AccountType.guest)));
    } else {
      if (!_authenticationRepository.isUserVerified) {
        emit(const AppState.needsVerification());
        timer = Timer.periodic(
            const Duration(seconds: 3), (_) => checkVerificationStatus(user));
      } else {
        print('should finally be here');
        emit(AppState.authenticated(user));
      }
    }
  }

  Future<void> checkVerificationStatus(User user) async {
    if (_authenticationRepository.isUserVerified) {
      print('yay');
      emit(AppState.authenticated(user));
      timer?.cancel();
    } else {
      _authenticationRepository.isVerificationNeeded();
    }
  }

  //AppLogoutRequested event, Emitter<AppState> emit
  Future<void> onLogoutRequested() async {
    emit(const AppState.loggingOut());
    unawaited(_authenticationRepository.logOut());
  }
}
