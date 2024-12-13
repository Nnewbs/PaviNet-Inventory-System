import 'package:flutter/material.dart';
import 'package:pavinet/pages/loginPage/login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext content) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
          const Text('SIGN UP'),
          const Text('Create an account.'),
          const Text('textfield...'),
          const SizedBox(height: 60),
          ElevatedButton(
              style: style,
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const SignUpPage()));
              },
              child: const Text('SIGN UP')),
          const SizedBox(height: 30),
          const Text('Already have account?'),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInPage()));
              },
              child: const Text('Log in')),
        ])));
  }
}
