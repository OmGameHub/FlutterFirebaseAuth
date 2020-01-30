import 'package:flutter/material.dart';

import 'LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Firebase Auth",
      theme: _lightTheme,
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

ThemeData _lightTheme = ThemeData(
  primaryColor: Color(0xFF27ae60),
  accentColor: Color(0xFF2ecc71),
);