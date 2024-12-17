import 'package:flutter/material.dart';

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
  final TextEditingController requestedQuantityController = TextEditingController();
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: _submitForm,
                child: const Text('CREATE NEW'),
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

  void _submitForm() {
    print('Supplier Name: ${nameController.text}');
    print('Phone Number: ${phoneController.text}');
    print('Item Name: ${itemNameController.text}');
    print('Category: ${categoryController.text}');
    print('Requested Quantity: ${requestedQuantityController.text}');
    print('Unit Type: ${unitTypeController.text}');
    print('Notes: ${notesController.text}');
  }
}