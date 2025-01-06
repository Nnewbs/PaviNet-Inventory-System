import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pavinet/customStyles/customStyles.dart';

class SupplierOrderRequest extends StatefulWidget {
  const SupplierOrderRequest({super.key});

  @override
  State<SupplierOrderRequest> createState() => _OrderRequestState();
}

class _OrderRequestState extends State<SupplierOrderRequest> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController requestedQuantityController =
      TextEditingController();
  final TextEditingController unitTypeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext content) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Supplier Information
            _buildSectionTitle('Supplier Information'),
            _buildInputField('Name', nameController),
            _buildInputField('Phone Number', phoneController,
                keyboardType: TextInputType.phone),

            // Item Details
            const SizedBox(height: 16),
            _buildSectionTitle('Item Details'),
            _buildInputField('Item Name', itemNameController),
            _buildInputField('Category', categoryController),

            // Quantity Section
            const SizedBox(height: 16),
            _buildSectionTitle('Quantity'),
            _buildInputField('Requested Quantity', requestedQuantityController,
                keyboardType: TextInputType.number),
            _buildInputField('Unit Type', unitTypeController),

            // Notes
            const SizedBox(height: 16),
            _buildSectionTitle('Notes'),
            _buildNotesField(),

            // Submit Button
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: CustomButtonStyle.bgButton,
                onPressed: _submitForm,
                child: const Text(
                  'CREATE NEW',
                  style: CustomeTextStyle.txtWhiteBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Methods
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesField() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: notesController,
        maxLines: 4,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _supplierOrderRequests = [];

// Use it to store supplier order data after submission
  void _submitForm() async {
    final supplierData = {
      'supplierName': nameController.text,
      'phoneNumber': phoneController.text,
      'itemName': itemNameController.text,
      'category': categoryController.text,
      'requestedQuantity': requestedQuantityController.text,
      'unitType': unitTypeController.text,
      'notes': notesController.text,
      'createdAt': DateTime.now().toIso8601String(),
    };

    try {
      await FirebaseFirestore.instance
          .collection('supplierOrders')
          .add(supplierData);

      if (!mounted) return;

      // Update the contents of the list
      setState(() {
        _supplierOrderRequests.add(supplierData);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order submitted successfully')),
      );

      // Clear form fields
      nameController.clear();
      phoneController.clear();
      itemNameController.clear();
      categoryController.clear();
      requestedQuantityController.clear();
      unitTypeController.clear();
      notesController.clear();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit order: $e')),
      );
    }
  }
}
