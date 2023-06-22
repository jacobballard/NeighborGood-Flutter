import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pastry/src/product/detail/cubit/product_detail_cubit.dart';
import '../../cart/cubit/cart_cubit.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewProductDetailsCubit, ViewProductDetailsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity, // take full width
            child: ElevatedButton(
              onPressed: state.inputStatus.isValidated
                  ? () {
                      context.read<CartCubit>().addToCart(state.productDetails,
                          state.cartModifierSelections, state.displayPrice);
                    }
                  : null,
              child: Text("Add to Cart"),
            ),
          ),
        );
      },
    );
  }
}
