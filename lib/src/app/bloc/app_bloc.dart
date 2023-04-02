import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pastry/src/location/model/location_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(_AppUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) async {
    // emit(
    //   event.user.isNotEmpty
    //       ? AppState.authenticated(event.user)
    //       : const AppState.unauthenticated(),
    // );

    if (event.user.isNotEmpty) {
      // Check if location is available
      // (Assuming you've saved the location using SharedPreferences)
      // Implement a function `getLocationFromPreferences` to fetch location from SharedPreferences
      final location = await getLocationFromPreferences();
      print("location?? ${location?.latitude} + ${location?.longitude}");
      if (location != null) {
        emit(AppState.authenticated(event.user));
      } else {
        emit(const AppState.locationRequest());
      }
    } else {
      emit(const AppState.unauthenticated());
    }
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  Future<LocationData?> getLocationFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? latitude = prefs.getDouble('latitude');
    double? longitude = prefs.getDouble('longitude');
    print("location!!");
    if (latitude != null && longitude != null) {
      print("location!!!");
      return LocationData(latitude, longitude);
    } else {
      return null;
    }
  }
}
