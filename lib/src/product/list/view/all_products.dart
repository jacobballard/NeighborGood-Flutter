import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/app/location/bloc/location_cubit.dart';
import 'package:pastry/src/product/list/bloc/product_list_bloc.dart';
import 'package:pastry/src/product/list/view/product_grid_view.dart';

class MyAllProductsPage extends StatelessWidget {
  const MyAllProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductListBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Products'),
        ),
        body: BlocBuilder<LocationCubit, GetLocationState>(
          builder: (context, locationState) {
            if (locationState is LocationKnown) {
              print("Known location :)");
              context
                  .read<ProductListBloc>()
                  .add(ProductListSubscriptionRequested(
                    maxDistance: 25.0,
                    location: locationState.position,
                  ));

              return BlocBuilder<ProductListBloc, ProductListState>(
                builder: (context, state) {
                  if (state.status == ProductListStatus.loading) {
                    print("this is why we're spinngig ${state.status}");
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status == ProductListStatus.success) {
                    print("wahhahahs");
                    return ProductGridView(
                      products: state.products,
                    );
                  } else if (state.status == ProductListStatus.empty) {
                    return Center(
                      child: Text("No products to display :("),
                    );
                  } else {
                    return Center(
                      child: Text('Error loading products: ${state.status}'),
                    );
                  }
                },
              );
            } else {
              print("unknown :()");
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
