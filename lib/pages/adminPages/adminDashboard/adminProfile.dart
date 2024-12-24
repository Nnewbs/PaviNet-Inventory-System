import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';
import 'package:pavinet/Service/auth_service.dart';
import 'package:pavinet/pages/loginPage/loginPage.dart';

final AuthService _authService = AuthService(); // Initialize AuthService

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveDetails() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Details saved successfully!')),
      );
    }
  }

  void _signOut() async {
    await _authService.signOut(); // Call the sign-out method
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signed out successfully!')),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LogInPage(), // Navigate to LoginScreen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Admin Profile', style: CustomeTextStyle.txtWhiteBold),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        actions: [
          IconButton(
            onPressed: _signOut, // Call _signOut on button press
            icon: const Icon(
              Icons.logout,
              color: Colors.white, // Make the icon white
            ),
            tooltip: 'Sign Out',
          ),
        ],
      ),
      backgroundColor: Colors.white, // Set the background color to white
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16),
              _buildTextField(
                  'Name', _nameController, 'Please enter your name'),
              const SizedBox(height: 16),
              _buildTextField('Company', _companyController,
                  'Please enter your company details'),
              const SizedBox(height: 16),
              _buildTextField(
                'Contact Number',
                _contactController,
                'Please enter your contact number',
                TextInputType.phone,
                r'^[0-9]+$',
                'Please enter a valid contact number',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Email Address',
                _emailController,
                'Please enter your email address',
                TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildTextField('Delivery Address', _addressController,
                  'Please enter your delivery address'),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _isEditing
                        ? _saveDetails
                        : () {
                            setState(() {
                              _isEditing = true;
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: Text(_isEditing ? 'Save' : 'Edit'),
                  ),
                  if (_isEditing)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isEditing = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text('Cancel'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String validationMessage, [
    TextInputType keyboardType = TextInputType.text,
    String? validationPattern,
    String? patternMessage,
  ]) {
    return TextFormField(
      controller: controller,
      enabled: _isEditing,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        if (validationPattern != null &&
            !RegExp(validationPattern).hasMatch(value)) {
          return patternMessage;
        }
        return null;
      },
    );
  }
}
