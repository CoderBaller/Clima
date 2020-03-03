import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LocationScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
      ),
    );
  }
}
