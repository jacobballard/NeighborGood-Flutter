part of 'store_list_bloc.dart';

abstract class StoreListEvent {}

class FetchStores extends StoreListEvent {
  final double maxDistance;
  final String searchQuery;
  final String filterValue;
  final GeoPoint center;

  FetchStores({
    required this.maxDistance,
    required this.searchQuery,
    required this.filterValue,
    required this.center,
  });
}
