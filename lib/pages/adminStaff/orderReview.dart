import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pavinet/customStyles/customStyles.dart';

class OrderReview extends StatefulWidget {
  const OrderReview({super.key});

  @override
  State<OrderReview> createState() => _OrderReviewState();
}

class _OrderReviewState extends State<OrderReview> {
  final List<OrderItem> _allOrders = [];
  List<OrderItem> _filteredOrders = [];
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'All';
  final List<String> _statusFilters = [
    'All',
    'Pending',
    'Approved',
    'Rejected'
  ];

  @override
  void initState() {
    super.initState();
    _setupOrdersListener();
    _searchController.addListener(_filterOrders);
  }

  void _setupOrdersListener() {
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
            userId: data['userId'] ?? '',
            timestamp:
                (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
          ));
        }
        _filterOrders();
      });
    });
  }

  void _filterOrders() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredOrders = _allOrders.where((order) {
        final matchesSearch = order.itemName.toLowerCase().contains(query) ||
            order.supplier.toLowerCase().contains(query);
        final matchesStatus =
            _selectedStatus == 'All' || order.status == _selectedStatus;
        return matchesSearch && matchesStatus;
      }).toList();

      // Sort by timestamp, newest first
      _filteredOrders.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });
  }

  Future<void> _updateOrderStatus(String orderId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('supplierOrders')
          .doc(orderId)
          .update({
        'status': newStatus,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order status updated to $newStatus')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating status: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Order Review',
          style: CustomeTextStyle.txtWhiteBold,
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false, // Removes the back button icon
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by item name or supplier',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: InputDecoration(
                    labelText: 'Filter by Status',
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: _statusFilters.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value!;
                      _filterOrders();
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredOrders.isEmpty
                ? const Center(child: Text('No orders found'))
                : ListView.builder(
                    itemCount: _filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = _filteredOrders[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        color: Colors.grey.shade200,
                        child: ListTile(
                          leading: _buildStatusIndicator(order.status),
                          title: Text(
                            order.itemName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text('Supplier: ${order.supplier}'),
                              Text('Quantity: ${order.quantity}'),
                              Text(
                                'Order Date: ${order.timestamp.toLocal().toString().split('.')[0]}',
                              ),
                            ],
                          ),
                          trailing: DropdownButton<String>(
                            value: order.status,
                            items: ['Pending', 'Approved', 'Rejected']
                                .map((String status) {
                              return DropdownMenuItem<String>(
                                value: status,
                                child: Text(status),
                              );
                            }).toList(),
                            onChanged: (String? newStatus) {
                              if (newStatus != null) {
                                _updateOrderStatus(order.id, newStatus);
                              }
                            },
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
  final String userId;
  final DateTime timestamp;

  OrderItem({
    required this.id,
    required this.supplier,
    required this.itemName,
    required this.quantity,
    required this.status,
    required this.userId,
    required this.timestamp,
  });
}
