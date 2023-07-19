import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';
import '../../../app/location/bloc/location_cubit.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductRepository productRepository;
  final LocationCubit locationCubit;
  final AuthenticationRepository authenticationRepository;

  ProductListBloc({
    required this.productRepository,
    required this.locationCubit,
    required this.authenticationRepository,
  }) : super(const ProductListState()) {
    on<ProductListSubscriptionRequested>(_onSubscriptionRequested);
  }

  Future<void> _onSubscriptionRequested(
    ProductListSubscriptionRequested event,
    Emitter<ProductListState> emit,
  ) async {
    emit(state.copyWith(status: () => ProductListStatus.loading));

    try {
      if (locationCubit.state is LocationKnown) {
        final position = (locationCubit.state as LocationKnown).position;

        List<Product> products = await productRepository.getAllProducts(
          token: await authenticationRepository.getIdToken(),
          lat: position.latitude,
          lng: position.longitude,
          radius: 20,
          filterShipping: true,
          filterDelivery: true,
          filterPickup: true,
        );

        if (products.isNotEmpty) {
          emit(state.copyWith(
            status: () => ProductListStatus.success,
            products: () => products,
          ));
        } else {
          emit(state.copyWith(
            status: () => ProductListStatus.empty,
            products: () => [],
          ));
        }
      } else {
        // List<Product> product
        emit(state.copyWith(status: () => ProductListStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(status: () => ProductListStatus.failure));
    }
  }
}
