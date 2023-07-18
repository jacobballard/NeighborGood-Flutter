// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pastry/src/app/location/bloc/location_cubit.dart';
// import 'package:pastry/src/baker/detail/model/baker.dart';
// import 'package:pastry/src/baker/list/bloc/store_list_bloc.dart';

// class StorePage extends StatelessWidget {
//   const StorePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Stores'),
//         // actions: [
//         //   IconButton(
//         //     icon: const Icon(Icons.search),
//         //     onPressed: () async {
//         //       final result = await showSearch(
//         //         context: context,
//         //         delegate: _StoreSearchDelegate(),
//         //       );
//         //       if (result != null && result != "") {
//         //         if (context.mounted) {
//         //           BlocProvider.of<StoreListBloc>(context).add(
//         //             FetchStores(
//         //               maxDistance: 25,
//         //               // searchQuery: result,
//         //               // filterValue: '',
//         //               center: context.read<LocationCubit>().position,
//         //             ),
//         //           );
//         //         }
//         //       }
//         //     },
//         //   ),
//         //   // Add more actions if needed
//         // ],
//       ),
//       body: BlocBuilder<StoreListBloc, StoreListState>(
//         builder: (context, state) {
//           if (state is StoreListLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is StoreLoaded) {
//             return GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 1,
//                 childAspectRatio: 3.0,
//               ),
//               itemCount: state.stores.length,
//               itemBuilder: (context, index) => _buildStoreItem(
//                 context,
//                 state.stores[index],
//               ),
//             );
//           } else if (state is StoreError) {
//             return Center(
//               child: Text(
//                 state.message,
//                 textAlign: TextAlign.center,
//                 style:
//                     const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             );
//           } else {
//             return const Center(
//               child: Text(
//                 'No stores found',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildStoreItem(BuildContext context, Store store) {
//     return Card(
//       child: ListTile(
//         title: Text(store.storeName),
//         subtitle: Text(store.description),
//         trailing: IconButton(
//           icon: const Icon(Icons.favorite_border),
//           onPressed: () {
//             // Add your favorite action here
//           },
//         ),
//         onTap: () {
//           // Navigate to the store details page
//         },
//       ),
//     );
//   }
// }

// class _StoreSearchDelegate extends SearchDelegate {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     close(context, query);
//     return const SizedBox.shrink();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // Implement the suggestions based on the search query
//     return const SizedBox.shrink();
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/app/bloc/app_bloc.dart';
import 'package:pastry/src/app/location/bloc/location_cubit.dart';

import 'package:pastry/src/store/detail/model/baker.dart';
import 'package:pastry/src/store/list/bloc/store_list_bloc.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, GetLocationState>(
      listener: (context, locationState) {
        if (locationState is LocationKnown) {
          context.read<StoreListBloc>().add(FetchStores(
                maxDistance: 25.0,
                center: locationState.position,
              ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Stores'),
          actions: [
            IconButton(
              icon: const Icon(
                  Icons.abc_outlined), //replace with your desired icon
              onPressed: () {
                // BlocProvider.of<AppBloc>(context)
                //     .add(const AppLogoutRequested());
              },
            ),
          ],
        ),
        body: BlocBuilder<StoreListBloc, StoreListState>(
          builder: (context, state) {
            if (state is StoreListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StoreLoaded) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3.0,
                ),
                itemCount: state.stores.length,
                itemBuilder: (context, index) => _buildStoreItem(
                  context,
                  state.stores[index],
                ),
              );
            } else if (state is StoreError) {
              return Center(
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'No stores found',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildStoreItem(BuildContext context, Store store) {
    return Card(
      child: ListTile(
        title: Text(store.storeName),
        subtitle: Text(store.description),
        trailing: IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {
            // Add your favorite action here
          },
        ),
        onTap: () {
          // Navigate to the store details page
        },
      ),
    );
  }
}

//TODO : Do I need this?
// ignore: unused_element
class _StoreSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement the suggestions based on the search query
    return const SizedBox.shrink();
  }
}
