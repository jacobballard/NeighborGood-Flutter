import 'package:flutter/material.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:pastry/main.dart';
import 'package:pastry/src/ui/tab_bar.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MyTabBar(),
    );
  }
}
