import 'package:flutter/material.dart';
import 'package:pavinet/pages/supplierPages/supplierDashboard/supplierChat.dart';
import 'package:pavinet/pages/supplierPages/supplierDashboard/supplierHistory.dart';
import 'package:pavinet/pages/supplierPages/supplierDashboard/supplierMain.dart';

class SupplierDashboard extends StatefulWidget {
  const SupplierDashboard({super.key});

  @override
  State<SupplierDashboard> createState() => _SupplierDashboardState();
}

class _SupplierDashboardState extends State<SupplierDashboard> {
  @override
  Widget build(BuildContext content) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Dashboard'),
          ),
          body: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Container(
                    child: TabBar(
                        labelColor: Colors.brown,
                        unselectedLabelColor: Colors.black,
                        indicatorColor: Colors.brown,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial',
                          fontSize: 20.0,
                        ),
                        tabs: [
                          Tab(text: 'Main'),
                          Tab(text: 'Chat'),
                          Tab(text: 'History')
                        ]),
                  ),
                  Expanded(
                      child: Container(
                    child: TabBarView(children: [
                      Container(
                        child: SupplierMain(),
                      ),
                      Container(
                        child: SupplierChat(),
                      ),
                      Container(
                        child: SupplierHistory(),
                      )
                    ]),
                  ))
                ],
              ))),
    );
  }
}
