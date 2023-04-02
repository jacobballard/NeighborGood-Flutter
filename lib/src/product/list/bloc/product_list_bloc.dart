import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pastry/src/product/detail/model/product.dart';

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

    // Network call to firebase and update status and products list
  }
}
