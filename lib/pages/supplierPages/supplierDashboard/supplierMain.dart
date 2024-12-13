import 'package:flutter/material.dart';

class SupplierMain extends StatefulWidget {
  const SupplierMain({super.key});

  @override
  State<SupplierMain> createState() => _SupplierMainState();
}

class _SupplierMainState extends State<SupplierMain> {
  @override
  Widget build(BuildContext content) {
    return Scaffold(
      // appBar: AppBar(centerTitle: true, title: Text('Main')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const Text('Supplier Dashboard Main')],
        ),
      ),
    );
  }
}
