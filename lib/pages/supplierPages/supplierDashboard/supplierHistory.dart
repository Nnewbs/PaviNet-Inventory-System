import 'package:flutter/material.dart';

class SupplierHistory extends StatefulWidget {
  const SupplierHistory({super.key});

  @override
  State<SupplierHistory> createState() => _SupplierHistoryState();
}

class _SupplierHistoryState extends State<SupplierHistory> {
  @override
  Widget build(BuildContext content) {
    return Scaffold(
      // appBar: AppBar(centerTitle: true, title: Text('Main')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const Text('Supplier Dashboard History')],
        ),
      ),
    );
  }
}
