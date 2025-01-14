import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pavinet/customStyles/customStyles.dart';
import 'package:pavinet/Service/auth_service.dart';
import 'package:pavinet/pages/loginPage/loginPage.dart';

class SupplierDetails extends StatefulWidget {
  const SupplierDetails({super.key});

  @override
  State<SupplierDetails> createState() => _SupplierDetailsState();
}

class _SupplierDetailsState extends State<SupplierDetails> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isEditing = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSupplierDetails();
  }

  Future<void> _fetchSupplierDetails() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final docSnapshot =
            await _firestore.collection('users').doc(user.uid).get();

        if (docSnapshot.exists) {
          final data = docSnapshot.data();
          print('Fetched data: $data'); // Debug log

          setState(() {
            _nameController.text = data?['name'] ?? '';
            _companyController.text = data?['company'] ?? '';
            _contactController.text =
                data?['phone'] ?? ''; // Correct field name
            _emailController.text = data?['email'] ?? ''; // Correct field name
          });
        } else {
          print('User document does not exist in Firestore');
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching details: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveDetails() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEditing = false;
      });

      try {
        final user = _auth.currentUser;
        if (user != null) {
          await _firestore.collection('users').doc(user.uid).update({
            'name': _nameController.text.trim(),
            'company': _companyController.text.trim().isEmpty
                ? null
                : _companyController.text.trim(),
            'phone': _contactController.text.trim(),
            'email': _emailController.text.trim(),
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Details saved successfully!')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving details: ${e.toString()}')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Supplier Details', style: CustomeTextStyle.txtWhiteBold),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Logout Confirmation'),
                  content: const Text('Are you sure you want to log out?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.grey)),
                    ),
                    TextButton(
                      onPressed: () async {
                        await _authService.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LogInPage()),
                        );
                      },
                      child: const Text('Log Out',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        enabled: _isEditing,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _companyController,
                        enabled: _isEditing,
                        decoration: const InputDecoration(
                          labelText: 'Company (Optional)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _contactController,
                        enabled: _isEditing,
                        decoration: const InputDecoration(
                          labelText: 'Contact Number',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your contact number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        enabled: _isEditing,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }
                          return null;
                        },
                      ),
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
                            style: CustomButtonStyle.bgButton,
                            child: Text(_isEditing ? 'Save' : 'Edit',
                                style: CustomeTextStyle.txtWhiteBold),
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
                              child: const Text('Cancel',
                                  style: CustomeTextStyle.txtWhiteBold),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
