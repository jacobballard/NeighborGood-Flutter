import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(state.copyWith(
      username: username,
      status: Formz.validate([
        username,
        state.realName,
        // Add other form inputs here
      ]),
    ));
  }

  void realNameChanged(String value) {
    final realName = RealName.dirty(value);
    emit(state.copyWith(
      realName: realName,
      status: Formz.validate([
        state.username,
        realName,
        // Add other form inputs here
      ]),
    ));
  }

  Future<void> onboardingSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      // Profile repo call to submit with state."".value
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
