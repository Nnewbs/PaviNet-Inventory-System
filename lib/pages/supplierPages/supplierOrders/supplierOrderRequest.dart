import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supplier Order Request',
      theme: ThemeData(primarySwatch: Colors.blue),
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
            .get();

        if (userDoc.exists) {
          setState(() {
            nameController.text = userDoc.data()?['name'] ?? 'Default Supplier';
          });
        } else {
          nameController.text = 'Default Supplier';
        }
      } else {
        nameController.text = 'Guest';
      }
    } catch (e) {
      debugPrint('Error fetching user name: $e');
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final supplierData = {
      'supplierName': nameController.text,
      'itemName': itemNameController.text,
      'category': categoryController.text,
      'requestedQuantity': int.tryParse(requestedQuantityController.text) ?? 0,
      'notes': notesController.text,
      'status': 'Pending',
      'createdAt': DateTime.now(),
    };

    try {
      await FirebaseFirestore.instance
          .collection('supplierOrders')
          .add(supplierData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order submitted successfully!')),
      );
      _clearForm();
    } catch (e) {
      debugPrint('Error submitting order: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit order.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _clearForm() {
    itemNameController.clear();
    categoryController.clear();
    requestedQuantityController.clear();
    notesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Supplier Order Request')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Supplier Name'),
              ),
              TextFormField(
                controller: itemNameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Item name is required'
                    : null,
              ),
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              TextFormField(
                controller: requestedQuantityController,
                decoration:
                    const InputDecoration(labelText: 'Requested Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Quantity is required';
                  if (int.tryParse(value) == null)
                    return 'Enter a valid number';
                  return null;
                },
              ),
              TextFormField(
                controller: notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Submit Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
