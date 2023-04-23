part of 'become_seller_cubit.dart';

class BecomeSellerState extends Equatable {
  final StoreTitle storeTitle;
  final StoreDescription storeDescription;
  final DeliveryRange deliveryRange;
  final StoreTik storeTik;
  final StoreInsta storeInsta;
  final StorePin storePin;
  final StoreMeta storeMeta;
  final FormzStatus status;
  final String? errorMessage;

  const BecomeSellerState({
    this.storeTitle = const StoreTitle.pure(),
    this.storeDescription = const StoreDescription.pure(),
    this.storeInsta = const StoreInsta.pure(),
    this.storeTik = const StoreTik.pure(),
    this.storePin = const StorePin.pure(),
    this.storeMeta = const StoreMeta.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [storeTitle, storeDescription, status];

  BecomeSellerState copyWith({
    StoreTitle? storeTitle,
    StoreDescription? storeDescription,
    StoreInsta? storeInsta,
    StorePin? storePin,
    StoreMeta? storeMeta,
    StoreTik? storeTik,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return BecomeSellerState(
      storeTitle: storeTitle ?? this.storeTitle,
      storeDescription: storeDescription ?? this.storeDescription,
      storeInsta: storeInsta ?? this.storeInsta,
      storeMeta: storeMeta ?? this.storeMeta,
      storePin: storePin ?? this.storePin,
      storeTik: storeTik ?? this.storeTik,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
