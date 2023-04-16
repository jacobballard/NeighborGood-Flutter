import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pastry/src/baker/detail/model/baker.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
part 'store_list_event.dart';
part 'store_list_state.dart';

class StoreListBloc extends Bloc<StoreListEvent, StoreListState> {
  StoreListBloc() : super(StoreListInitial()) {
    on<FetchStores>(_onFetchStores);
  }

  Future<void> _onFetchStores(
    FetchStores event,
    Emitter<StoreListState> emit,
  ) async {
    emit(StoreListLoading());
    try {
      List<Store> stores = await fetchStoresFromFirestore(
        maxDistance: event.maxDistance,
        searchQuery: event.searchQuery,
        filterValue: event.filterValue,
        center: event.center,
      );
      emit(StoreLoaded(stores));
    } catch (e) {
      emit(StoreError(e.toString()));
    }
  }

  Future<List<Store>> fetchStoresFromFirestore({
    required double maxDistance,
    required String searchQuery,
    required String filterValue,
    required GeoPoint center,
  }) async {
    // Initialize Geoflutterfire
    final geo = Geoflutterfire();
    final collectionRef = FirebaseFirestore.instance.collection('stores');
    final geoRef = geo.collection(collectionRef: collectionRef);

    // Create a center point from the given latitude and longitude
    final centerPoint =
        geo.point(latitude: center.latitude, longitude: center.longitude);

    // Perform the geo query
    final queryStream = geoRef.within(
      center: centerPoint,
      radius: maxDistance,
      field:
          'location', // The field containing the GeoPoint in your Firestore documents
      strictMode: true,
    );

    // Fetch documents and convert them to Store instances
    List<Store> stores = [];
    await for (final documentSnapshotIterable in queryStream) {
      for (final doc in documentSnapshotIterable) {
        stores.add(Store.fromDocument(doc));
      }
    }

    return stores;
  }
}
