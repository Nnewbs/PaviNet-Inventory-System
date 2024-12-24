import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // Controllers for form fields
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController stockQuantityController = TextEditingController();

  // Dropdown options for Category Type and Vendor
  final List<String> typeOptions = ['Food', 'Drinks', 'Snacks'];
  final List<String> vendorOptions = ['Vendor 1', 'Vendor 2', 'Vendor 3'];

  String? selectedType;
  String? selectedVendor;

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
  void handleAdd() {
    if (_formKey.currentState!.validate()) {
      showSuccessPrompt("added");
      // Clear fields after success
      productNameController.clear();
      descriptionController.clear();
      stockQuantityController.clear();
      setState(() {
        selectedType = null;
        selectedVendor = null;
      });
    }
  }

  // Update button action
  void handleUpdate() {
    if (_formKey.currentState!.validate()) {
      showSuccessPrompt("updated");
    }
  }

  // Delete button action
  void handleDelete() {
    showSuccessPrompt("deleted");
    // Clear fields after delete
    productNameController.clear();
    descriptionController.clear();
    stockQuantityController.clear();
    setState(() {
      selectedType = null;
      selectedVendor = null;
    });
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
                // Image Placeholder
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: const Center(
                      child: Text(
                        'Drop Image',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                // Description Field
                const Text("Description :"),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
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
                // Vendor Dropdown
                DropdownButtonFormField<String>(
                  value: selectedVendor,
                  items: vendorOptions.map((vendor) {
                    return DropdownMenuItem(
                      value: vendor,
                      child: Text(vendor),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedVendor = value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'VENDOR',
                  ),
                  validator: (value) {
                    if (value == null) return 'Please select a vendor';
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
                const SizedBox(height: 25),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
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
