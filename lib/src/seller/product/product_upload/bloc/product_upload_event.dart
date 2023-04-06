part of 'product_upload_bloc.dart';

abstract class ProductUploadEvent extends Equatable {
  const ProductUploadEvent();
}

class ProductUpload extends ProductUploadEvent {
  final Product product;
  final ImageSource imageSource;

  const ProductUpload({required this.product, required this.imageSource});

  @override
  List<Object> get props => [product, imageSource];
}
