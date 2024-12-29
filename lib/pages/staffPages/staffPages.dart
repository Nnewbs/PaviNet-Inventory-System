import 'package:flutter/material.dart';
import 'package:pavinet/pages/adminStaff/orderReview.dart';
import 'package:pavinet/pages/adminStaff/productDetails.dart';
import 'package:pavinet/pages/staffPages/staffProfile.dart';
import 'package:pavinet/pages/adminStaff/category.dart';
import 'package:pavinet/pages/staffPages/staffHome/staffHomePage.dart';

class StaffPages extends StatefulWidget {
  const StaffPages({super.key});

  @override
  State<StaffPages> createState() => _StaffPagesState();
}

class _StaffPagesState extends State<StaffPages> {
  int _selectedIndex = 0;
  String adminName = "Loading..."; // Placeholder for admin name

  static const List<Widget> _widgetOptions = <Widget>[
    StaffHome(),
    OrderReview(),
    ProductDetails(),
    Category(),
  ];

  @override
  void initState() {
    super.initState();
    _fetchAdminName();
  }

  void _fetchAdminName() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    setState(() {
      adminName = "Staff"; // Replace with fetched value
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
                        builder: (context) => const StaffProfile(),
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
                icon: Icon(Icons.shopping_bag), label: 'Order'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box), label: 'Product'),
            BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Category'),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.person_remove), label: 'Account'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange[700],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
