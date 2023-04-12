part of 'become_seller_cubit.dart';

class BecomeSellerState extends Equatable {
  final StoreTitle storeTitle;
  final StoreDescription storeDescription;
  final FormzStatus status;

  const BecomeSellerState({
    this.storeTitle = const StoreTitle.pure(),
    this.storeDescription = const StoreDescription.pure(),
    this.status = FormzStatus.pure,
  });

  @override
  List<Object?> get props => [storeTitle, storeDescription, status];

  BecomeSellerState copyWith({
    StoreTitle? storeTitle,
    StoreDescription? storeDescription,
    FormzStatus? status,
  }) {
    return BecomeSellerState(
      storeTitle: storeTitle ?? this.storeTitle,
      storeDescription: storeDescription ?? this.storeDescription,
      status: status ?? this.status,
    );
  }
}
