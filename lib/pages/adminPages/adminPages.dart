import 'package:flutter/material.dart';
import 'package:pavinet/pages/adminPages/adminAccount/accountReview.dart';
import 'package:pavinet/pages/adminPages/adminHome/adminHomePage.dart';
import 'package:pavinet/pages/adminStaff/orderReview.dart';
import 'package:pavinet/pages/adminStaff/productDetails.dart';
import 'package:pavinet/pages/adminStaff/category.dart';
import 'package:pavinet/pages/loginPage/loginPage.dart';

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
    OrderReview(),
    ProductDetails(),
    Category(),
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
      adminName = "Admin"; // Replace with fetched value
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
            const Text(''),
            Row(
              children: [
                Text(
                  adminName,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Logout Confirmation'),
                      content: const Text('Are you sure you want to log out?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const LogInPage(), // Navigate to LoginScreen
                              ),
                            );
                          },
                          child: const Text('Log Out',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
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
                icon: Icon(Icons.shopping_bag), label: 'Order'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box), label: 'Product'),
            BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Category'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_remove), label: 'Account'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange[700],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
