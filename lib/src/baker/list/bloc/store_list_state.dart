part of 'store_list_bloc.dart';

abstract class StoreListState {}

class StoreListInitial extends StoreListState {}

class StoreListLoading extends StoreListState {}

class StoreLoaded extends StoreListState {
  final List<Store> stores;
  StoreLoaded(this.stores);
}

class StoreError extends StoreListState {
  final String message;
  StoreError(this.message);
}
