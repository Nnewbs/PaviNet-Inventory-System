import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';

class UpdateDetails extends StatefulWidget {
  final String id;
  final String title;
  final String price;
  final String category;
  final String imagePath;
  final String owner;
  final int quantity;

  const UpdateDetails({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.imagePath,
    required this.owner,
    required this.quantity,
  });

  @override
  State<UpdateDetails> createState() => _UpdateDetailsState();
}

class _UpdateDetailsState extends State<UpdateDetails> {
  // Controllers for form fields
  final TextEditingController idController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController stockQuantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imagePathController = TextEditingController();
  final TextEditingController vendorController = TextEditingController();

  // Dropdown options for Category Type
  final List<String> typeOptions = ['Food', 'Drinks', 'Snacks'];

  String? selectedType;

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the passed item data
    idController.text = widget.id;
    productNameController.text = widget.title;
    priceController.text = widget.price;
    stockQuantityController.text = widget.quantity.toString();
    imagePathController.text = widget.imagePath;
    vendorController.text = widget.owner;
    selectedType = widget.category;
  }

  // Success Prompt
  void showSuccessPrompt(String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product $action successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Update button action
  void handleUpdate() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Update product details in Firestore
        await FirebaseFirestore.instance
            .collection("items")
            .doc(widget.id)
            .update({
          "category": selectedType,
          "imagePath": imagePathController.text.trim(),
          "owner": vendorController.text.trim(),
          "price": double.parse(priceController.text.trim()),
          "quantity": int.parse(stockQuantityController.text.trim()),
          "title": productNameController.text.trim(),
        });

        showSuccessPrompt("updated");
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update product: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Delete button action
  void handleDelete() async {
    try {
      // Delete product from Firestore
      await FirebaseFirestore.instance
          .collection("items")
          .doc(widget.id)
          .delete();

      showSuccessPrompt("deleted");
      Navigator.pop(context); // Navigate back after successful deletion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete product: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Update Product Details',
              style: CustomeTextStyle.txtWhiteBold),
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
                  readOnly: true,
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
                    hintText: 'Select category',
                  ),
                  validator: (value) {
                    if (value == null) return 'Please select a category';
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                // Vendor Field
                const Text("Vendor :"),
                TextFormField(
                  controller: vendorController,
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
                // Update and Delete Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: handleUpdate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        "UPDATE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: handleDelete,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        "DELETE",
                        style: TextStyle(color: Colors.white),
                      ),
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
