import 'package:flutter/material.dart';
import 'package:glob_app/screens/home.dart';
import 'package:glob_app/screens/settings.dart';
import 'package:glob_app/shared/menu_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GlobApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: SettingsScreen(),
      home: HomeScreen(),
    );
  }
}
