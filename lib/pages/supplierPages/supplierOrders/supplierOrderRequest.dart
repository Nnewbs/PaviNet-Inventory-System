import 'package:flutter/material.dart';

class SupplierOrderRequest extends StatefulWidget {
  const SupplierOrderRequest({super.key});

  @override
  State<SupplierOrderRequest> createState() => _OrderRequestState();
}

class _OrderRequestState extends State<SupplierOrderRequest> {
  @override
  Widget build(BuildContext content) {
    return Scaffold(
      // appBar: AppBar(centerTitle: true, title: Text('Main')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const Text('Supplier Order Request')],
        ),
      ),
    );
  }
}
