import 'package:flutter/material.dart';
import 'package:pavinet/pages/supplierPages/supplierDashboard/supplierDashboard.dart';
import 'package:pavinet/pages/supplierPages/supplierNotification/supplierNotiPage.dart';
import 'package:pavinet/pages/supplierPages/supplierOrders/supplierOrders.dart';
import 'package:pavinet/pages/supplierPages/supplierProfile/supplierDetails.dart';

class SupplierPages extends StatefulWidget {
  const SupplierPages({super.key});

  @override
  State<SupplierPages> createState() => _SupplierPagesState();
}

class _SupplierPagesState extends State<SupplierPages> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    SupplierDashboard(),
    SupplierOrders(),
    SupplierNotiPage(),
    SupplierDetails()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext content) {
    return Scaffold(
      // theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF000000)),
      backgroundColor: Colors.blueGrey.shade200,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        iconSize: 20.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown,
        onTap: _onItemTapped,
      ),
    );
  }
}
