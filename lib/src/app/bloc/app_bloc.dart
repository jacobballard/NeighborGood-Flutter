import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pastry/src/location/model/location_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        _cacheClient = CacheClient(),
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
  final CacheClient _cacheClient;

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) async {
    void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) async {
      if (event.user.isNotEmpty) {
        String? accountType =
            _cacheClient.read<String>(key: "--USER-ACCOUNT-TYPE--");
        AccountType accType;

        if (accountType == null) {
          accountType = await getAccountTypeFromFirestore(event.user.id);

          if (accountType != null) {
            _cacheClient.write(key: event.user.id, value: accountType);
          } else {
            // TODO : Maybe I need redundancy here depending...
          }
        }

        accType = (accountType != null && accountType == 'seller')
            ? AccountType.seller
            : AccountType.buyer;

        final updatedUser = event.user.copyWith(accountType: accType);
        _handleLocation(updatedUser, emit);
      } else {
        emit(const AppState.unauthenticated());
      }
    }
  }

  void _handleLocation(User user, Emitter<AppState> emit) async {
    final location = await getLocationFromPreferences();
    if (location != null) {
      emit(AppState.authenticated(user));
    } else {
      emit(const AppState.locationRequest());
    }
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  Future<String?> getAccountTypeFromFirestore(String userId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentSnapshot userDoc =
        await firestore.collection('users').doc(userId).get();

    String? accountType =
        (userDoc.data() as Map<String, dynamic>)['account_type'];
    return accountType;
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
    // print("location!!");
    if (latitude != null && longitude != null) {
      // print("location!!!");
      return LocationData(latitude, longitude);
    } else {
      return null;
    }
  }
}
