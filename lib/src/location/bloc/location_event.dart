part of 'location_bloc.dart';

abstract class LocationEvent {}

class GetLocationEvent extends LocationEvent {}

class UpdateLocationEvent extends LocationEvent {
  final double latitude;
  final double longitude;
  final VoidCallback? onLocationUpdated;

  UpdateLocationEvent({
    required this.latitude,
    required this.longitude,
    this.onLocationUpdated,
  });
}

class SubmitZipCodeEvent extends LocationEvent {
  final String zipCode;
  SubmitZipCodeEvent(this.zipCode);
}
