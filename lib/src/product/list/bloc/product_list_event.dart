part of 'product_list_bloc.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class ProductListSubscriptionRequested extends ProductListEvent {
  final double maxDistance;
  final GeoPoint location;

  const ProductListSubscriptionRequested({
    required this.maxDistance,
    required this.location,
  });
}

// TODO : Later, example found here : https://github.com/felangel/bloc/blob/master/examples/flutter_todos/lib/todos_overview/models/todos_view_filter.dart

// class ProductListFilterChanged extends ProductListEvent {
//   const ProductListFilterChanged(this.filter);

//   final ProductListFilter filter;

// }
