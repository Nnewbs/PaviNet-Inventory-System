import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupplierOrderStatus extends StatefulWidget {
  const SupplierOrderStatus({super.key});

  @override
  State<SupplierOrderStatus> createState() => _SupplierOrderStatusState();
}

class _SupplierOrderStatusState extends State<SupplierOrderStatus> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  final List<String> _statusFilters = [
    'All',
    'Pending',
    'Approved',
    'Rejected'
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplier Order Status'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by item or supplier name...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (_) {
                      setState(() {}); // Triggers filtering
                    },
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: _selectedFilter,
                  items: _statusFilters.map((filter) {
                    return DropdownMenuItem<String>(
                      value: filter,
                      child: Text(filter),
                    );
                  }).toList(),
                  onChanged: (String? newFilter) {
                    if (newFilter != null) {
                      setState(() {
                        _selectedFilter = newFilter;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('supplierOrders')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final orders = snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return OrderItem(
                    id: doc.id,
                    supplier: data['supplierName'] ?? 'Unknown',
                    itemName: data['itemName'] ?? 'Unknown',
                    quantity:
                        '${data['requestedQuantity'] ?? 0} ${data['unitType'] ?? ''}',
                    status: data['status'] ?? 'Pending',
                  );
                }).toList();

                // Apply filtering
                final filteredOrders = orders.where((order) {
                  final matchesStatus = _selectedFilter == 'All' ||
                      order.status == _selectedFilter;
                  final matchesSearch = _searchController.text.isEmpty ||
                      order.itemName.toLowerCase().contains(
                            _searchController.text.toLowerCase(),
                          ) ||
                      order.supplier.toLowerCase().contains(
                            _searchController.text.toLowerCase(),
                          );
                  return matchesStatus && matchesSearch;
                }).toList();

                if (filteredOrders.isEmpty) {
                  return const Center(child: Text('No orders found.'));
                }

                return ListView.builder(
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: ListTile(
                        leading: _buildStatusIndicator(order.status),
                        title: Text(order.itemName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Supplier: ${order.supplier}'),
                            Text('Quantity: ${order.quantity}'),
                            Text('Status: ${order.status}'),
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

  Widget _buildStatusIndicator(String status) {
    Color color;
    switch (status) {
      case 'Approved':
        color = Colors.blue;
        break;
      case 'Pending':
        color = Colors.yellow;
        break;
      case 'Rejected':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
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
