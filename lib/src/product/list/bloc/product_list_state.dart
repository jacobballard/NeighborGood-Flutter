part of 'product_list_bloc.dart';

enum ProductListStatus { initial, loading, success, failure }

class ProductListState extends Equatable {
  const ProductListState({
    this.status = ProductListStatus.initial,
    this.products = const [],

    // this.filter = ProductListFilter.all
  });

  final ProductListStatus status;
  final List<Product> products;
  // final ProductListFilter filter;

  // Iterable<Product> get filteredProducts => filter.applyAll(products);

  ProductListState copyWith({
    ProductListStatus Function()? status,
    List<Product> Function()? products,
    // ProductListFilter Function()? filter,
  }) {
    return ProductListState(
      status: status != null ? status() : this.status,
      products: products != null ? products() : this.products,
      // filter : filter != null ? filter() : this.filter,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        // filter,
      ];
}
