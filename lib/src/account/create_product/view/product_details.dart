import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/create_product_cubit.dart';
import '../cubit/product_details_cubit.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final productDetailsCubit =
        context.read<CreateProductCubit>().productDetailsCubit;

    return Material(
      child: BlocProvider.value(
        value: productDetailsCubit,
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    key: const Key("product_title_key_textField"),
                    onChanged: productDetailsCubit.titleChanged,
                    decoration: InputDecoration(
                      label: RichText(
                        text: TextSpan(
                          text: "Product Title",
                          style: DefaultTextStyle.of(context).style,
                          children: const <TextSpan>[
                            TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                      errorText: state.title.invalid ? 'Invalid title' : null,
                    ),
                  ),
                  TextField(
                    key: const Key("product_price_key_textField"),
                    onChanged: productDetailsCubit.priceChanged,
                    decoration: InputDecoration(
                      label: RichText(
                        text: TextSpan(
                          text: "Product Price",
                          style: DefaultTextStyle.of(context).style,
                          children: const <TextSpan>[
                            TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                      prefixText: "\$",
                      errorText: state.price.invalid ? 'Invalid price' : null,
                    ),
                  ),
                  TextField(
                    key: const Key("product_description_key_textField"),
                    onChanged: productDetailsCubit.descriptionChanged,
                    minLines: 1,
                    maxLines: 12,
                    maxLength: 1500,
                    decoration: InputDecoration(
                      labelText: 'Product Description',
                      errorText: state.description.invalid
                          ? 'Invalid description'
                          : null,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
