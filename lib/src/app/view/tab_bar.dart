// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pastry/src/app/location/bloc/location_cubit.dart';

// import 'package:pastry/src/product/cart/cubit/cart_cubit.dart';
// import 'package:pastry/src/product/cart/view/cart.dart';
// import 'package:pastry/src/product/list/bloc/product_list_bloc.dart';
// import 'package:pastry/src/product/list/view/all_products.dart';
// import 'package:pastry/src/account/account/view/account_settings.dart';
// import 'package:repositories/repositories.dart';

// class MyTabBar extends StatefulWidget {
//   const MyTabBar({Key? key}) : super(key: key);

//   static Page<dynamic> page() => const MaterialPage<dynamic>(child: MyTabBar());

//   @override
//   MyTabBarState createState() => MyTabBarState();
// }

// class MyTabBarState extends State<MyTabBar> {
//   int _currentIndex = 0;

//   final List<Widget> pages = [
//     // MyHomePage(title: "Test"),
//     // BlocProvider(
//     //   create: (BuildContext context) => StoreListBloc(),
//     //   child: const StorePage(),
//     // ),
//     Navigator(
//       onGenerateRoute: (settings) {
//         return MaterialPageRoute(
//           builder: (context) {
//             return BlocProvider(
//               create: (BuildContext context) => ProductListBloc(
//                 locationCubit: context.read<LocationCubit>(),
//                 productRepository: ProductRepository(),
//                 authenticationRepository:
//                     context.read<AuthenticationRepository>(),
//               ),
//               child: const MyAllProductsPage(),
//             );
//           },
//         );
//       },
//     ),
//     const CartPage(),
//     const AccountSettingsView(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return _buildBody(context);
//   }

//   Widget _buildBody(BuildContext context) {
//     if (Theme.of(context).platform == TargetPlatform.iOS) {
//       return CupertinoTabScaffold(
//         tabBar: CupertinoTabBar(
//           items: const [
//             // BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//             BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
//             BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//           ],
//           currentIndex: _currentIndex,
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//         ),
//         tabBuilder: (BuildContext context, int index) {
//           return CupertinoTabView(
//             builder: (BuildContext context) {
//               return pages[index];
//             },
//           );
//         },
//       );
//     } else {
//       return Scaffold(
//           body: pages[_currentIndex],
//           bottomNavigationBar: // Wrap BottomNavigationBar with BlocBuilder
//               BlocBuilder<CartCubit, CartState>(
//             builder: (context, state) {
//               return BottomNavigationBar(
//                 items: [
//                   // const BottomNavigationBarItem(
//                   // icon: Icon(Icons.home), label: 'Home'),
//                   const BottomNavigationBarItem(
//                       icon: Icon(Icons.search), label: 'Search'),
//                   BottomNavigationBarItem(
//                     icon: Stack(
//                       children: [
//                         const Icon(Icons.shopping_cart),
//                         if (state.checkoutItems.isNotEmpty)
//                           Positioned(
//                             right: 0,
//                             child: Container(
//                               padding: const EdgeInsets.all(1),
//                               decoration: BoxDecoration(
//                                 color: Colors.red,
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               constraints: const BoxConstraints(
//                                 minWidth: 12,
//                                 minHeight: 12,
//                               ),
//                               child: Text(
//                                 '${state.checkoutItems.length}',
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 8,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                     label: 'Cart',
//                   ),
//                   const BottomNavigationBarItem(
//                       icon: Icon(Icons.person), label: 'Profile'),
//                 ],
//                 currentIndex: _currentIndex,
//                 onTap: (index) {
//                   setState(() {
//                     _currentIndex = index;
//                   });
//                 },
//               );
//             },
//           ));
//     }
//   }
// }
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/app/location/bloc/location_cubit.dart';

import 'package:pastry/src/product/cart/cubit/cart_cubit.dart';
import 'package:pastry/src/product/cart/view/cart.dart';
import 'package:pastry/src/product/list/bloc/product_list_bloc.dart';
import 'package:pastry/src/product/list/view/all_products.dart';
import 'package:pastry/src/account/account/view/account_settings.dart';
import 'package:repositories/repositories.dart';

class MyTabBar extends StatefulWidget {
  const MyTabBar({Key? key}) : super(key: key);

  static Page<dynamic> page() => const MaterialPage<dynamic>(child: MyTabBar());

  @override
  MyTabBarState createState() => MyTabBarState();
}

class MyTabBarState extends State<MyTabBar> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (BuildContext context) => ProductListBloc(
                locationCubit: context.read<LocationCubit>(),
                productRepository: ProductRepository(),
                authenticationRepository:
                    context.read<AuthenticationRepository>(),
              ),
              child: const MyAllProductsPage(),
            );
          },
        );
      },
    ),
    const CartPage(),
    const AccountSettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return _buildBody(context, state);
      },
    );
  }

  Widget _buildBody(BuildContext context, CartState state) {
    final List<BottomNavigationBarItem> items = [
      const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      BottomNavigationBarItem(
        icon: Stack(
          children: [
            const Icon(Icons.shopping_cart),
            if (state.checkoutItems.isNotEmpty)
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Text(
                    '${state.checkoutItems.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        label: 'Cart',
      ),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ];

    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: items,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return pages[index];
            },
          );
        },
      );
    } else {
      return Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      );
    }
  }
}
