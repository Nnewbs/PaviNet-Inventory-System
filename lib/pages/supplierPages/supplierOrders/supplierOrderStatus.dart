import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupplierOrderStatus extends StatefulWidget {
  const SupplierOrderStatus({Key? key}) : super(key: key);

  @override
  State<SupplierOrderStatus> createState() => _SupplierOrderStatusState();
}

class _SupplierOrderStatusState extends State<SupplierOrderStatus> {
  final List<OrderItem> _allOrders = [];
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  final List<String> _statusFilters = [
    'All',
    'Pending',
    'Approved',
    'Rejected'
  ];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
    _searchController.addListener(_filterOrders);
  }

  void _fetchOrders() {
    FirebaseFirestore.instance
        .collection('supplierOrders')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        _allOrders.clear();
        for (var doc in snapshot.docs) {
          final data = doc.data();
          _allOrders.add(OrderItem(
            id: doc.id,
            supplier: data['supplierName'] ?? 'Unknown',
            itemName: data['itemName'] ?? 'Unknown',
            quantity:
                '${data['requestedQuantity'] ?? 0} ${data['unitType'] ?? ''}',
            status: data['status'] ?? 'Pending',
          ));
        }
      });
    });
  }

  void _filterOrders() {
    setState(() {
      // Filtering happens in the ListView dynamically
    });
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
            child: ListView.builder(
              itemCount: _allOrders.length,
              itemBuilder: (context, index) {
                final order = _allOrders[index];
                if (_selectedFilter != 'All' &&
                    order.status != _selectedFilter) {
                  return const SizedBox.shrink();
                }
                if (_searchController.text.isNotEmpty &&
                    !order.itemName.toLowerCase().contains(
                          _searchController.text.toLowerCase(),
                        ) &&
                    !order.supplier.toLowerCase().contains(
                          _searchController.text.toLowerCase(),
                        )) {
                  return const SizedBox.shrink();
                }
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
