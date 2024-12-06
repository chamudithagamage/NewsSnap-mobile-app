import 'package:flutter/material.dart';
//splash screen

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 100,
              height: 100,
              child: Image.asset('assets/images/playstore.png',
              fit: BoxFit.cover,
              ),
          ),
          Text(
           'News|snap',
           style: TextStyle(
             color: Colors.teal,
             fontSize: 30,
             fontFamily: 'DMSerif'
           ),
          ),
        ],
      ),
    );
  }
}
