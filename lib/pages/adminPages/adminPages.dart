import 'package:flutter/material.dart';
import 'package:pavinet/pages/adminPages/adminAccount/accountReview.dart';
import 'package:pavinet/pages/adminPages/adminCategory/categoryPage.dart';
import 'package:pavinet/pages/adminPages/adminDashboard/adminHome.dart';
import 'package:pavinet/pages/adminPages/adminOrder/orderReview.dart';
import 'package:pavinet/pages/adminPages/productDetails/productDetails.dart';
import 'package:pavinet/pages/adminPages/adminDashboard/adminProfile.dart';

class AdminPages extends StatefulWidget {
  const AdminPages({super.key});

  @override
  State<AdminPages> createState() => _AdminPagesState();
}

class _AdminPagesState extends State<AdminPages> {
  int _selectedIndex = 0;
  String adminName = "Loading..."; // Placeholder for admin name

  static const List<Widget> _widgetOptions = <Widget>[
    AdminHome(),
    ProductDetails(),
    OrderReview(),
    CategoryPage(),
    AccountReview(),
  ];

  @override
  void initState() {
    super.initState();
    _fetchAdminName();
  }

  void _fetchAdminName() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    setState(() {
      adminName = "Admin John Doe"; // Replace with fetched value
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        toolbarHeight: 40,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            Row(
              children: [
                Text(
                  adminName,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.account_circle, color: Colors.white),
                  onPressed: () {
                    // Navigate to AdminProfile using Navigator.push
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminProfile(),
                      ),
                    );
                  },
                  tooltip: 'Edit Profile',
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: BottomNavigationBar(
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          iconSize: 25.0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.details), label: 'Product'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag), label: 'Order'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Category'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), label: 'Account'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange[700],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
