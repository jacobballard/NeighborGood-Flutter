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
  final DeliveryMethods deliveryMethods;
  final StoreLatitude storeLatitude;
  final StoreLongitude storeLongitude;
  final String? errorMessage;

  const BecomeSellerState({
    this.storeTitle = const StoreTitle.pure(),
    this.storeDescription = const StoreDescription.pure(),
    this.storeInsta = const StoreInsta.pure(),
    this.storeTik = const StoreTik.pure(),
    this.storePin = const StorePin.pure(),
    this.storeMeta = const StoreMeta.pure(),
    this.status = FormzStatus.pure,
    this.deliveryMethods = const DeliveryMethods.pure(),
    this.deliveryRange = const DeliveryRange.pure(),
    this.storeLatitude = const StoreLatitude.pure(),
    this.storeLongitude = const StoreLongitude.pure(),
    this.errorMessage,
  });

  @override
  List<Object?> get props =>
      [storeTitle, storeDescription, status, deliveryMethods];

  BecomeSellerState copyWith({
    StoreTitle? storeTitle,
    StoreDescription? storeDescription,
    StoreInsta? storeInsta,
    StorePin? storePin,
    StoreMeta? storeMeta,
    StoreTik? storeTik,
    FormzStatus? status,
    DeliveryMethods? deliveryMethods,
    StoreLatitude? storeLatitude,
    StoreLongitude? storeLongitude,
    DeliveryRange? deliveryRange,
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
      deliveryMethods: deliveryMethods ?? this.deliveryMethods,
      deliveryRange: deliveryRange ?? this.deliveryRange,
      storeLatitude: storeLatitude ?? this.storeLatitude,
      storeLongitude: storeLongitude ?? this.storeLongitude,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
