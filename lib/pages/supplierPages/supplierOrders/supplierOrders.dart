import 'package:flutter/material.dart';
import 'package:pavinet/customStyles/customStyles.dart';
import 'package:pavinet/pages/supplierPages/supplierOrders/supplierOrderRequest.dart';
import 'package:pavinet/pages/supplierPages/supplierOrders/supplierOrderStatus.dart';

class SupplierOrders extends StatefulWidget {
  const SupplierOrders({super.key});

  @override
  State<SupplierOrders> createState() => _SupplierOrdersState();
}

class _SupplierOrdersState extends State<SupplierOrders> {
  @override
  Widget build(BuildContext content) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Order Management',
              style: CustomeTextStyle.txtWhiteBold,
            ),
            backgroundColor: Colors.black,
          ),
          body: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                      color: Colors.black,
                      padding: EdgeInsets.fromLTRB(90, 0, 90, 15),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TabBar(
                              dividerColor: Colors.transparent,
                              indicatorColor: Colors.orange[700],
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[700],
                                fontSize: 14.0,
                              ),
                              unselectedLabelStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                              tabs: [
                                Tab(text: 'Request'),
                                Tab(text: 'Status'),
                              ]))),
                  Expanded(
                    child: TabBarView(children: [
                      SupplierOrderRequest(),
                      SupplierOrderStatus()
                    ]),
                  )
                ],
              ))),
    );
  }
}
