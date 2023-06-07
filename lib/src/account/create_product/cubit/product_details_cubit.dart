import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../model/validation.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(const ProductDetailsState());

  void titleChanged(String value) {
    final title = ProductTitle.dirty(value);
    emit(state.copyWith(
      title: title,
      status: Formz.validate([title, state.description, state.price]),
    ));
  }

  void descriptionChanged(String value) {
    final description = ProductDescription.dirty(value);
    emit(state.copyWith(
      description: description,
      status: Formz.validate([state.title, description, state.price]),
    ));
  }

  void priceChanged(String value) {
    final price = ProductPrice.dirty(value);
    emit(state.copyWith(
      price: price,
      status: Formz.validate([state.title, state.description, state.price]),
    ));
  }
}
