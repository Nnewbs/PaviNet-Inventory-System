import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';
import 'package:pavinet/pages/loginPage/loginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext content) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          const Text('SIGN UP',
              style: CustomeTextStyle.SignUpLogin, textAlign: TextAlign.center),
          const Text('Create an account.', style: CustomeTextStyle.txtGrey),
          const SizedBox(height: 30),
          const Text(
            'textfields...',
            style: CustomeTextStyle.txtGrey,
          ),
          const SizedBox(height: 60),
          ElevatedButton(
              style: CustomButtonStyle.button1,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInPage()));
              },
              child: const Text(
                'SIGN UP',
                style: CustomeTextStyle.txtWhiteBold,
              )),
          const SizedBox(height: 30),
          const Text('Already have account?',
              style: (CustomeTextStyle.txtWhiteBold)),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LogInPage()));
            },
            child: const Text('Log in', style: CustomeTextStyle.accentBold),
          ),
        ])));
  }
}
