part of 'product_details_cubit.dart';

class ProductDetailsState extends Equatable {
  final ProductTitle title;
  final ProductDescription description;
  final ProductPrice price;
  final FormzStatus status;

  const ProductDetailsState({
    this.title = const ProductTitle.pure(),
    this.description = const ProductDescription.pure(),
    this.price = const ProductPrice.pure(),
    this.status = FormzStatus.pure,
  });

  ProductDetailsState copyWith({
    ProductTitle? title,
    ProductDescription? description,
    ProductPrice? price,
    FormzStatus? status,
  }) {
    return ProductDetailsState(
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [title, description, price, status];
}
