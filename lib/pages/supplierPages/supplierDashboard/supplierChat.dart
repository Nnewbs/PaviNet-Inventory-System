import 'package:flutter/material.dart';

class SupplierChat extends StatefulWidget {
  const SupplierChat({super.key});

  @override
  State<SupplierChat> createState() => _SupplierChatState();
}

class _SupplierChatState extends State<SupplierChat> {
  @override
  Widget build(BuildContext content) {
    return Scaffold(
      // appBar: AppBar(centerTitle: true, title: Text('Main')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const Text('Supplier Dashboard Chat')],
        ),
      ),
    );
  }
}
