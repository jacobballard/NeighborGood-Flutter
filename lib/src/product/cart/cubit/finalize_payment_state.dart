part of 'finalize_payment_cubit.dart';

class FinalizePaymentState extends Equatable {
  final FormzStatus status;
  final String? errorMessage;
  final Email email;
  final bool needsEmailAddress;
  final String clientSecret;

  const FinalizePaymentState({
    this.status = FormzStatus.pure,
    this.errorMessage = '',
    this.clientSecret = '',
    this.email = const Email.pure(),
    this.needsEmailAddress = true,
  });

  FinalizePaymentState copyWith({
    FormzStatus? status,
    String? errorMessage,
    Email? email,
    bool? needsEmailAddress,
    String? clientSecret,
  }) {
    return FinalizePaymentState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      needsEmailAddress: needsEmailAddress ?? this.needsEmailAddress,
      clientSecret: clientSecret ?? this.clientSecret,
    );
  }

  @override
  get props => [status, errorMessage, email, needsEmailAddress, clientSecret];
}
