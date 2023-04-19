import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/account/account/model/account.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  ProfileBloc() : super(InitialProfileState()) {
    on<ProfileInitRequested>(_onProfileInitRequested);
  }
  Future<void> _onProfileInitRequested(
    ProfileInitRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(InitialProfileState());

    try {
      final accountDoc =
          await _firebaseFirestore.collection('users').doc(event.uid).get();

      if (!accountDoc.exists) {
        print("account didn't exist :(");
        emit(const LoadedProfileState(status: ProfileStatus.error));
        return;
      }

      final account = Account.fromDocument(accountDoc);

      emit(LoadedProfileState(status: ProfileStatus.success, account: account));
    } catch (e) {
      emit(const LoadedProfileState(status: ProfileStatus.error));
    }
  }

  // Future<void> _onProfileInitRequested(
  //   ProfileInitRequested event,
  //   Emitter<ProfileState> emit,
  // ) async {
  //   emit(InitialProfileState());

  //   try {
  //     final user = _firebaseAuth.currentUser;
  //     print(user);
  //     if (user == null) {
  //       emit(const LoadedProfileState(status: ProfileStatus.error));
  //       return;
  //     }

  //     final accountDoc =
  //         await _firebaseFirestore.collection('users').doc(user.uid).get();

  //     if (!accountDoc.exists) {
  //       emit(const LoadedProfileState(status: ProfileStatus.error));
  //       return;
  //     }

  //     final account = Account.fromDocument(accountDoc);

  //     emit(LoadedProfileState(status: ProfileStatus.success, account: account));
  //   } catch (e) {
  //     emit(const LoadedProfileState(status: ProfileStatus.error));
  //   }
  // }
}
