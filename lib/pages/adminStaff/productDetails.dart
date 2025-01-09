//Add item to database
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // Controllers for form fields
  final TextEditingController idController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController stockQuantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imagePathController = TextEditingController();
  final TextEditingController vendorController =
      TextEditingController(); // New controller for vendor

  // Dropdown options for Category Type
  final List<String> typeOptions = ['Bakery', 'Prepare', 'Fresh'];

  String? selectedType;

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Success Prompt
  void showSuccessPrompt(String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product $action successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Add button action
  void handleAdd() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Save product details to Firestore
        await FirebaseFirestore.instance.collection("items").add({
          "id": idController.text.trim(),
          "category": selectedType,
          "imagePath": imagePathController.text.trim(),
          "owner": vendorController.text.trim(), // Save the vendor input
          "price": double.parse(priceController.text.trim()),
          "quantity": int.parse(stockQuantityController.text.trim()),
          "title": productNameController.text.trim(),
        });

        showSuccessPrompt("added");

        // Clear fields after success
        idController.clear();
        productNameController.clear();
        stockQuantityController.clear();
        priceController.clear();
        imagePathController.clear();
        vendorController.clear(); // Clear the vendor field
        setState(() {
          selectedType = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add product: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Product Details', style: CustomeTextStyle.txtWhiteBold),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Path Field
                const Text("Image Path :"),
                TextFormField(
                  controller: imagePathController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter image path or URL',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter image path';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                // ID Field
                const Text("ID :"),
                TextFormField(
                  controller: idController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter ID',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter ID';
                    }
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return 'Please enter a valid ID number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                // Product Name Field
                const Text("Product Name :"),
                TextFormField(
                  controller: productNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter product name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                // Category Type Dropdown
                const Text("Category :"),
                DropdownButtonFormField<String>(
                  value: selectedType,
                  items: typeOptions.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'TYPE',
                  ),
                  validator: (value) {
                    if (value == null) return 'Please select a type';
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                // Vendor Field (Replaced dropdown with TextFormField)
                const Text("Vendor :"),
                TextFormField(
                  controller:
                      vendorController, // Using the new controller for vendor
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter vendor name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter vendor name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                // Stock Quantity Field
                const Text("Stock Quantity :"),
                TextFormField(
                  controller: stockQuantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter stock quantity',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter stock quantity';
                    }
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                // Price Field
                const Text("Price :"),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter price',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter price';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                // Add Button
                Center(
                  child: ElevatedButton(
                    onPressed: handleAdd,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      "ADD",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
