import 'package:flutter/material.dart';
import 'package:news_app/screens/home.dart';

//make this as splash screen
void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'DMSerif',
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),

    );
  }
}


