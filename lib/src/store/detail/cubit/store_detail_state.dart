part of 'store_detail_cubit.dart';

enum StoreDetailStatus { initial, loading, success, failure }

enum StoreProductDetailStatus { initial, loading, success, failure }

class StoreDetailState extends Equatable {
  const StoreDetailState({
    this.status,
    this.productsStatus,
    this.store,
    this.errorMessage,
    this.products,
  });
  final StoreProductDetailStatus? productsStatus;
  final StoreDetailStatus? status;
  final StoreDetail? store;
  final String? errorMessage;
  final List<Product>? products;

  StoreDetailState copyWith({
    StoreDetailStatus? status,
    StoreDetail? store,
    String? errorMessage,
    List<ProductDetails>? products,
    StoreProductDetailStatus? productsStatus,
  }) {
    return StoreDetailState(
      status: status ?? this.status,
      store: store ?? this.store,
      errorMessage: errorMessage ?? this.errorMessage,
      products: products ?? this.products,
      productsStatus: productsStatus ?? this.productsStatus,
    );
  }

  @override
  List<Object?> get props => [
        status,
        productsStatus,
        store,
        errorMessage,
        products,
      ];
}
