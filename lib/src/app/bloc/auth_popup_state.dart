part of 'auth_popup_cubit.dart';

enum AuthPopupType { login, signUp, verify }

// class AuthPopupState extends Equatable {
//   // final VerificationCode code;
//   // final FormzStatus status;
//   final String? errorMessage;
//   final AuthPopupType type;

//   const AuthPopupState({
//     // this.code = const VerificationCode.pure(),
//     // this.status = FormzStatus.pure,
//     // this.errorMessage,
//     this.type = AuthPopupType.login,
//   });

//   AuthPopupState copyWith({
//     // FormzStatus? status,
//     // String? errorMessage,
//     AuthPopupType? type,
//     // VerificationCode? code,
//   }) {
//     return AuthPopupState(
//       // status: status ?? this.status,
//       // errorMessage: errorMessage ?? this.errorMessage,
//       type: type ?? this.type,
//       // code: code ?? this.code,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         // status,
//         errorMessage,
//         type,
//         // code,
//       ];
// }
