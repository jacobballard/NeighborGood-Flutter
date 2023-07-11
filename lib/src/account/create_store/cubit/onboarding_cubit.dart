import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void setBusinessType(BusinessType value) {
    if (value == BusinessType.business) {
      emit(state.copyWith(
        businessType: value,
        firstName: const Name.pure(),
        lastName: const Name.pure(),
        day: const Day.pure(),
        month: const Month.pure(),
        year: const Year.pure(),
        ssLastFour: const SSLastFour.pure(),
        status: FormzStatus.pure,
      ));
    } else if (value == BusinessType.individual) {
      emit(state.copyWith(
        businessType: value,
        companyTaxId: const CompanyTaxId.pure(),
        companyName: const Name.pure(),
        status: FormzStatus.pure,
      ));
    } else {
      emit(state.copyWith(
        businessType: value,
        companyTaxId: const CompanyTaxId.pure(),
        companyName: const Name.pure(),
        firstName: const Name.pure(),
        lastName: const Name.pure(),
        day: const Day.pure(),
        month: const Month.pure(),
        year: const Year.pure(),
        ssLastFour: const SSLastFour.pure(),
        status: FormzStatus.pure,
      ));
    }
  }

  void companyTaxIdChanged(String value) {
    final companyTaxId = CompanyTaxId.dirty(value);

    emit(state.copyWith(
      companyTaxId: companyTaxId,
      status: Formz.validate([
        companyTaxId,
        state.companyName,
      ]),
    ));
  }

  void companyNameChanged(String value) {
    final companyName = Name.dirty(value);
    emit(state.copyWith(
      companyName: companyName,
      status: Formz.validate([companyName, state.companyTaxId]),
    ));
  }

  void firstNameChanged(String value) {
    final firstName = Name.dirty(value);

    emit(state.copyWith(
      firstName: firstName,
      status: Formz.validate([
        firstName,
        state.lastName,
        state.day,
        state.month,
        state.year,
        state.ssLastFour,
      ]),
    ));
  }

  void lastNameChanged(String value) {
    final lastName = Name.dirty(value);

    emit(state.copyWith(
      lastName: lastName,
      status: Formz.validate([
        lastName,
        state.firstName,
        state.day,
        state.month,
        state.year,
        state.ssLastFour,
      ]),
    ));
  }

  void dayChanged(String value) {
    final day = Day.dirty(value);

    emit(state.copyWith(
      day: day,
      status: Formz.validate([
        day,
        state.firstName,
        state.lastName,
        state.month,
        state.year,
        state.ssLastFour,
      ]),
    ));
  }

  void monthChanged(String value) {
    final month = Month.dirty(value);

    emit(state.copyWith(
      month: month,
      status: Formz.validate([
        month,
        state.firstName,
        state.lastName,
        state.day,
        state.year,
        state.ssLastFour,
      ]),
    ));
  }

  void yearChanged(String value) {
    final year = Year.dirty(value);

    emit(state.copyWith(
      year: year,
      status: Formz.validate([
        year,
        state.firstName,
        state.lastName,
        state.day,
        state.month,
        state.ssLastFour,
      ]),
    ));
  }

  void ssLastFourChanged(String value) {
    final ssLastFour = SSLastFour.dirty(value);

    emit(state.copyWith(
      ssLastFour: ssLastFour,
      status: Formz.validate([
        ssLastFour,
        state.firstName,
        state.lastName,
        state.day,
        state.month,
        state.year,
      ]),
    ));
  }
}
