import 'package:flutter/material.dart';
import 'package:news_app/screens/home.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Cormorant',
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}


