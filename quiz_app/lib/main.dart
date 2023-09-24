import 'package:flutter/material.dart';
import 'package:quiz_app/pages/welcomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Quiz App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,  
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const WelcomeScreen(),
    );
  }
}
