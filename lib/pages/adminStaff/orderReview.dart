import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pavinet/customStyles/customStyles.dart';

class OrderReview extends StatefulWidget {
  const OrderReview({super.key});

  @override
  State<OrderReview> createState() => _OrderReviewState();
}

class _OrderReviewState extends State<OrderReview> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'All';
  final List<String> _statusFilters = [
    'All',
    'Pending',
    'Approved',
    'Rejected'
  ];

  Stream<List<OrderItem>> _fetchOrders() {
    return FirebaseFirestore.instance
        .collection('supplierOrders')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return OrderItem(
          id: doc.id,
          supplier: data['supplierName'] ?? 'Unknown',
          itemName: data['itemName'] ?? 'Unknown',
          quantity: '${data['requestedQuantity'] ?? 0}',
          status: data['status'] ?? 'Pending',
        );
      }).toList();
    });
  }

  Future<void> _updateOrderStatus(String orderId, String newStatus) async {
    await FirebaseFirestore.instance
        .collection('supplierOrders')
        .doc(orderId)
        .update({'status': newStatus});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order status updated to $newStatus')),
    );
  }

  void _showOrderDetails(String orderId) async {
    final doc = await FirebaseFirestore.instance
        .collection('supplierOrders')
        .doc(orderId)
        .get();
    if (doc.exists) {
      final data = doc.data()!;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Order Details'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Supplier Name: ${data['supplierName'] ?? 'N/A'}'),
                  Text('Item Name: ${data['itemName'] ?? 'N/A'}'),
                  Text('Category: ${data['category'] ?? 'N/A'}'),
                  Text(
                      'Requested Quantity: ${data['requestedQuantity'] ?? 'N/A'}'),
                  Text('Notes: ${data['notes'] ?? 'N/A'}'),
                  Text('Status: ${data['status'] ?? 'Pending'}'),
                  Text(
                      'Created At: ${data['createdAt'] != null ? (data['createdAt'] as Timestamp).toDate().toString() : 'N/A'}'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order details not found.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Order Review', style: CustomeTextStyle.txtWhiteBold),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search orders',
                prefixIcon: Icon(Icons.search),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              value: _selectedStatus,
              items: _statusFilters.map((status) {
                return DropdownMenuItem(value: status, child: Text(status));
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedStatus = value!);
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<OrderItem>>(
              stream: _fetchOrders(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();

                final orders = snapshot.data!;
                final filteredOrders = orders.where((order) {
                  final matchesSearch = order.itemName
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()) ||
                      order.supplier
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase());
                  final matchesStatus = _selectedStatus == 'All' ||
                      order.status == _selectedStatus;
                  return matchesSearch && matchesStatus;
                }).toList();

                return ListView.builder(
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      elevation: 4.0,
                      child: ListTile(
                        title: Text(order.itemName,
                            style: const TextStyle(color: Colors.black)),
                        subtitle: Text('Supplier: ${order.supplier}',
                            style: const TextStyle(color: Colors.black)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.info_outline,
                                  color: Colors.blue),
                              onPressed: () => _showOrderDetails(order.id),
                            ),
                            DropdownButton<String>(
                              value: order.status,
                              items: ['Pending', 'Approved', 'Rejected']
                                  .map((status) {
                                return DropdownMenuItem(
                                  value: status,
                                  child: Text(status),
                                );
                              }).toList(),
                              onChanged: (newStatus) =>
                                  _updateOrderStatus(order.id, newStatus!),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderItem {
  final String id;
  final String supplier;
  final String itemName;
  final String quantity;
  final String status;

  OrderItem({
    required this.id,
    required this.supplier,
    required this.itemName,
    required this.quantity,
    required this.status,
  });
}
