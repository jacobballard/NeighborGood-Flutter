import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:pastry/main.dart';
import 'package:pastry/src/ui/tab_bar.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MyTabBar(),
    );
  }
}
