import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(); // Ensure Firebase is initialized
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supplier Order Request',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SupplierOrderRequest(),
    );
  }
}

class SupplierOrderRequest extends StatefulWidget {
  const SupplierOrderRequest({super.key});

  @override
  State<SupplierOrderRequest> createState() => _SupplierOrderRequestState();
}

class _SupplierOrderRequestState extends State<SupplierOrderRequest> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController requestedQuantityController =
      TextEditingController();
  final TextEditingController notesController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  @override
  void dispose() {
    nameController.dispose();
    itemNameController.dispose();
    categoryController.dispose();
    requestedQuantityController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .timeout(const Duration(seconds: 10));

        if (userDoc.exists) {
          if (mounted) {
            setState(() {
              nameController.text =
                  userDoc.data()?['name'] ?? 'Default Supplier';
            });
          }
        } else {
          if (mounted) {
            setState(() {
              nameController.text = 'Default Supplier';
            });
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user is logged in')),
          );
        }
      }
    } catch (e) {
      debugPrint('Error fetching user name: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch user name: ${e.toString()}')),
        );
        setState(() {
          nameController.text = 'Default Supplier';
        });
      }
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      debugPrint('Form validation failed.');
      return;
    }

    final bool shouldSubmit = await _showConfirmationDialog();
    if (!shouldSubmit) {
      debugPrint('User canceled the submission.');
      return;
    }

    setState(() => _isLoading = true);

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('You must be logged in to submit the order.')),
        );
      }
      return;
    }

    final supplierData = {
      'supplierName': nameController.text,
      'itemName': itemNameController.text,
      'category': categoryController.text.isNotEmpty
          ? categoryController.text
          : 'Default Category',
      'requestedQuantity': int.tryParse(requestedQuantityController.text) ?? 0,
      'notes': notesController.text.isNotEmpty
          ? notesController.text
          : 'No notes provided',
      'status': 'Pending',
      'createdAt': DateTime.now(),
      'userId': user.uid,
    };

    try {
      await FirebaseFirestore.instance
          .collection('supplierOrders')
          .add(supplierData)
          .timeout(const Duration(seconds: 10));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order submitted successfully!')),
        );

        // Clear fields after successful submission
        itemNameController.clear();
        categoryController.clear();
        requestedQuantityController.clear();
        notesController.clear();

        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Order Submitted'),
            content: const Text(
              'Your order has been submitted and will appear in the review list.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      debugPrint('Error during submission: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit order: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<bool> _showConfirmationDialog() async {
    if (!mounted) return false;

    return (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Order Submission'),
            content: const Text('Are you sure you want to submit the order?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Supplier Order Request')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildInputField(
                  label: 'Supplier Name',
                  controller: nameController,
                  readOnly: true,
                ),
                _buildInputField(
                  label: 'Item Name (Required)',
                  controller: itemNameController,
                  validator: (value) =>
                      value!.isEmpty ? 'Item Name is required' : null,
                ),
                _buildInputField(
                  label: 'Category',
                  controller: categoryController,
                ),
                _buildInputField(
                  label: 'Requested Quantity (Required)',
                  controller: requestedQuantityController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) return 'Quantity is required';
                    if (int.tryParse(value) == null) {
                      return 'Enter a valid number';
                    }
                    return null;
                  },
                ),
                _buildNotesField(),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Create New Order'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildNotesField() {
    return TextFormField(
      controller: notesController,
      maxLines: 4,
      decoration: const InputDecoration(
        labelText: 'Notes',
        border: OutlineInputBorder(),
      ),
    );
  }
}
