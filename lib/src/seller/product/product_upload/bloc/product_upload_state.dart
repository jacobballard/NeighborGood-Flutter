part of 'product_upload_bloc.dart';

abstract class ProductUploadState extends Equatable {
  const ProductUploadState();

  @override
  List<Object> get props => [];
}

class ProductUploadInitial extends ProductUploadState {}

class ProductUploadInProgress extends ProductUploadState {}

class ProductUploadSuccess extends ProductUploadState {}

class ProductUploadFailure extends ProductUploadState {
  final String error;

  const ProductUploadFailure({required this.error});

  @override
  List<Object> get props => [error];
}
