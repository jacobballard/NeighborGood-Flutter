// import 'package:flutter/material.dart';
// import 'package:pastry/main.dart';

// class MyTabBar extends StatefulWidget {
//   @override
//   _MyTabBarState createState() => _MyTabBarState();
// }

// class _MyTabBarState extends State<MyTabBar>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   final List<Tab> tabs = [
//     Tab(icon: Icon(Icons.home), text: 'Home'),
//     Tab(icon: Icon(Icons.search), text: 'Search'),
//     Tab(icon: Icon(Icons.person), text: 'Profile'),
//   ];

//   final List<Widget> pages = [
//     MyHomePage(title: "Test"),
//     MyHomePage(title: "Test"),
//     MyHomePage(title: "Test")
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: tabs.length, vsync: this);
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text('My App'),
//   //       bottom: TabBar(
//   //         controller: _tabController,
//   //         tabs: tabs,
//   //       ),
//   //     ),
//   //     body: TabBarView(
//   //       controller: _tabController,
//   //       children: pages,
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: TabBarView(
//         controller: _tabController,
//         children: pages,
//       ),
//       bottomNavigationBar: Material(
//         color: Theme.of(context).primaryColor,
//         child: TabBar(
//           controller: _tabController,
//           tabs: tabs,
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pastry/main.dart';
import 'package:pastry/src/ui/all_bakers.dart';
import 'package:pastry/src/ui/all_products.dart';
import 'package:pastry/src/ui/profile.dart';

class MyTabBar extends StatefulWidget {
  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    // MyHomePage(title: "Test"),
    StorePage(),
    MyAllProductsPage(),
    UserProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
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
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
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
