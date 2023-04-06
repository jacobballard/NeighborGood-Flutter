// import 'package:flutter/material.dart';
// import 'package:pastry/src/baker/detail/view/store_detail.dart';

// import '../../detail/model/baker.dart';

// class StorePage extends StatefulWidget {
//   @override
//   _StorePageState createState() => _StorePageState();
// }

// class _StorePageState extends State<StorePage> {
//   // List<Store> _stores = Store.allStores;
//   // List<Baker> _filteredStores = Baker.allStores;
//   String _searchQuery = '';
//   String _filterValue = '';
//   double _maxDistance = 50.0;

//   void _onSearch(String query) {
//     setState(() {
//       if (query != "") {
//         print(query);
//         _searchQuery = query;
//         _filterStores();
//       }
//     });
//   }

//   void _onFilter(String value) {
//     setState(() {
//       _filterValue = value;
//       _filterStores();
//     });
//   }

//   void _filterStores() {
//     print("filtering?!!");
//     // var filtered = _stores.where((store) {
//     //   final nameMatch = store.title.toLowerCase().contains(_searchQuery);
//     //   final filterMatch =
//     //       store.price.toString().startsWith(_filterValue) || _filterValue == '';
//     //   return nameMatch && filterMatch;
//     // }).toList();
//     setState(() {
//       // _filteredStores = filtered;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       // _stores = Baker.allStores;
//       // _filteredStores = Baker.allStores;
//     });
//   }

//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         Image.network(store.image),
//   //         Padding(
//   //           padding: const EdgeInsets.all(8.0),
//   //           child: Column(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               Text(
//   //                 store.name,
//   //                 style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//   //               ),
//   //               Row(
//   //                 children: [
//   //                   Icon(Icons.star, color: Colors.yellow),
//   //                   SizedBox(width: 8.0),
//   //                   Text(
//   //                     '${store.rating} stars',
//   //                     style: TextStyle(color: Colors.grey),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   // Widget _buildStoreCard(BuildContext context, int index) {
//   //   final store = _filteredStores[index];
//   //   final stars = List<Widget>.generate(
//   //       store.rating.floor(), (_) => Icon(Icons.star, color: Colors.yellow));
//   //   if (store.rating % 1 != 0) {
//   //     stars.add(Icon(Icons.star_half, color: Colors.yellow));
//   //   }
//   //   final distance = store.distance.toStringAsFixed(1);

//   //   return GestureDetector(
//   //     onTap: () {
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (context) => StoreDetailPage(store: store),
//   //         ),
//   //       );
//   //     },
//   //     child: Card(
//   //       child: Column(
//   //         crossAxisAlignment: CrossAxisAlignment.stretch,
//   //         children: [
//   //           Expanded(
//   //             child: Image.network(
//   //               store.images[0],
//   //               fit: BoxFit.cover,
//   //             ),
//   //           ),
//   //           Padding(
//   //             padding: const EdgeInsets.all(8.0),
//   //             child: Column(
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Text(store.title,
//   //                     style: TextStyle(fontWeight: FontWeight.bold)),
//   //                 SizedBox(height: 4.0),
//   //                 Row(children: [
//   //                   Row(children: stars),
//   //                   SizedBox(width: 8.0),
//   //                   Text(store.rating.toString(),
//   //                       style: TextStyle(fontWeight: FontWeight.bold)),
//   //                 ]),
//   //                 SizedBox(height: 4.0),
//   //                 Text('$distance miles away'),
//   //               ],
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }

//   Widget _buildStoreCard(BuildContext context, int index) {
//     final store = _filteredStores[index];
//     final fullStars = store.rating.floor();
//     // final hasHalfStar = store.rating % 1 != 0;
//     final hasPartialStar = store.rating > fullStars;
//     final partialStarFraction = store.rating - fullStars;
//     final starWidgets = List<Widget>.generate(
//       fullStars,
//       (_) => Icon(Icons.star, color: Colors.yellow),
//     );
//     // if (hasHalfStar) {
//     //   starWidgets.add(Icon(Icons.star_half, color: Colors.yellow));
//     // }
//     if (hasPartialStar) {
//       starWidgets.add(
//         FractionalTranslation(
//           translation: Offset(-partialStarFraction, 0),
//           child: Icon(Icons.star_border, color: Colors.yellow),
//         ),
//       );
//     }

//     // final distance = store.distance.toStringAsFixed(1);

//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => StoreDetailPage(store: store),
//           ),
//         );
//       },
//       child: Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               child: Image.network(
//                 store.images[0],
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(store.title,
//                       style: TextStyle(fontWeight: FontWeight.bold)),
//                   SizedBox(height: 4.0),
//                   Row(children: starWidgets),
//                   SizedBox(height: 4.0),
//                   Text(
//                       'TODO miles away'), // TODO: Need to calculate distance here
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Stores'),
//         actions: [
//           // IconButton(
//           //   icon: Icon(Icons.search),
//           //   onPressed: () async {
//           //     final result = await showSearch(
//           //       context: context,
//           //       delegate: _StoreSearchDelegate(),
//           //     );
//           //     if (result != null && result != "") {
//           //       _onSearch(result);
//           //     }
//           //   },
//           // ),
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () async {
//               final result = await showSearch(
//                 context: context,
//                 delegate: _StoreSearchDelegate(),
//               );
//               if (result != null && result != "") {
//                 print("result ! ${result}");
//                 _onSearch(result);
//               }
//             },
//           ),

//           PopupMenuButton<String>(
//             onSelected: _onFilter,
//             itemBuilder: (BuildContext context) => [
//               PopupMenuItem(
//                 value: '',
//                 child: Text('All'),
//               ),
//               PopupMenuItem(
//                 value: '2',
//                 child: Text('\$ - \$\$', style: TextStyle(color: Colors.green)),
//               ),
//               PopupMenuItem(
//                 value: '3',
//                 child: Text('\$\$ - \$\$\$',
//                     style: TextStyle(color: Colors.orange)),
//               ),
//               PopupMenuItem(
//                 value: '4',
//                 child: Text('\$\$\$ - \$\$\$\$',
//                     style: TextStyle(color: Colors.red)),
//               ),
//               PopupMenuDivider(),
//               PopupMenuItem(
//                 child: ListTile(
//                   title: Text('Maximum distance'),
//                   trailing: Text('${_maxDistance.toStringAsFixed(0)} miles'),
//                 ),
//               ),
//               PopupMenuItem(
//                 child: Slider(
//                   value: _maxDistance,
//                   min: 0.0,
//                   max: 50.0,
//                   onChanged: (value) {
//                     setState(() {
//                       _maxDistance = value;
//                       _filterStores();
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 1,
//           childAspectRatio: 3.0,
//         ),
//         itemCount: _filteredStores.length,
//         itemBuilder: _buildStoreCard,
//       ),
//     );
//   }
// }

// class _StoreSearchDelegate extends SearchDelegate<String> {
//   final List<String> _history = [];

//   _StoreSearchDelegate() : super(searchFieldLabel: 'Search stores');

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           if (query == '') {
//             close(context, "");
//           } else {
//             query = '';
//           }
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, "");
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Container(); // Implement your search results page
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestions = [
//       'Coffee',
//       'Bakery',
//       'Candy Store',
//       'Ice Cream Shop',
//     ];
//     final filtered = query.isEmpty
//         ? _history
//         : suggestions.where((s) => s.toLowerCase().contains(query)).toList();
//     return ListView.builder(
//       itemCount: filtered.length,
//       itemBuilder: (BuildContext context, int index) {
//         final item = filtered[index];
//         return ListTile(
//           title: Text(item),
//           onTap: () {
//             query = item;
//             showResults(context);
//           },
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/baker/detail/model/baker.dart';
import 'package:pastry/src/baker/list/bloc/store_list_bloc.dart';
import 'package:pastry/src/location/utils/location_utils.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stores'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final result = await showSearch(
                context: context,
                delegate: _StoreSearchDelegate(),
              );
              if (result != null && result != "") {
                BlocProvider.of<StoreListBloc>(context).add(
                  FetchStores(
                    maxDistance: 25,
                    searchQuery: result,
                    filterValue: '',
                    center: await getStoredLocation(),
                  ),
                );
              }
            },
          ),
          // Add more actions if needed
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
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
