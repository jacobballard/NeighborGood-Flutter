// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pastry/src/app/location/bloc/location_cubit.dart';
// import 'package:pastry/src/product/list/bloc/product_list_bloc.dart';
// import 'package:pastry/src/product/list/view/product_grid_view.dart';

// class MyAllProductsPage extends StatelessWidget {
//   const MyAllProductsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) {
//         final productListBloc = ProductListBloc();
//         productListBloc.add(ProductListSubscriptionRequested(
//             maxDistance: 25.0,
//             location: context.read<LocationCubit>().position));
//         return productListBloc;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('All Products'),
//         ),
//         body: BlocBuilder<ProductListBloc, ProductListState>(
//           builder: (context, state) {
//             if (state.status == ProductListStatus.loading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state.status == ProductListStatus.success) {
//               return ProductGridView(
//                 products: state.products,
//               );
//             } else {
//               return Center(
//                 child: Text('Error loading products: ${state.status}'),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

//   // void _filterProducts() {
//   //   showModalBottomSheet<void>(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return Container(
//   //         child: Padding(
//   //           padding: const EdgeInsets.all(8.0),
//   //           child: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             children: <Widget>[
//   //               ListTile(
//   //                 title: Text('Filter by price'),
//   //                 onTap: () {
//   //                   // TODO: Filter by price
//   //                   Navigator.pop(context);
//   //                 },
//   //               ),
//   //               ListTile(
//   //                 title: Text('Filter by distance'),
//   //                 onTap: () {
//   //                   // TODO: Filter by distance
//   //                   Navigator.pop(context);
//   //                 },
//   //               ),
//   //               // Add more filter options here
//   //             ],
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/app/location/bloc/location_cubit.dart';
import 'package:pastry/src/product/list/bloc/product_list_bloc.dart';
import 'package:pastry/src/product/list/view/product_grid_view.dart';

class MyAllProductsPage extends StatelessWidget {
  const MyAllProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, GetLocationState>(
      listener: (context, locationState) {
        if (locationState is LocationKnown) {
          context.read<ProductListBloc>().add(ProductListSubscriptionRequested(
                maxDistance: 25.0,
                location: locationState.position,
              ));
        }
      },
      child: BlocProvider(
        create: (context) => ProductListBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('All Products'),
          ),
          body: BlocBuilder<ProductListBloc, ProductListState>(
            builder: (context, state) {
              if (state.status == ProductListStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == ProductListStatus.success) {
                return ProductGridView(
                  products: state.products,
                );
              } else {
                return Center(
                  child: Text('Error loading products: ${state.status}'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
