import 'package:flutter/material.dart'; 
import 'package:pavinet/customStyles/customStyles.dart';
import 'package:pavinet/pages/adminPages/adminPages.dart';
import 'package:pavinet/pages/loginPage/loginPage.dart';
import 'package:pavinet/pages/supplierPages/supplierPages.dart';
import 'package:pavinet/Service/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final AuthService _authService = AuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String selectedRole = "User";
  bool _isLoading = false;
  bool isPasswordHidden = true;

  final List<String> roles = ["User", "Admin", "Supplier"];

  void _signup() async {
    setState(() {
      _isLoading = true;
    });

    String? result = await _authService.signup(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      password: passwordController.text,
      role: selectedRole,
    );

    setState(() {
      _isLoading = false;
    });

    if (result == 'Success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => selectedRole == 'Admin'
              ? AdminPages()
              : selectedRole == 'Supplier'
                  ? SupplierPages()
                  : LogInPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result ?? 'Signup failed. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 350),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'SIGN UP',
                      style: CustomeTextStyle.SignUpLogin,
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'Create an account.',
                      style: CustomeTextStyle.txtGrey,
                    ),
                    const SizedBox(height: 35),
                    TextField(
                      controller: nameController,
                      decoration:
                          CustomTextFieldStyle.textFieldDecoration.copyWith(
                        hintText: 'NAME',
                        prefixIcon:
                            const Icon(Icons.person, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: emailController,
                      decoration:
                          CustomTextFieldStyle.textFieldDecoration.copyWith(
                        hintText: 'EMAIL',
                        prefixIcon: const Icon(Icons.email, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration:
                          CustomTextFieldStyle.textFieldDecoration.copyWith(
                        hintText: 'PHONE NUMBER',
                        prefixIcon: const Icon(Icons.phone, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      obscureText: isPasswordHidden,
                      decoration:
                          CustomTextFieldStyle.textFieldDecoration.copyWith(
                        hintText: 'PASSWORD',
                        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordHidden = !isPasswordHidden;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: isPasswordHidden,
                      decoration:
                          CustomTextFieldStyle.textFieldDecoration.copyWith(
                        hintText: 'CONFIRM PASSWORD',
                        prefixIcon:
                            const Icon(Icons.lock_outline, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      items: roles.map((role) {
                        return DropdownMenuItem(
                          value: role,
                          child: Text(role, style: CustomeTextStyle.txtGrey),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value!;
                        });
                      },
                      decoration:
                          CustomTextFieldStyle.textFieldDecoration.copyWith(
                        hintText: 'ROLE',
                      ),
                    ),
                    const SizedBox(height: 20),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            style: CustomButtonStyle.bgButton,
                            onPressed: _signup,
                            child: const Text(
                              'SIGN UP',
                              style: CustomeTextStyle.txtWhiteBold,
                            ),
                          ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?",
                            style: CustomeTextStyle.txtGrey),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => LogInPage()),
                            );
                          },
                          child: const Text(
                            'Log In',
                            style: CustomeTextStyle.accentBold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
