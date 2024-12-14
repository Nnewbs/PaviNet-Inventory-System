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
            child: IntrinsicWidth(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
          const Text('PAVI NET',
              style: CustomeTextStyle.nameOfAppStyle,
              textAlign: TextAlign.center),
          const SizedBox(height: 15),
          const Text('Effortless Inventory Management.',
              style: CustomeTextStyle.txtGrey, textAlign: TextAlign.center),
          const Text('Anytime.',
              style: CustomeTextStyle.txtGrey, textAlign: TextAlign.center),
          const Text('Anywhere.',
              style: CustomeTextStyle.txtGrey, textAlign: TextAlign.center),
          const SizedBox(height: 60),
          ElevatedButton(
              style: CustomButtonStyle.button1,
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
              style: CustomButtonStyle.button1,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInPage()));
              },
              child: const Text(
                'LOG IN',
                style: CustomeTextStyle.txtWhiteBold,
              )),
        ]))));
  }
}
