import 'package:flutter/material.dart';
import '../signupPage/signup_page.dart';
import '../loginPage/login_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext content) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          const Text('PAVI NET'),
          const Text('Effortless Inventory Management.'),
          const Text('Anytime.'),
          const Text('Anywhere.'),
          const SizedBox(height: 60),
          ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: const Text('SIGN UP')),
          const SizedBox(height: 30),
          ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInPage()));
              },
              child: const Text('LOG IN')),
        ])));
  }
}
