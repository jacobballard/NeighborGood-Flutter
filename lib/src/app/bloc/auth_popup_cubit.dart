// import 'dart:async';

// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'auth_popup_state.dart';

// class AuthPopupCubit extends Cubit<AuthPopupType> {
//   final AuthenticationRepository authenticationRepository;
//   StreamSubscription<bool>? _verificationStreamSubscription;

//   AuthPopupCubit({required this.authenticationRepository})
//       : super(AuthPopupType.login) {
//     _verificationStreamSubscription =
//         authenticationRepository.isEmailVerified.listen((isVerified) {
//       if (!isVerified) {
//         emit(AuthPopupType.verify);
//       }
//     });
//   }

//   // void verificationCodeChanged(String value) {
//   //   final verificationCode = VerificationCode.dirty(value);

//   //   emit(
//   //     state.copyWith(
//   //       code: verificationCode,
//   //       status: Formz.validate(
//   //         [
//   //           verificationCode,
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }

//   // Make sure to cancel the subscription when the Cubit is closed.
//   @override
//   Future<void> close() {
//     _verificationStreamSubscription?.cancel();
//     return super.close();
//   }

//   // Future<void> submit() async {
//   //   if (!state.status.isValidated) return;
//   //   emit(state.copyWith(status: FormzStatus.submissionInProgress));
//   //   try {
//   //     await authenticationRepository.
//   //   }
//   // }

//   void showVerify() => emit(AuthPopupType.verify);
//   void showSignUp() => emit(AuthPopupType.signUp);

//   void showLogin() => emit(AuthPopupType.login);
// }
