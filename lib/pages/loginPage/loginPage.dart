import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';
import 'package:pavinet/pages/adminPages/adminPages.dart';
import 'package:pavinet/pages/signupPage/signupPage.dart';
import 'package:pavinet/pages/supplierPages/supplierPages.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext content) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          const Text('LOGIN',
              style: CustomeTextStyle.SignUpLogin, textAlign: TextAlign.center),
          const Text('Please sign in to continue.',
              style: CustomeTextStyle.txtGrey),
          const SizedBox(height: 30),
          const Text(
            'textfields...',
            style: CustomeTextStyle.txtGrey,
          ),
          const SizedBox(height: 60),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SupplierPages()));
            },
            child: const Text('test login to supplier dashboard',
                style: CustomeTextStyle.accentBold),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminPages()));
            },
            child: const Text('test login to admin dashboard',
                style: CustomeTextStyle.accentBold),
          ),
          ElevatedButton(
              style: CustomButtonStyle.button1,
              onPressed: () {
                print("TO DASHBOARD FROM LOGIN");
              },
              child: const Text(
                'LOG IN',
                style: CustomeTextStyle.txtWhiteBold,
              )),
          const SizedBox(height: 30),
          const Text('Don\'t have an account?',
              style: (CustomeTextStyle.txtWhiteBold)),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: const Text('Sign up', style: CustomeTextStyle.accentBold),
          ),
        ])));
  }
}
