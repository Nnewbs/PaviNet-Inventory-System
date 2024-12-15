import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';
import '../signupPage/signupPage.dart';
import '../loginPage/loginPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext content) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          const Text(
            'PAVI NET',
            style: CustomeTextStyle.nameOfAppStyle,
          ),
          const SizedBox(height: 15),
          const Text(
            'Effortless Inventory Management.',
            style: TextStyle(color: Colors.grey),
          ),
          const Text(
            'Anytime.',
            style: TextStyle(color: Colors.grey),
          ),
          const Text('Anywhere.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center),
          const SizedBox(height: 60),
          IntrinsicWidth(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                  style: CustomButtonStyle.bgButton,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: const Text(
                    'SIGN UP',
                    style: CustomeTextStyle.txtWhiteBold,
                  )),
              const SizedBox(height: 30),
              ElevatedButton(
                  style: CustomButtonStyle.bgButton,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogInPage()));
                  },
                  child: const Text(
                    'LOG IN',
                    style: CustomeTextStyle.txtWhiteBold,
                  )),
            ],
          ))
        ])));
  }
}
