import 'package:flutter/material.dart';
import 'package:pavinet/pages/adminPages/adminAccount/accountReview.dart';
import 'package:pavinet/pages/adminPages/adminCategory/categoryPage.dart';
import 'package:pavinet/pages/adminPages/adminDashboard/adminHome.dart';
import 'package:pavinet/pages/adminPages/adminOrder/orderReview.dart';
import 'package:pavinet/pages/adminPages/productDetails/productDetails.dart';

class AdminPages extends StatefulWidget {
  const AdminPages({super.key});

  @override
  State<AdminPages> createState() => _AdminPagesState();
}

class _AdminPagesState extends State<AdminPages> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    AdminHome(),
    ProductDetails(),
    OrderReview(),
    CategoryPage(),
    AccountReview()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext content) {
    return Scaffold(
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
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.details),
                label: 'Product',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag),
                label: 'Order',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box),
                label: 'Account',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.orange[700],
            onTap: _onItemTapped,
          ),
        ));
  }
}
