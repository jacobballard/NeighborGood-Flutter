part of 'onboarding_cubit.dart';

enum BusinessType { none, business, individual }

class OnboardingState extends Equatable {
  final BusinessType businessType;
  final CompanyTaxId companyTaxId;
  final Name companyName;
  final Name firstName;
  final Name lastName;
  final Day day;
  final Month month;
  final Year year;
  final SSLastFour ssLastFour;
  final FormzStatus status;

  const OnboardingState({
    this.businessType = BusinessType.none,
    this.companyTaxId = const CompanyTaxId.pure(),
    this.companyName = const Name.pure(),
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.day = const Day.pure(),
    this.month = const Month.pure(),
    this.year = const Year.pure(),
    this.ssLastFour = const SSLastFour.pure(),
    this.status = FormzStatus.pure,
  });
  @override
  List<Object?> get props => [
        businessType,
        companyTaxId,
        companyName,
        firstName,
        lastName,
        day,
        month,
        year,
        ssLastFour,
        status,
      ];

  OnboardingState copyWith({
    BusinessType? businessType,
    CompanyTaxId? companyTaxId,
    Name? companyName,
    Name? firstName,
    Name? lastName,
    Day? day,
    Month? month,
    Year? year,
    SSLastFour? ssLastFour,
    FormzStatus? status,
  }) {
    return OnboardingState(
      businessType: businessType ?? this.businessType,
      companyTaxId: companyTaxId ?? this.companyTaxId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      companyName: companyName ?? this.companyName,
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
      ssLastFour: ssLastFour ?? this.ssLastFour,
      status: status ?? this.status,
    );
  }
}
