import 'package:flutter/material.dart';
import 'package:pavinet/pages/supplierPages/supplierOrders/orderRequest.dart';
import 'package:pavinet/pages/supplierPages/supplierOrders/orderStatus.dart';

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
          appBar: AppBar(centerTitle: true, title: Text('Order Management')),
          body: DefaultTabController(
              length: 2,
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
                            fontSize: 20.0),
                        tabs: [
                          Tab(text: 'Request'),
                          Tab(text: 'Status'),
                        ]),
                  ),
                  Expanded(
                      child: Container(
                    child: TabBarView(children: [
                      Container(
                        child: OrderRequest(),
                      ),
                      Container(
                        child: OrderStatus(),
                      )
                    ]),
                  ))
                ],
              )),
          //   Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[const Text('Supplier Orders')],
          //   ),
          // )
        ));
  }
}
