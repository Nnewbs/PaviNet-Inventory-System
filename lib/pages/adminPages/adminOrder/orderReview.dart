import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';

class OrderReview extends StatefulWidget {
  const OrderReview({super.key});

  @override
  State<OrderReview> createState() => _OrderReviewState();
}

class _OrderReviewState extends State<OrderReview> {
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

  List<OrderItem> _filteredOrders = [];
  late List<bool> _checked;
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
      _checked = List.generate(_filteredOrders.length, (index) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Order Review', style: CustomeTextStyle.txtWhiteBold),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search (Supplier, Item Name, Status)',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // Order List Header
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Text(
                'Order Requests',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // Orders List
            Expanded(
              child: ListView.builder(
                itemCount: _filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = _filteredOrders[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: isSmallScreen
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CheckboxListTile(
                                value: _checked[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    _checked[index] = value ?? false;
                                  });
                                },
                                title: Text(order.supplier),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Item: ${order.itemName}'),
                                    Text('Quantity: ${order.quantity}'),
                                    StatusIndicator(status: order.status),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          style: TextStyle(fontWeight: FontWeight.w500, color: statusColor),
        ),
      ],
    );
  }
}
