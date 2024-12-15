import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';
import 'package:pavinet/pages/loginPage/loginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
          const SizedBox(height: 35),

          // Restricting width of text fields
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Column(
              children: [
                // Name TextField
                TextField(
                  controller: nameController,
                  decoration: CustomTextFieldStyle.textFieldDecoration.copyWith(
                    hintText: 'NAME',
                  ),
                ),
                const SizedBox(height: 15),

                // Username TextField
                TextField(
                  controller: usernameController,
                  decoration: CustomTextFieldStyle.textFieldDecoration.copyWith(
                    hintText: 'USERNAME',
                  ),
                ),
                const SizedBox(height: 15),

                // Phone Number TextField
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: CustomTextFieldStyle.textFieldDecoration.copyWith(
                    hintText: 'PHONE NUMBER',
                  ),
                ),
                const SizedBox(height: 15),

                // Password TextField
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: CustomTextFieldStyle.textFieldDecoration.copyWith(
                    hintText: 'PASSWORD',
                  ),
                ),
                const SizedBox(height: 15),

                // Confirm Password TextField
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: CustomTextFieldStyle.textFieldDecoration.copyWith(
                    hintText: 'CONFIRM PASSWORD',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          ElevatedButton(
              style: CustomButtonStyle.bgButton,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogInPage()));
              },
              child: const Text(
                'SIGN UP',
                style: CustomeTextStyle.txtWhiteBold,
              )),
          const SizedBox(height: 20),
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
