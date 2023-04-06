import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:pastry/src/baker/detail/model/baker.dart';
import 'package:pastry/src/location/utils/location_utils.dart';
import 'package:pastry/src/product/list/model/product_summary.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(const ProductListState()) {
    on<ProductListSubscriptionRequested>(_onSubscriptionRequested);
  }

  Future<void> _onSubscriptionRequested(
    ProductListSubscriptionRequested event,
    Emitter<ProductListState> emit,
  ) async {
    emit(state.copyWith(status: () => ProductListStatus.loading));

    // First, get the nearby stores within the desired distance
    List<Store> nearbyStores =
        await _fetchNearbyStores(25.0, await getStoredLocation());

    // Initialize an empty list to store product summaries
    List<ProductSummary> productSummaries = [];

    // For each store, query its products and create product summaries
    for (final store in nearbyStores) {
      final productsQuery = FirebaseFirestore.instance
          .collection('products')
          .where('storeID', isEqualTo: store.userID)
          .snapshots();

      await for (final snapshot in productsQuery) {
        for (final doc in snapshot.docs) {
          final productSummary = ProductSummary.fromDocument(doc);
          productSummaries.add(productSummary);
        }
      }
    }

    // Update the state with the fetched product summaries and update the status
    emit(state.copyWith(
      status: () => ProductListStatus.success,
      products: () => productSummaries,
    ));
  }

  Future<List<Store>> _fetchNearbyStores(
      double maxDistance, GeoPoint center) async {
    // final geoRef = Geoflutterfire()
    //     .geoFirestore
    //     .collection(FirebaseFirestore.instance.collection('stores'));

    final geo = Geoflutterfire();
    final collectionRef = FirebaseFirestore.instance.collection('stores');
    final geoRef = geo.collection(collectionRef: collectionRef);

    final centerPoint = GeoFirePoint(center.latitude, center.longitude);

    final queryStream = geoRef.within(
      center: centerPoint,
      radius: maxDistance / 1000, // Convert to kilometers
      field:
          'location', // The field containing the GeoPoint in your Firestore documents
      strictMode: true,
    );
    // .map((event) =>
    // event.docs.map((doc) => Store.fromDocument(doc)).toList());

    List<Store> stores = [];

    await for (final snapshot in queryStream) {
      for (final doc in snapshot) {
        stores.add(Store.fromDocument(doc));
      }
    }
    return stores;
  }
}
