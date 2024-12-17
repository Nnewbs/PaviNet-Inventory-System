import 'package:flutter/material.dart';

class OrderReview extends StatefulWidget {
  const OrderReview({super.key});

  @override
  State<OrderReview> createState() => _OrderReviewState();
}

class _OrderReviewState extends State<OrderReview> {
  // Original order list
  final List<OrderItem> _allOrders = [
    OrderItem(
        supplier: 'Lina',
        itemName: 'Cake',
        quantity: '2 ea',
        status: 'Approved'),
    OrderItem(
        supplier: 'Lina',
        itemName: 'Cake',
        quantity: '2 ea',
        status: 'Pending'),
    OrderItem(
        supplier: 'Lina',
        itemName: 'Cake',
        quantity: '2 ea',
        status: 'Rejected'),
    OrderItem(
        supplier: 'Mina',
        itemName: 'Bread',
        quantity: '5 ea',
        status: 'Approved'),
    OrderItem(
        supplier: 'Tina',
        itemName: 'Cookies',
        quantity: '10 ea',
        status: 'Rejected'),
  ];

  // Filtered list for display
  List<OrderItem> _filteredOrders = [];

  // Checkbox states for all orders
  late List<bool> _checked;

  // Search controller
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredOrders = List.from(_allOrders);
    _checked = List.generate(_allOrders.length, (index) => false);
    _searchController.addListener(_filterOrders);
  }

  void _filterOrders() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredOrders = _allOrders.where((order) {
        return order.supplier.toLowerCase().contains(query) ||
            order.itemName.toLowerCase().contains(query) ||
            order.status.toLowerCase().contains(query);
      }).toList();
    });
    // Resize the checkbox state list when filtered
    _checked = List.generate(_filteredOrders.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Order Review'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Supplier / Item Name / Status',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // Order Request Header
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Text(
                'Order Request',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Table Header
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 24), // Checkbox spacing
                  Expanded(
                      flex: 1,
                      child: Text('Supplier',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 1,
                      child: Text('Item Name',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 1,
                      child: Text('Quantity',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 1,
                      child: Text('Status',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),

            // Orders List
            Expanded(
              child: ListView.builder(
                itemCount: _filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = _filteredOrders[index];
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Checkbox(
                          value: _checked[index],
                          onChanged: (bool? value) {
                            setState(() {
                              _checked[index] = value ?? false;
                            });
                          },
                        ),
                        Expanded(flex: 1, child: Text(order.supplier)),
                        Expanded(flex: 1, child: Text(order.itemName)),
                        Expanded(flex: 1, child: Text(order.quantity)),
                        Expanded(
                            flex: 1,
                            child: StatusIndicator(status: order.status)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Data model for Order Item
class OrderItem {
  final String supplier;
  final String itemName;
  final String quantity;
  final String status;

  OrderItem({
    required this.supplier,
    required this.itemName,
    required this.quantity,
    required this.status,
  });
}

// Widget for Status Indicator
class StatusIndicator extends StatelessWidget {
  final String status;

  const StatusIndicator({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status) {
      case 'Approved':
        statusColor = Colors.green;
        break;
      case 'Pending':
        statusColor = Colors.orange;
        break;
      case 'Rejected':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            color: statusColor,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          status,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: statusColor,
          ),
        ),
      ],
    );
  }
}
