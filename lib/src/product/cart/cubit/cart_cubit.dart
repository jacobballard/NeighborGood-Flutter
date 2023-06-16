import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:repositories/repositories.dart';

import '../model/cart_item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(super.initialState);

  void addToCart(ProductDetails? productDetails,
      List<CartModifierSelection>? cartModifierSelection) {}
}
