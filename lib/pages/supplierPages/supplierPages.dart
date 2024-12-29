import 'package:flutter/material.dart';
import 'package:pavinet/pages/supplierPages/supplierHome/supplierHomePage.dart';
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
    SupplierHome(),
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
        appBar: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 0,
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
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_outlined),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.orange[700],
            onTap: _onItemTapped,
          ),
        ));
  }
}
