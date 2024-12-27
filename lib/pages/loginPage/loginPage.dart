import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';
import 'package:pavinet/pages/adminPages/adminPages.dart';
import 'package:pavinet/pages/signupPage/signupPage.dart';
import 'package:pavinet/pages/supplierPages/supplierPages.dart';
import 'package:pavinet/Service/auth_service.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  LogInPageState createState() => LogInPageState();
}

class LogInPageState extends State<LogInPage> {
  final AuthService _authService = AuthService(); // Instance of AuthService
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool isPasswordHidden = true;

  // Login function to handle user authentication
  void _login() async {
    setState(() {
      _isLoading = true; // Show spinner
    });

    String? result = await _authService.login(
      email: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      _isLoading = false; // Hide spinner
    });

    if (result == 'Admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AdminPages()),
      );
    } else if (result == 'User') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AdminPages()),
      );
    } else if (result == 'Supplier') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SupplierPages()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login Failed: $result'), // Show error message
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('LOGIN',
                    style: CustomeTextStyle.SignUpLogin,
                    textAlign: TextAlign.center),
                const Text('Please sign in to continue.',
                    style: CustomeTextStyle.txtGrey),
                const SizedBox(height: 40),

                // USERNAME TextField
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: emailController,
                    decoration:
                        CustomTextFieldStyle.textFieldDecoration.copyWith(
                      hintText: 'EMAIL',
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // PASSWORD TextField
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: passwordController,
                    obscureText: isPasswordHidden,
                    decoration:
                        CustomTextFieldStyle.textFieldDecoration.copyWith(
                      hintText: 'PASSWORD',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        },
                        icon: Icon(
                          isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Login Button or Loading Indicator
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: CustomButtonStyle.bgButton,
                        onPressed: _login, // Call login function
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
                  child:
                      const Text('Sign up', style: CustomeTextStyle.accentBold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
