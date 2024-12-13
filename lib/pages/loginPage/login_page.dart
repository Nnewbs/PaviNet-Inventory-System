import 'package:flutter/material.dart';
import 'package:pavinet/pages/adminPages/adminPages.dart';
import 'package:pavinet/pages/signupPage/signup_page.dart';
import 'package:pavinet/pages/supplierPages/supplierPages.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext content) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          const Text('LOG IN'),
          const Text('Please sign in to continue'),
          const Text('textfield...'),
          const SizedBox(height: 60),
          ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SupplierPages()));
              },
              child: const Text('LOGIN (test for supplier)')),
          ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminPages()));
              },
              child: const Text('LOGIN (test for admin)')),
          const SizedBox(height: 30),
          const Text('Don\'t have an account?'),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: const Text('Sign up')),
        ])));
  }
}
