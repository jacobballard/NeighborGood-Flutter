import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:repositories/repositories.dart';

part 'finalize_payment_state.dart';

class FinalizePaymentCubit extends Cubit<FinalizePaymentState> {
  FinalizePaymentCubit({
    required this.authenticationRepository,
    required this.cartRepository,
  }) : super(const FinalizePaymentState());

  final AuthenticationRepository authenticationRepository;
  final CartRepository cartRepository;
  CardFieldInputDetails? _card;

  void firstNameChanged(String value) {
    final email = Email.dirty(value);
    print('email good? ${email.valid}');
    emit(state.copyWith(
        email: email,
        status: (_card?.complete ?? false)
            ? Formz.validate([email])
            : FormzStatus.invalid));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    print('email good? ${email.valid}');
    emit(state.copyWith(
        email: email,
        status: (_card?.complete ?? false)
            ? Formz.validate([email])
            : FormzStatus.invalid));
  }

  void setCard(CardFieldInputDetails? card) {
    print('set card again ${card?.complete}');
    _card = card;
    emit(state.copyWith(
        status: (_card?.complete ?? false)
            ? Formz.validate([state.email])
            : FormzStatus.invalid));
  }

  void copyNeededStateDetails(
      bool needsEmailAddress, Email email, String clientSecret) {
    print('copying ${email.value}');
    emit(state.copyWith(
      clientSecret: clientSecret,
      email: email,
      needsEmailAddress: needsEmailAddress,
    ));
  }

  Future<void> handlePayPress() async {
    if (state.status.isInvalid || state.email.value == "") return;
    print(state.clientSecret);
    print('secret');
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress),
    );
    try {
      final intent = await Stripe.instance.confirmPayment(
          paymentIntentClientSecret: state.clientSecret,
          data: PaymentMethodParams.card(
            paymentMethodData: PaymentMethodData(
                billingDetails: BillingDetails(email: state.email.value)),
          ));

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      print(intent.amount);
    } on StripeException catch (e) {
      print(e);
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    } catch (e) {
      print(e);
    }
  }
}
