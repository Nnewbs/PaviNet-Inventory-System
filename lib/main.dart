import 'package:flutter/material.dart';
import 'package:pavinet/firebase_options.dart';
import 'pages/mainPage/mainPage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Ensure that widget binding is initialized before Firebase initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase asynchronously
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Start the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF000000)),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
