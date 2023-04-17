part of 'location_cubit.dart';

@immutable
abstract class GetLocationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocationLoading extends GetLocationState {}

class LocationKnown extends GetLocationState {
  final GeoPoint position;

  LocationKnown(this.position);

  @override
  List<Object?> get props => [position];
}

class LocationUnknown extends GetLocationState {}
