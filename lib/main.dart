import 'package:flutter/material.dart';
import 'pages/mainPage/mainPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF000000)),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
